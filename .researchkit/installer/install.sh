#!/usr/bin/env bash
# install.sh - ResearchKit CLI Installer
#
# Install ResearchKit to enable research workflows with Claude Code

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
FORCE_INSTALL=false
NONINTERACTIVE=false
SKIP_COMMANDS=false

# =============================================================================
# ARGUMENT PARSING (T027)
# =============================================================================

show_help() {
    cat <<EOF
ResearchKit Installer

USAGE:
    ./install.sh [OPTIONS] [TARGET_DIR]

OPTIONS:
    --force              Overwrite existing installation without prompting
    --noninteractive     Skip all prompts (use defaults)
    --no-commands        Skip Claude Code command installation
    --version VERSION    Install specific version (default: $VERSION)
    --help               Show this help message

ARGUMENTS:
    TARGET_DIR          Installation directory (default: $DEFAULT_INSTALL_DIR)

EXAMPLES:
    ./install.sh
    ./install.sh --force
    ./install.sh ~/my-researchkit
    ./install.sh --no-commands ~/.researchkit

EOF
}

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --force)
                FORCE_INSTALL=true
                shift
                ;;
            --noninteractive)
                NONINTERACTIVE=true
                shift
                ;;
            --no-commands)
                SKIP_COMMANDS=true
                shift
                ;;
            --version)
                VERSION="$2"
                shift 2
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
# FRIENDLY MESSAGING (T037-T043)
# =============================================================================

show_welcome() {
    echo ""
    ohai "Welcome to ResearchKit! 🔬"
    echo ""
    info "I'll set up ResearchKit on your computer - this takes about 1 minute."
    echo ""
}

show_platform_detection() {
    local os
    os="$(detect_os)"

    case "$os" in
        macos)
            info "I see you're on macOS - perfect!"
            ;;
        linux)
            info "I see you're on Linux - great!"
            ;;
        windows)
            info "I see you're on Windows WSL - excellent!"
            ;;
        *)
            info "I see you're on $os"
            ;;
    esac
    echo ""
}

show_completion() {
    echo ""
    ohai "All done! 🎉"
    echo ""
    info "Next steps:"
    info "  1. Open any folder where you want to do research"
    info "  2. Type: /rk-init"
    info "  3. Start researching with: /rk-research"
    echo ""
    info "Your ResearchKit commands:"
    info "  • /rk-init - Start researching in current folder"
    info "  • /rk-research - Deep research workflow"
    info "  • /rk-validate - Check installation health"
    echo ""
    info "Learn more: ~/.researchkit/docs/getting-started.md"
    echo ""
}

# =============================================================================
# INSTALLATION FUNCTIONS
# =============================================================================

check_prerequisites() {
    # We don't require any specific tools for basic installation
    # Shell and basic POSIX utilities are sufficient
    :
}

check_existing_installation() {
    local existing
    existing="$(detect_existing_install "$INSTALL_DIR")"

    if [ "$existing" = "found" ]; then
        if [ "$FORCE_INSTALL" = true ]; then
            warn "Existing installation found - overwriting due to --force flag"
            return 0
        fi

        if [ "$NONINTERACTIVE" = false ]; then
            echo ""
            ohai "I found an existing installation from $(get_installed_version "$INSTALL_DIR")"
            echo ""
            info "Would you like to:"
            info "  [U] Update to the latest version"
            info "  [K] Keep your current installation"
            info "  [C] Cancel"
            echo ""
            read -r -p "Your choice (U/K/C): " choice

            case "${choice,,}" in
                u|update)
                    info "Great! I'll update ResearchKit for you."
                    # Note: Full update logic will be in update.sh
                    return 0
                    ;;
                k|keep)
                    info "Keeping your current installation. Goodbye!"
                    exit 0
                    ;;
                c|cancel|*)
                    info "Installation cancelled."
                    exit 30
                    ;;
            esac
        else
            warn "Existing installation found - skipping in non-interactive mode"
            exit 0
        fi
    fi
}

create_directory_structure() {
    ohai "Setting up your research workspace..."

    # Create main directories
    mkdir -p "$INSTALL_DIR"/{installer,templates,commands,docs}

    # Verify directories were created
    for dir in installer templates commands docs; do
        if [ ! -d "$INSTALL_DIR/$dir" ]; then
            abort "Failed to create directory: $INSTALL_DIR/$dir"
        fi
    done
}

copy_templates() {
    local source_dir="$RESEARCHKIT_ROOT/.researchkit/templates"
    local dest_dir="$INSTALL_DIR/templates"
    local count=0

    for template in "$source_dir"/*.md; do
        if [ -f "$template" ]; then
            cp "$template" "$dest_dir/"
            ((count++)) || true
        fi
    done

    if [ "$count" -eq 0 ]; then
        abort "No template files found in $source_dir"
    fi

    success "Research templates installed ($count templates ready to use)"
}

copy_commands() {
    local source_dir="$RESEARCHKIT_ROOT/.researchkit/commands"
    local dest_dir="$INSTALL_DIR/commands"
    local count=0

    for command in "$source_dir"/*.md; do
        if [ -f "$command" ]; then
            cp "$command" "$dest_dir/"
            ((count++)) || true
        fi
    done

    if [ "$count" -eq 0 ]; then
        abort "No command files found in $source_dir"
    fi

    success "Commands ready to use ($count research commands)"
}

install_claude_code_commands() {
    if [ "$SKIP_COMMANDS" = true ]; then
        info "Skipping Claude Code command installation (--no-commands flag)"
        return 0
    fi

    local claude_commands_dir="$HOME/.claude/commands"

    # Check if Claude Code is installed
    if [ ! -d "$HOME/.claude" ]; then
        warn "I couldn't find Claude Code on your system."
        info "ResearchKit commands are installed locally - you'll need to install Claude Code to use them."
        info ""
        info "After installing Claude Code, run this installer again to enable the commands."
        return 0
    fi

    # Create .claude/commands directory if it doesn't exist
    mkdir -p "$claude_commands_dir"

    # Copy all commands
    local count=0
    for command in "$INSTALL_DIR/commands"/rk-*.md; do
        if [ -f "$command" ]; then
            cp "$command" "$claude_commands_dir/"
            ((count++)) || true
        fi
    done

    success "Claude Code integration complete"
}

copy_installer_scripts() {
    local source_dir="$SCRIPT_DIR"
    local dest_dir="$INSTALL_DIR/installer"

    for script in "$source_dir"/*.sh; do
        if [ -f "$script" ]; then
            cp "$script" "$dest_dir/"
            chmod +x "$dest_dir/$(basename "$script")"
        fi
    done
}

copy_documentation() {
    local source_dir="$RESEARCHKIT_ROOT/.researchkit/docs"
    local dest_dir="$INSTALL_DIR/docs"

    for doc in "$source_dir"/*.md; do
        if [ -f "$doc" ]; then
            cp "$doc" "$dest_dir/"
        fi
    done

    success "Documentation added"
}

create_version_file() {
    echo "$VERSION" > "$INSTALL_DIR/.researchkit_version"
}

create_metadata_file() {
    cat > "$INSTALL_DIR/.install_metadata" <<EOF
{
  "version": "$VERSION",
  "installed_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "install_dir": "$INSTALL_DIR",
  "os": "$(detect_os)",
  "arch": "$(detect_arch)"
}
EOF
}

create_manifest_file() {
    local manifest="$INSTALL_DIR/.install_manifest"

    {
        echo "# ResearchKit Installation Manifest"
        echo "# Generated: $(date)"
        echo ""

        # Checksum all installed files
        find "$INSTALL_DIR" -type f \( -name "*.md" -o -name "*.sh" \) | while read -r file; do
            local checksum
            checksum="$(checksum_file "$file")"
            local rel_path="${file#$INSTALL_DIR/}"
            echo "$checksum  $rel_path"
        done
    } > "$manifest"
}

create_config_file() {
    cat > "$INSTALL_DIR/config.yaml" <<EOF
# ResearchKit Configuration
version: $VERSION
install_dir: $INSTALL_DIR

# Feature toggles
features:
  claude_integration: true
  auto_update: false

# Default settings
defaults:
  verbose: false
EOF
}

# =============================================================================
# MAIN INSTALLATION FLOW
# =============================================================================

main() {
    # Setup error handling
    trap 'error_handler "$LINENO" "$BASH_LINENO" "$BASH_COMMAND" "$?"' ERR

    # Parse command-line arguments
    parse_arguments "$@"

    # Show friendly welcome
    show_welcome
    show_platform_detection

    # Pre-flight checks
    check_prerequisites
    check_existing_installation

    # Check write permissions
    if ! is_writable "$(dirname "$INSTALL_DIR")"; then
        abort "Cannot write to $(dirname "$INSTALL_DIR"). Please check permissions." 2
    fi

    # Perform installation
    create_directory_structure
    copy_templates
    copy_commands
    copy_installer_scripts
    install_claude_code_commands
    copy_documentation

    # Create metadata files
    create_version_file
    create_metadata_file
    create_manifest_file
    create_config_file

    # Show completion message
    show_completion
}

# Run main if executed directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi
