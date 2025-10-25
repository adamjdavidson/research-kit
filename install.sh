#!/usr/bin/env bash
# ResearchKit Installer
# Simple wrapper that calls the real installer

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run the actual installer, passing through all arguments
exec "$SCRIPT_DIR/.researchkit/installer/install.sh" "$@"
