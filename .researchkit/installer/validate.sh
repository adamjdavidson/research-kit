#!/usr/bin/env bash
# validate.sh - ResearchKit Installation Validator
#
# Verify ResearchKit installation integrity and health

set -Eeuo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common utilities
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

# =============================================================================
# CONFIGURATION
# =============================================================================

DEFAULT_INSTALL_DIR="$HOME/.researchkit"
INSTALL_DIR=""
QUIET_MODE=false
JSON_OUTPUT=false
FIX_MODE=true  # Auto-fix by default per spec
EXIT_CODE=0

# Validation results
declare -a CHECK_RESULTS=()
declare -a ISSUES_FOUND=()
declare -a FIXES_APPLIED=()

# Expected files
EXPECTED_TEMPLATES=(
    "CLAUDE-template.md"
    "constitution-template.md"
    "framework-template.md"
    "question-template.md"
    "research-path-template.md"
    "story-template.md"
)

EXPECTED_COMMANDS=(
    "rk-capture-story.md"
    "rk-collect-documents.md"
    "rk-constitution.md"
    "rk-create-stream.md"
    "rk-cross-stream.md"
    "rk-find-stories.md"
    "rk-frameworks.md"
    "rk-identify-paths.md"
    "rk-init.md"
    "rk-question.md"
    "rk-research.md"
    "rk-validate.md"
    "rk-write.md"
)

# =============================================================================
# ARGUMENT PARSING
# =============================================================================

show_help() {
    cat <<EOF
ResearchKit Installation Validator

USAGE:
    ./validate.sh [OPTIONS] [INSTALL_DIR]

OPTIONS:
    --quiet         Suppress detailed output, show only errors
    --json          Output results as JSON
    --no-fix        Don't attempt to fix issues automatically
    --help          Show this help message

ARGUMENTS:
    INSTALL_DIR     Installation directory to validate (default: $DEFAULT_INSTALL_DIR)

EXAMPLES:
    ./validate.sh
    ./validate.sh --json
    ./validate.sh ~/.researchkit

EOF
}

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --quiet)
                QUIET_MODE=true
                shift
                ;;
            --json)
                JSON_OUTPUT=true
                shift
                ;;
            --no-fix)
                FIX_MODE=false
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
# VALIDATION CHECKS
# =============================================================================

check_directory_structure() {
    local check_name="directory_structure"
    local required_dirs=("installer" "templates" "commands" "docs")
    local missing_dirs=()

    for dir in "${required_dirs[@]}"; do
        if [ ! -d "$INSTALL_DIR/$dir" ]; then
            missing_dirs+=("$dir")
        fi
    done

    if [ ${#missing_dirs[@]} -eq 0 ]; then
        CHECK_RESULTS+=("$check_name:pass:All required directories exist")
        return 0
    else
        CHECK_RESULTS+=("$check_name:fail:Missing directories: ${missing_dirs[*]}")
        ISSUES_FOUND+=("Missing directories: ${missing_dirs[*]}")
        EXIT_CODE=1
        return 1
    fi
}

check_templates() {
    local check_name="templates"
    local missing_templates=()
    local found_count=0

    for template in "${EXPECTED_TEMPLATES[@]}"; do
        if [ -f "$INSTALL_DIR/templates/$template" ]; then
            ((found_count++)) || true
        else
            missing_templates+=("$template")
        fi
    done

    if [ ${#missing_templates[@]} -eq 0 ]; then
        CHECK_RESULTS+=("$check_name:pass:All templates present (${#EXPECTED_TEMPLATES[@]}/${#EXPECTED_TEMPLATES[@]})")
        return 0
    else
        # Try to fix if enabled
        if [ "$FIX_MODE" = true ]; then
            fix_missing_templates "${missing_templates[@]}"

            # Re-check what's still missing
            local still_missing=()
            for template in "${missing_templates[@]}"; do
                if [ ! -f "$INSTALL_DIR/templates/$template" ]; then
                    still_missing+=("$template")
                fi
            done

            if [ ${#still_missing[@]} -eq 0 ]; then
                # All fixed!
                CHECK_RESULTS+=("$check_name:fixed:All templates restored (${#EXPECTED_TEMPLATES[@]}/${#EXPECTED_TEMPLATES[@]})")
                return 0
            else
                # Couldn't fix everything
                local fixed_count=$((${#missing_templates[@]} - ${#still_missing[@]}))
                local now_found=$((found_count + fixed_count))
                CHECK_RESULTS+=("$check_name:fail:Missing templates ($now_found/${#EXPECTED_TEMPLATES[@]})")
                ISSUES_FOUND+=("Missing templates: ${still_missing[*]}")
                EXIT_CODE=1
                return 1
            fi
        else
            # Not fixing, just report
            CHECK_RESULTS+=("$check_name:fail:Missing templates ($found_count/${#EXPECTED_TEMPLATES[@]})")
            ISSUES_FOUND+=("Missing templates: ${missing_templates[*]}")
            EXIT_CODE=1
            return 1
        fi
    fi
}

check_commands() {
    local check_name="commands"
    local missing_commands=()
    local found_count=0

    for command in "${EXPECTED_COMMANDS[@]}"; do
        if [ -f "$INSTALL_DIR/commands/$command" ]; then
            ((found_count++)) || true
        else
            missing_commands+=("$command")
        fi
    done

    if [ ${#missing_commands[@]} -eq 0 ]; then
        CHECK_RESULTS+=("$check_name:pass:All commands present (${#EXPECTED_COMMANDS[@]}/${#EXPECTED_COMMANDS[@]})")
        return 0
    else
        CHECK_RESULTS+=("$check_name:fail:Missing commands ($found_count/${#EXPECTED_COMMANDS[@]})")
        ISSUES_FOUND+=("Missing commands: ${missing_commands[*]}")
        EXIT_CODE=1
        return 1
    fi
}

check_claude_integration() {
    local check_name="claude_integration"
    local claude_dir="$HOME/.claude/commands"
    local missing_in_claude=()

    # Check if Claude Code directory exists
    if [ ! -d "$HOME/.claude" ]; then
        CHECK_RESULTS+=("$check_name:warn:Claude Code not found")
        info "⚠️  Your ResearchKit commands aren't connected to Claude Code yet."
        return 0
    fi

    # Check if commands are in Claude Code
    for command in "${EXPECTED_COMMANDS[@]}"; do
        if [ ! -f "$claude_dir/$command" ]; then
            missing_in_claude+=("$command")
        fi
    done

    if [ ${#missing_in_claude[@]} -eq 0 ]; then
        CHECK_RESULTS+=("$check_name:pass:Commands found in .claude/commands/")
        return 0
    else
        CHECK_RESULTS+=("$check_name:warn:Some commands missing in Claude Code")
        ISSUES_FOUND+=("Commands not in Claude Code: ${missing_in_claude[*]}")
        return 0  # Warning, not error
    fi
}

check_permissions() {
    local check_name="permissions"
    local non_executable=()
    local installer_scripts=("install.sh" "validate.sh" "update.sh")

    for script in "${installer_scripts[@]}"; do
        if [ -f "$INSTALL_DIR/installer/$script" ]; then
            if [ ! -x "$INSTALL_DIR/installer/$script" ]; then
                non_executable+=("installer/$script")
            fi
        fi
    done

    if [ ${#non_executable[@]} -eq 0 ]; then
        CHECK_RESULTS+=("$check_name:pass:All file permissions correct")
        return 0
    else
        # Try to fix if enabled
        if [ "$FIX_MODE" = true ]; then
            fix_permissions "${non_executable[@]}"

            # Re-check if fixes worked
            local still_broken=()
            for file in "${non_executable[@]}"; do
                if [ ! -x "$INSTALL_DIR/$file" ]; then
                    still_broken+=("$file")
                fi
            done

            if [ ${#still_broken[@]} -eq 0 ]; then
                # All fixed!
                CHECK_RESULTS+=("$check_name:fixed:File permissions corrected")
                return 0
            else
                # Couldn't fix everything
                CHECK_RESULTS+=("$check_name:fail:File permission issues")
                ISSUES_FOUND+=("Couldn't fix permissions: ${still_broken[*]}")
                EXIT_CODE=1
                return 1
            fi
        else
            # Not fixing, just report
            CHECK_RESULTS+=("$check_name:fail:File permission issues")
            ISSUES_FOUND+=("Not executable: ${non_executable[*]}")
            EXIT_CODE=1
            return 1
        fi
    fi
}

# =============================================================================
# AUTO-FIX FUNCTIONS
# =============================================================================

fix_missing_templates() {
    local templates=("$@")
    local source_dir

    # Try to find source templates in parent directory
    if [ -d "$INSTALL_DIR/../.researchkit/templates" ]; then
        source_dir="$INSTALL_DIR/../.researchkit/templates"
    else
        return 1
    fi

    for template in "${templates[@]}"; do
        if [ -f "$source_dir/$template" ]; then
            cp "$source_dir/$template" "$INSTALL_DIR/templates/" 2>/dev/null && \
                FIXES_APPLIED+=("Restored $template from backup")
        fi
    done
}

fix_permissions() {
    local files=("$@")

    for file in "${files[@]}"; do
        chmod +x "$INSTALL_DIR/$file" 2>/dev/null && \
            FIXES_APPLIED+=("Made $file executable")
    done
}

# =============================================================================
# OUTPUT FUNCTIONS
# =============================================================================

show_friendly_output() {
    echo ""
    ohai "Checking your ResearchKit installation... 🔍"
    echo ""

    # Check if we had issues
    if [ ${#ISSUES_FOUND[@]} -eq 0 ] && [ ${#FIXES_APPLIED[@]} -eq 0 ]; then
        # All good!
        success "Everything looks great!"
        success "All ${#EXPECTED_TEMPLATES[@]} templates are ready"
        success "All ${#EXPECTED_COMMANDS[@]} commands are working"
        success "Claude Code integration is perfect"
        echo ""
        ohai "ResearchKit is ready to use! 🎉"
        echo ""
        info "Your commands:"
        info "  • /rk-init - Start researching in current folder"
        info "  • /rk-research - Deep research workflow"
        info "  • /rk-validate - Check installation health"
        echo ""
        info "Try it out - type /rk-init to get started!"
        echo ""
    elif [ ${#FIXES_APPLIED[@]} -gt 0 ]; then
        # We fixed some issues
        success "I found a couple of small issues, so I fixed them for you!"
        echo ""
        for fix in "${FIXES_APPLIED[@]}"; do
            success "$fix"
        done
        echo ""
        ohai "Everything is working now! 🎉"
        echo ""
        info "What I fixed:"
        for fix in "${FIXES_APPLIED[@]}"; do
            info "  • $fix"
        done
        echo ""
        info "You're all set - ResearchKit is ready to use!"
        echo ""
    else
        # Errors we couldn't fix
        error "Oops! I found some issues with your ResearchKit installation. 😕"
        echo ""
        info "What's wrong:"
        for issue in "${ISSUES_FOUND[@]}"; do
            error "  ✗ $issue"
        done
        echo ""
        info "Don't worry - your research data is safe!"
        echo ""
        info "How to fix it:"
        info "  1. Run the installer again to restore missing files:"
        info "     ./install.sh"
        echo ""
        info "  2. Or if that doesn't work, do a fresh install:"
        info "     ./install.sh --force"
        echo ""
    fi
}

show_json_output() {
    local timestamp
    timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

    local overall_status="healthy"
    if [ $EXIT_CODE -ne 0 ]; then
        overall_status="errors"
    elif [ ${#FIXES_APPLIED[@]} -gt 0 ]; then
        overall_status="fixed"
    fi

    cat <<EOF
{
  "timestamp": "$timestamp",
  "installation_dir": "$INSTALL_DIR",
  "overall_status": "$overall_status",
  "checks": [
EOF

    local first=true
    for result in "${CHECK_RESULTS[@]}"; do
        IFS=':' read -r name status message <<< "$result"

        if [ "$first" = false ]; then
            echo ","
        fi
        first=false

        cat <<EOF
    {
      "name": "$name",
      "status": "$status",
      "message": "$message"
    }
EOF
    done

    cat <<EOF

  ],
  "issues_found": $([ ${#ISSUES_FOUND[@]} -eq 0 ] && echo "[]" || printf '["%s"]' "${ISSUES_FOUND[@]}"),
  "fixes_applied": $([ ${#FIXES_APPLIED[@]} -eq 0 ] && echo "[]" || printf '["%s"]' "${FIXES_APPLIED[@]}")
}
EOF
}

# =============================================================================
# MAIN VALIDATION FLOW
# =============================================================================

main() {
    # Parse command-line arguments
    parse_arguments "$@"

    # Check if installation exists
    if [ ! -d "$INSTALL_DIR" ]; then
        if [ "$JSON_OUTPUT" = true ]; then
            echo '{"error": "Installation not found", "path": "'"$INSTALL_DIR"'"}'
        else
            abort "ResearchKit installation not found at: $INSTALL_DIR" 2
        fi
    fi

    # Run validation checks (don't exit on check failures)
    check_directory_structure || true
    check_templates || true
    check_commands || true
    check_claude_integration || true
    check_permissions || true

    # Display results
    if [ "$JSON_OUTPUT" = true ]; then
        show_json_output
    elif [ "$QUIET_MODE" = false ]; then
        show_friendly_output
    fi

    exit $EXIT_CODE
}

# Run main if executed directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi
