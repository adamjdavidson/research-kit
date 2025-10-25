#!/usr/bin/env bash
# common.sh - Shared utility functions for ResearchKit installer
#
# This file provides common functions used across install.sh, validate.sh, and update.sh
# Source this file at the beginning of each installer script

set -Eeuo pipefail

# =============================================================================
# ERROR HANDLING FUNCTIONS (T009)
# =============================================================================

# Global error handler - called on ERR trap
error_handler() {
    local line_no=$1
    local bash_lineno=$2
    local last_command=$3
    local code=$4

    echo "" >&2
    echo "❌ Error occurred in script execution:" >&2
    echo "  Line: $line_no" >&2
    echo "  Command: $last_command" >&2
    echo "  Exit code: $code" >&2
    echo "" >&2
}

# Abort with error message and exit code
abort() {
    local message="$1"
    local exit_code="${2:-1}"

    echo "" >&2
    echo "❌ $message" >&2
    echo "" >&2
    exit "$exit_code"
}

# Check if command exists, abort if not found
need_cmd() {
    local cmd="$1"
    local install_hint="${2:-}"

    if ! command -v "$cmd" >/dev/null 2>&1; then
        if [ -n "$install_hint" ]; then
            abort "Required command '$cmd' not found. Install it with: $install_hint"
        else
            abort "Required command '$cmd' not found. Please install it and try again."
        fi
    fi
}

# =============================================================================
# OUTPUT FUNCTIONS (T010)
# =============================================================================

# Check if we're running in a TTY (for color/emoji support)
is_tty() {
    [ -t 1 ]
}

# Print section header with emoji (only if TTY)
ohai() {
    local message="$1"

    if is_tty; then
        echo "🔬 $message"
    else
        echo "==> $message"
    fi
}

# Print success message
success() {
    local message="$1"

    if is_tty; then
        echo "✓ $message"
    else
        echo "[OK] $message"
    fi
}

# Print warning message
warn() {
    local message="$1"

    if is_tty; then
        echo "⚠️  $message" >&2
    else
        echo "Warning: $message" >&2
    fi
}

# Print error message (non-fatal)
error() {
    local message="$1"

    if is_tty; then
        echo "✗ $message" >&2
    else
        echo "[ERROR] $message" >&2
    fi
}

# Print info message
info() {
    local message="$1"
    echo "$message"
}

# =============================================================================
# PLATFORM DETECTION FUNCTIONS (T011)
# =============================================================================

# Detect operating system
detect_os() {
    local os_name

    case "$(uname -s)" in
        Darwin*)
            os_name="macos"
            ;;
        Linux*)
            os_name="linux"
            ;;
        MINGW*|MSYS*|CYGWIN*)
            os_name="windows"
            ;;
        *)
            os_name="unknown"
            ;;
    esac

    echo "$os_name"
}

# Detect architecture
detect_arch() {
    local arch

    case "$(uname -m)" in
        x86_64|amd64)
            arch="x86_64"
            ;;
        arm64|aarch64)
            arch="arm64"
            ;;
        i386|i686)
            arch="i386"
            ;;
        *)
            arch="unknown"
            ;;
    esac

    echo "$arch"
}

# Detect shell profile file
detect_profile() {
    local profile_file

    if [ -n "${BASH_VERSION:-}" ]; then
        if [ -f "$HOME/.bashrc" ]; then
            profile_file="$HOME/.bashrc"
        elif [ -f "$HOME/.bash_profile" ]; then
            profile_file="$HOME/.bash_profile"
        else
            profile_file="$HOME/.profile"
        fi
    elif [ -n "${ZSH_VERSION:-}" ]; then
        profile_file="$HOME/.zshrc"
    else
        # Default to .profile for other shells
        profile_file="$HOME/.profile"
    fi

    echo "$profile_file"
}

# =============================================================================
# IDEMPOTENCY HELPER FUNCTIONS (T012)
# =============================================================================

# Detect existing ResearchKit installation
detect_existing_install() {
    local install_dir="${1:-$HOME/.researchkit}"

    if [ -d "$install_dir" ] && [ -f "$install_dir/.researchkit_version" ]; then
        echo "found"
    else
        echo "not_found"
    fi
}

# Get version from existing installation
get_installed_version() {
    local install_dir="${1:-$HOME/.researchkit}"
    local version_file="$install_dir/.researchkit_version"

    if [ -f "$version_file" ]; then
        cat "$version_file"
    else
        echo "unknown"
    fi
}

# Create backup of existing installation
backup_if_exists() {
    local install_dir="$1"
    local backup_suffix="${2:-$(date +%Y%m%d_%H%M%S)}"
    local backup_dir="${install_dir}.backup.${backup_suffix}"

    if [ -d "$install_dir" ]; then
        if cp -R "$install_dir" "$backup_dir" 2>/dev/null; then
            echo "$backup_dir"
            return 0
        else
            abort "Failed to create backup at: $backup_dir"
        fi
    fi

    echo ""
}

# Check if directory is writable
is_writable() {
    local dir="$1"

    if [ -d "$dir" ]; then
        [ -w "$dir" ]
    else
        # Check parent directory
        local parent
        parent="$(dirname "$dir")"
        [ -w "$parent" ]
    fi
}

# =============================================================================
# FILE OPERATIONS
# =============================================================================

# Calculate SHA256 checksum of a file
checksum_file() {
    local file="$1"

    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum "$file" | awk '{print $1}'
    elif command -v shasum >/dev/null 2>&1; then
        shasum -a 256 "$file" | awk '{print $1}'
    else
        # Fallback: just use file size as pseudo-checksum
        wc -c < "$file"
    fi
}

# Check if file has been modified (checksum mismatch)
file_modified() {
    local file="$1"
    local expected_checksum="$2"
    local actual_checksum

    if [ ! -f "$file" ]; then
        return 1  # File doesn't exist, treat as modified
    fi

    actual_checksum="$(checksum_file "$file")"

    [ "$actual_checksum" != "$expected_checksum" ]
}

# =============================================================================
# INITIALIZATION
# =============================================================================

# Export functions for use in scripts
export -f error_handler abort need_cmd
export -f ohai success warn error info is_tty
export -f detect_os detect_arch detect_profile
export -f detect_existing_install get_installed_version backup_if_exists is_writable
export -f checksum_file file_modified
