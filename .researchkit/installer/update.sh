#!/usr/bin/env bash
# update.sh - ResearchKit Updater
#
# Update existing ResearchKit installation while preserving customizations

set -Eeuo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RESEARCHKIT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source common utilities
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

# =============================================================================
# CONFIGURATION
# =============================================================================

VERSION="1.0.0"
DEFAULT_INSTALL_DIR="$HOME/.researchkit"
INSTALL_DIR=""
TARGET_VERSION="$VERSION"
NO_BACKUP=false
NONINTERACTIVE=false
BACKUP_DIR=""

# =============================================================================
# ARGUMENT PARSING
# =============================================================================

show_help() {
    cat <<EOF
ResearchKit Updater

USAGE:
    ./update.sh [OPTIONS] [INSTALL_DIR]

OPTIONS:
    --version VERSION    Update to specific version (default: latest)
    --no-backup          Skip creating backup before update
    --noninteractive     Skip all prompts (use defaults)
    --help               Show this help message

ARGUMENTS:
    INSTALL_DIR         Installation directory to update (default: $DEFAULT_INSTALL_DIR)

EXAMPLES:
    ./update.sh
    ./update.sh --version 1.1.0
    ./update.sh ~/.researchkit

EOF
}

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --version)
                TARGET_VERSION="$2"
                shift 2
                ;;
            --no-backup)
                NO_BACKUP=true
                shift
                ;;
            --noninteractive)
                NONINTERACTIVE=true
                shift
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            -*)
                abort "Unknown option: $1" 10
                ;;
            *)
                INSTALL_DIR="$1"
                shift
                ;;
        esac
    done

    # Use default install directory if not specified
    if [ -z "$INSTALL_DIR" ]; then
        INSTALL_DIR="${RESEARCHKIT_DIR:-$DEFAULT_INSTALL_DIR}"
    fi
}

# =============================================================================
# VERSION MANAGEMENT
# =============================================================================

get_current_version() {
    local version_file="$INSTALL_DIR/.researchkit_version"

    if [ -f "$version_file" ]; then
        cat "$version_file"
    else
        echo "unknown"
    fi
}

compare_versions() {
    local current="$1"
    local target="$2"

    if [ "$current" = "$target" ]; then
        echo "equal"
    elif [ "$current" = "unknown" ]; then
        echo "upgrade"
    else
        echo "upgrade"  # Simplified: assume any difference is an upgrade
    fi
}

# =============================================================================
# UPDATE FUNCTIONS
# =============================================================================

check_existing_installation() {
    if [ ! -d "$INSTALL_DIR" ]; then
        echo ""
        error "Hmm, I couldn't find ResearchKit on your computer. 😕"
        echo ""
        info "What happened:"
        info "  I looked for ResearchKit at $INSTALL_DIR but it's not there yet."
        echo ""
        info "Why this happened:"
        info "  ResearchKit hasn't been installed on this computer yet, or it was"
        info "  installed somewhere else."
        echo ""
        info "How to fix it:"
        info "  1. Install ResearchKit first by running:"
        info "     ./install.sh"
        echo ""
        info "  2. Or, if you installed it somewhere else, tell me where:"
        info "     ./update.sh /path/to/your/.researchkit"
        echo ""
        exit 2
    fi
}

create_backup() {
    if [ "$NO_BACKUP" = true ]; then
        info "Skipping backup (--no-backup specified)"
        return 0
    fi

    local backup_suffix
    backup_suffix="$(date +%Y%m%d_%H%M%S)"
    BACKUP_DIR="${INSTALL_DIR}.backup.${backup_suffix}"

    info "First, I'll make a backup of everything (just to be safe)..."

    if cp -R "$INSTALL_DIR" "$BACKUP_DIR" 2>/dev/null; then
        success "Backup created - your current setup is saved"
        return 0
    else
        echo ""
        error "Oops! I ran into a problem while updating ResearchKit. 😕"
        echo ""
        info "What happened:"
        info "  I couldn't create a backup of your current ResearchKit."
        echo ""
        info "Why this happened:"
        info "  Your computer's disk might be full, or there might be a permissions issue."
        echo ""
        info "The good news:"
        info "  I didn't make any changes, so your current ResearchKit is exactly as it was."
        echo ""
        info "How to fix it:"
        info "  1. Check if you have space on your computer:"
        info "     • Open Finder → About This Mac → Storage"
        info "     • You need at least 10 MB free for the backup"
        echo ""
        info "  2. If you have space, try checking file permissions:"
        info "     • Run: ls -la ~/.researchkit"
        echo ""
        info "  3. If you're sure everything's fine, you can skip the backup:"
        info "     • Run: ./update.sh --no-backup"
        info "     • (Not recommended - backups keep you safe!)"
        echo ""
        exit 10
    fi
}

update_installer_scripts() {
    local source_dir="$RESEARCHKIT_ROOT/.researchkit/installer"
    local dest_dir="$INSTALL_DIR/installer"
    local updated_count=0

    for script in "$source_dir"/*.sh; do
        if [ -f "$script" ]; then
            local filename
            filename="$(basename "$script")"
            cp "$script" "$dest_dir/$filename"
            chmod +x "$dest_dir/$filename"
            ((updated_count++)) || true
        fi
    done

    return 0
}

update_commands() {
    local source_dir="$RESEARCHKIT_ROOT/.researchkit/commands"
    local dest_dir="$INSTALL_DIR/commands"
    local claude_dir="$HOME/.claude/commands"
    local updated_count=0

    # Update commands in installation directory
    for command in "$source_dir"/*.md; do
        if [ -f "$command" ]; then
            local filename
            filename="$(basename "$command")"
            cp "$command" "$dest_dir/$filename"
            ((updated_count++)) || true

            # Also update in Claude Code if it exists
            if [ -d "$claude_dir" ]; then
                cp "$command" "$claude_dir/$filename"
            fi
        fi
    done

    echo "$updated_count"
    return 0
}

update_templates() {
    local source_dir="$RESEARCHKIT_ROOT/.researchkit/templates"
    local dest_dir="$INSTALL_DIR/templates"
    local manifest="$INSTALL_DIR/.install_manifest"
    local updated_count=0
    local preserved_count=0

    for template in "$source_dir"/*.md; do
        if [ -f "$template" ]; then
            local filename
            filename="$(basename "$template")"
            local dest_file="$dest_dir/$filename"

            # Check if user has modified this template
            if [ -f "$dest_file" ] && [ -f "$manifest" ]; then
                local original_checksum
                original_checksum=$(grep " templates/$filename$" "$manifest" 2>/dev/null | awk '{print $1}' || echo "")

                if [ -n "$original_checksum" ]; then
                    local current_checksum
                    current_checksum="$(checksum_file "$dest_file")"

                    if [ "$current_checksum" != "$original_checksum" ]; then
                        # User modified - preserve it
                        ((preserved_count++)) || true
                        continue
                    fi
                fi
            fi

            # Not modified or doesn't exist - update it
            cp "$template" "$dest_file"
            ((updated_count++)) || true
        fi
    done

    echo "$updated_count:$preserved_count"
}

update_documentation() {
    local source_dir="$RESEARCHKIT_ROOT/.researchkit/docs"
    local dest_dir="$INSTALL_DIR/docs"

    for doc in "$source_dir"/*.md; do
        if [ -f "$doc" ]; then
            local filename
            filename="$(basename "$doc")"
            cp "$doc" "$dest_dir/$filename"
        fi
    done
}

update_version_file() {
    echo "$TARGET_VERSION" > "$INSTALL_DIR/.researchkit_version"
}

update_metadata_file() {
    local metadata="$INSTALL_DIR/.install_metadata"

    # Read existing metadata and update it
    if [ -f "$metadata" ]; then
        # Simple update: just update the version and add last_updated
        cat > "$metadata" <<EOF
{
  "version": "$TARGET_VERSION",
  "installed_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "last_updated": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "install_dir": "$INSTALL_DIR",
  "os": "$(detect_os)",
  "arch": "$(detect_arch)"
}
EOF
    fi
}

# =============================================================================
# FRIENDLY MESSAGING
# =============================================================================

show_update_intro() {
    local current_version="$1"

    echo ""
    ohai "Great news! I found some updates for ResearchKit. 🔬"
    echo ""
    info "I'll update ResearchKit for you - this will only take a moment."
    info "Your research files are safe and won't be touched."
    echo ""
    info "I see you're on version $current_version, and I'll update you to $TARGET_VERSION."
    echo ""
}

show_already_up_to_date() {
    echo ""
    ohai "Checking for ResearchKit updates... 🔍"
    echo ""
    success "Good news - you're already on the latest version! ✓"
    echo ""
    info "Your ResearchKit is up to date (version $VERSION)."
    info "No updates needed right now."
    echo ""
    ohai "Keep researching! 🎉"
    echo ""
}

show_update_completion() {
    local template_results="$1"
    local commands_updated="$2"

    IFS=':' read -r templates_updated templates_preserved <<< "$template_results"

    echo ""
    ohai "All done! 🎉"
    echo ""
    info "What changed:"
    info "  • $templates_updated templates got new features"
    if [ "$templates_preserved" -gt 0 ]; then
        info "  • $templates_preserved templates kept your customizations"
    fi
    info "  • $commands_updated commands updated with improvements"
    echo ""
    if [ -n "$BACKUP_DIR" ]; then
        info "Your backup is here if you need it:"
        info "  $BACKUP_DIR"
        echo ""
    fi
    info "You're all set - happy researching!"
    echo ""
}

# =============================================================================
# MAIN UPDATE FLOW
# =============================================================================

main() {
    # Setup error handling
    trap 'error_handler "$LINENO" "$BASH_LINENO" "$BASH_COMMAND" "$?"' ERR

    # Parse command-line arguments
    parse_arguments "$@"

    # Check if installation exists
    check_existing_installation

    # Get current version
    local current_version
    current_version="$(get_current_version)"

    # Compare versions
    local version_comparison
    version_comparison="$(compare_versions "$current_version" "$TARGET_VERSION")"

    if [ "$version_comparison" = "equal" ]; then
        show_already_up_to_date
        exit 0
    fi

    # Show update intro
    show_update_intro "$current_version"

    # Create backup
    create_backup

    # Perform updates
    ohai "Updating your ResearchKit..."

    local template_results
    template_results="$(update_templates)"

    local commands_updated
    commands_updated="$(update_commands)"

    update_installer_scripts
    update_documentation

    success "Updated installer tools"
    success "Everything synced with Claude Code"

    # Update metadata
    update_version_file
    update_metadata_file

    # Show completion
    show_update_completion "$template_results" "$commands_updated"
}

# Run main if executed directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi
