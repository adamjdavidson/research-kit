# Research: ResearchKit CLI Installer

**Feature**: 001-researchkit-installer
**Date**: 2025-10-25
**Status**: Complete

## Overview

This document captures research findings that inform implementation decisions for the ResearchKit CLI Installer. All NEEDS CLARIFICATION items from the Technical Context have been resolved.

---

## Decision 1: Testing Framework

**Question**: Which Bash testing framework should we use for integration tests?

### Decision: bats-core (Bash Automated Testing System)

### Rationale

1. **Purpose-built for CLI and integration testing**: bats-core excels at testing actual command execution and file system operations through its `run` helper and dedicated `bats-file` assertion library
2. **Excellent cross-platform compatibility**: Works seamlessly on macOS, Linux, WSL, and Git Bash with straightforward installation
3. **Strong ecosystem and active maintenance**: 5,551 GitHub stars, 112+ contributors, actively maintained with recent releases
4. **Rich filesystem assertions**: Dedicated `bats-file` library with `assert_dir_exists`, `assert_file_contains`, `assert_file_permission`, etc.

### Alternatives Considered

- **ShellSpec**: More feature-rich but overkill for our needs. Complex BDD syntax adds unnecessary learning curve. Best for unit testing with mocking requirements.
- **shunit2**: Older framework with difficult installation and limited documentation. Critical limitation: exit status doesn't reflect test failures in older versions.
- **Custom shell integration tests**: No dependencies but requires building test harness from scratch. Time-consuming and difficult to maintain.

### Implementation Notes

- Install via Homebrew on macOS: `brew install bats-core`
- Use git submodules for Linux/WSL to keep tests portable
- Include helper libraries: `bats-support`, `bats-assert`, `bats-file`
- Test files use `.bats` extension
- TAP-compliant output works with CI/CD pipelines

### Getting Started Example

```bash
#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'
load 'test_helper/bats-file/load'

@test "installer creates target directory" {
    run ./install.sh "$TEST_DIR"
    assert_success
    assert_dir_exists "$TEST_DIR/.researchkit"
}

@test "installer copies templates" {
    run ./install.sh "$TEST_DIR"
    assert_success
    assert_file_exists "$TEST_DIR/.researchkit/templates/research-plan.md"
}
```

---

## Decision 2: Shell Script Architecture

**Question**: How should we structure the installer for robustness, cross-platform compatibility, and idempotency?

### Key Principles Adopted

Based on analysis of industry-standard installers (Homebrew, NVM, Rustup), we adopt these core principles:

1. **Idempotency First**: Script must be safe to run multiple times without side effects. Check state before making changes.
2. **Fail Fast with Context**: Exit immediately on errors with clear messages. Use `set -euo pipefail` with trap handlers.
3. **Progressive Disclosure**: Minimal output by default, detailed feedback when needed. Adapt output based on TTY detection.
4. **Platform Awareness**: Detect OS/platform early and adapt behavior (macOS, Linux, WSL).
5. **Non-Destructive by Default**: Detect existing installations, warn before overwriting, provide explicit flags for destructive operations.
6. **Graceful Degradation**: Handle missing dependencies by informing users what's needed.
7. **Single Script Distribution**: Keep installer self-contained but organize internally with clear functions.

### Error Handling Pattern

```bash
#!/usr/bin/env bash
set -Eeuo pipefail

# Error handler with context
error_handler() {
  local line_num="$1"
  local command="$2"
  printf "\nError at line %s: %s\n" "$line_num" "$command" >&2
  exit 1
}

trap 'error_handler ${LINENO} "$BASH_COMMAND"' ERR

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

need_cmd() {
  if ! command -v "$1" &> /dev/null; then
    abort "Required command not found: $1"
  fi
}

execute() {
  if ! "$@"; then
    abort "Failed during: $*"
  fi
}
```

### Progress Feedback Pattern

```bash
# TTY detection for adaptive output
if [[ -t 1 ]]; then
  tty_escape() { printf "\033[%sm" "$1"; }
  tty_bold="$(tty_escape "1")"
  tty_blue="$(tty_escape "34")"
  tty_green="$(tty_escape "32")"
  tty_red="$(tty_escape "31")"
  tty_reset="$(tty_escape "0")"
else
  tty_escape() { :; }
  tty_bold=""
  tty_blue=""
  tty_green=""
  tty_red=""
  tty_reset=""
fi

ohai() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$*"
}

success() {
  printf "${tty_green}✓${tty_reset} %s\n" "$*"
}

warn() {
  printf "${tty_red}Warning${tty_reset}: %s\n" "$*" >&2
}
```

### Idempotency Pattern

```bash
# Detect existing installation
detect_existing_install() {
  if [[ -d "$INSTALL_DIR" ]]; then
    if [[ -f "$INSTALL_DIR/.researchkit_version" ]]; then
      return 0  # Existing installation found
    fi
  fi
  return 1  # No installation
}

# Idempotent file operations
mkdir -p "$INSTALL_DIR"/{templates,commands,cache}
ln -sfn "$SOURCE_DIR/bin/rk" "$HOME/.local/bin/rk"

# Idempotent profile append
PROFILE_LINE='export PATH="$HOME/.researchkit/bin:$PATH"'
if ! grep -qF "$PROFILE_LINE" "$PROFILE_FILE"; then
  printf "\n# ResearchKit\n%s\n" "$PROFILE_LINE" >> "$PROFILE_FILE"
fi
```

### Platform Detection

```bash
detect_os() {
  case "$(uname -s)" in
    Darwin*)
      OS="macos"
      ;;
    Linux*)
      if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null 2>&1; then
        OS="wsl"
      else
        OS="linux"
      fi
      ;;
    *)
      abort "Unsupported operating system: $(uname -s)"
      ;;
  esac
}

detect_profile() {
  local shell_name="${SHELL##*/}"
  case "$shell_name" in
    bash)
      [[ "$OS" == "macos" ]] && PROFILE_FILE="${HOME}/.bash_profile" || PROFILE_FILE="${HOME}/.bashrc"
      ;;
    zsh)
      PROFILE_FILE="${ZDOTDIR:-$HOME}/.zshrc"
      ;;
    fish)
      PROFILE_FILE="${HOME}/.config/fish/config.fish"
      ;;
    *)
      PROFILE_FILE="${HOME}/.profile"
      ;;
  esac
}
```

### Common Pitfalls to Avoid

1. Always quote variables: `"$VAR"` not `$VAR`
2. Check `cd` success: `cd /path || exit 1`
3. Use `mkdir -p` and `ln -sfn` for idempotency
4. Never parse `ls` output - use glob patterns
5. Test with paths containing spaces
6. Run `shellcheck` on all scripts
7. Support `NONINTERACTIVE=1` for CI environments

### Reference Implementations

We draw patterns from these well-written installers:

1. **Homebrew** (https://github.com/Homebrew/install): Error handling, TTY detection, retry mechanisms
2. **NVM** (https://github.com/nvm-sh/nvm): Profile detection, idempotent updates, git-based installation
3. **Rustup** (https://sh.rustup.rs): Architecture detection, dependency validation, temp file handling

---

## Decision 3: Installation Strategy

**Question**: Should we bundle templates/commands or fetch them remotely?

### Decision: Bundled Installation Package

### Rationale

For the MVP (P1), bundle all templates and commands within the installer package distributed as a git repository or tarball. Users clone/download once and run the installer script.

**Pros:**
- Works offline after initial download
- Version consistency (templates match installer version)
- Simpler implementation (no remote fetching logic)
- Faster installation (no network dependencies)
- Easier testing (all files local)

**Cons:**
- Larger download size (~100KB for templates/commands - negligible)
- Updates require re-downloading package (acceptable for P3)

**Implementation:** User runs `git clone https://github.com/user/researchkit.git && cd researchkit && ./install.sh` or downloads tarball and extracts.

### Alternatives Considered

- **Remote fetching**: Fetch templates from GitHub/CDN during installation. Adds complexity, network dependencies, and failure modes. Better suited for P3 (updates).
- **Hybrid approach**: Core installer fetches latest templates. Overengineered for MVP.

---

## Decision 4: Claude Code Integration Strategy

**Question**: Should we symlink or copy commands to `.claude/commands/`?

### Decision: Copy (not symlink) commands during installation

### Rationale

1. **Portability**: Copied files work even if ResearchKit installation directory is moved or deleted
2. **Simplicity**: Users don't need to understand symlinks
3. **Windows compatibility**: WSL symlinks can be problematic
4. **Updates**: Explicit update command (P3) copies new versions when needed

**Implementation:**
```bash
install_commands() {
  local target_dir="${HOME}/.claude/commands"
  mkdir -p "$target_dir"

  for cmd in "$INSTALL_DIR"/commands/researchkit.*.md; do
    cp "$cmd" "$target_dir/"
    success "Installed command: $(basename "$cmd")"
  done
}
```

### Alternatives Considered

- **Symlinks**: More elegant for development but adds complexity and platform issues
- **PATH manipulation**: Not applicable - Claude Code uses specific `.claude/commands/` directory

---

## Decision 5: Validation Approach

**Question**: What should the validation command check?

### Decision: File-Based Health Checks

The `validate.sh` script will perform these checks:

1. **Directory structure**: Verify `.researchkit/` and subdirectories exist
2. **Required files**: Check presence of essential templates and commands
3. **Claude Code integration**: Verify commands exist in `.claude/commands/`
4. **File integrity**: Optional checksum validation against manifest
5. **Permissions**: Verify scripts are executable

**Output Format:**
```
ResearchKit Installation Validation
====================================
✓ Directory structure
✓ Templates (5/5)
✓ Commands (5/5)
✓ Claude Code integration
✓ File permissions

Installation is healthy!
```

**Error Format:**
```
ResearchKit Installation Validation
====================================
✓ Directory structure
✗ Templates (4/5)
  Missing: templates/research-plan.md
✓ Commands (5/5)
✓ Claude Code integration
✗ File permissions
  Not executable: installer/validate.sh

2 issues found. Run: rk repair
```

---

## Summary of Technical Decisions

| Decision | Choice | Status |
|----------|--------|--------|
| Testing Framework | bats-core | ✅ Resolved |
| Script Architecture | Idempotent shell scripts with error trapping | ✅ Resolved |
| Distribution Method | Git clone + bundled files | ✅ Resolved |
| Claude Code Integration | Copy commands (not symlink) | ✅ Resolved |
| Validation Strategy | File-based health checks | ✅ Resolved |
| Cross-Platform Support | Bash 4.0+ with platform detection | ✅ Resolved |
| Error Handling | `set -euo pipefail` + trap handlers | ✅ Resolved |
| Output Styling | TTY-aware colored output | ✅ Resolved |

All NEEDS CLARIFICATION items from Technical Context are now resolved and ready for Phase 1 design.
