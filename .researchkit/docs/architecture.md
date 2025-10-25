# Architecture

Technical guide to how ResearchKit works under the hood.

---

## Table of Contents

1. [Overview](#overview)
2. [Directory Structure](#directory-structure)
3. [Installer Architecture](#installer-architecture)
4. [Command System](#command-system)
5. [Template System](#template-system)
6. [Version Management](#version-management)
7. [Testing Framework](#testing-framework)
8. [Design Decisions](#design-decisions)

---

## Overview

### What is ResearchKit?

ResearchKit is a **portable research framework** that lives in two places:

1. **Source Repository** (`research-kit/`): The canonical source
2. **User Installation** (`~/.researchkit/`): Installed on user's machine

**Key insight**: Users clone the repo once, install to `~/.researchkit/`, then can use `/rk-*` commands in ANY directory on their computer.

### Architecture Layers

```
┌─────────────────────────────────────┐
│   User Commands (/rk-*)            │  ← What users interact with
├─────────────────────────────────────┤
│   Claude Code Integration          │  ← ~/.claude/commands/
├─────────────────────────────────────┤
│   ResearchKit Installation         │  ← ~/.researchkit/
├─────────────────────────────────────┤
│   Installer Scripts                │  ← install.sh, update.sh, validate.sh
├─────────────────────────────────────┤
│   Source Repository                │  ← research-kit/ (Git repo)
└─────────────────────────────────────┘
```

---

## Directory Structure

### Source Repository

```
research-kit/                        ← Git repository
├── README.md                        ← User-facing documentation
├── install.sh                       ← Simple wrapper script
├── .researchkit/                    ← ResearchKit files
│   ├── commands/                    ← 13 command files
│   │   ├── rk-init.md
│   │   ├── rk-research.md
│   │   └── ... (11 more)
│   ├── templates/                   ← 6 template files
│   │   ├── question-template.md
│   │   ├── framework-template.md
│   │   └── ... (4 more)
│   ├── installer/                   ← Installer scripts
│   │   ├── install.sh              ← Main installer
│   │   ├── update.sh               ← Updater
│   │   ├── validate.sh             ← Validator
│   │   └── common.sh               ← Shared utilities
│   └── docs/                        ← Documentation
│       ├── getting-started.md
│       ├── installation-guide.md
│       ├── commands-reference.md
│       ├── templates-reference.md
│       ├── architecture.md
│       ├── troubleshooting.md
│       └── contributing.md
├── tests/                           ← Integration tests
│   ├── integration/
│   │   ├── test_install.bats      ← 18 tests
│   │   ├── test_validate.bats     ← 14 tests
│   │   └── test_update.bats       ← 13 tests
│   └── libs/                        ← Test libraries
│       ├── bats-assert/
│       ├── bats-support/
│       └── bats-file/
└── specs/                           ← Specifications
    └── 001-researchkit-installer/
        ├── spec.md
        ├── plan.md
        ├── tasks.md
        └── contracts/
```

### User Installation

After running `./install.sh`, creates:

```
~/.researchkit/                      ← Installed on user machine
├── commands/                        ← 13 commands (copied from source)
├── templates/                       ← 6 templates (copied from source)
├── installer/                       ← Installer scripts (copied from source)
├── docs/                            ← Documentation (copied from source)
├── .researchkit_version             ← Version file (e.g., "1.0.0")
├── .install_metadata                ← Installation metadata (JSON)
├── .install_manifest                ← File checksums (SHA256)
└── config.yaml                      ← Configuration

~/.claude/commands/                  ← Claude Code integration
├── rk-init.md                       ← Copied from ~/.researchkit/commands/
├── rk-research.md
└── ... (all 13 commands)
```

### User Research Projects

When user runs `/rk-init` in a directory:

```
~/my-research-topic/                 ← User's research directory
└── .researchkit/                    ← Project-specific research data
    ├── constitution.md              ← Research principles
    ├── questions/                   ← Question evolution
    ├── research-paths/              ← Research traditions
    │   └── paths/
    ├── documents/                   ← Collected sources
    │   ├── foundational/
    │   ├── recent-reviews/
    │   └── supplementary/
    ├── stories/                     ← Story library
    │   ├── meta/
    │   └── by-concept/
    ├── streams/                     ← Research streams
    ├── synthesis/                   ← Frameworks
    └── writing/                     ← Drafts
```

**Key separation**:
- `~/.researchkit/` = System installation (commands, templates)
- `~/project/.researchkit/` = Project research data

---

## Installer Architecture

### Components

1. **Root wrapper** (`install.sh`)
   - Simple exec wrapper
   - Calls `.researchkit/installer/install.sh`
   - Passes through all arguments

2. **Main installer** (`.researchkit/installer/install.sh`)
   - Platform detection
   - Directory creation
   - File copying
   - Claude Code integration
   - Metadata generation

3. **Common utilities** (`.researchkit/installer/common.sh`)
   - Error handling
   - Output formatting
   - Platform detection
   - Idempotency helpers

4. **Updater** (`.researchkit/installer/update.sh`)
   - Version comparison
   - Backup creation
   - Customization detection
   - Selective updates

5. **Validator** (`.researchkit/installer/validate.sh`)
   - Health checks
   - Auto-fix capability
   - JSON output mode

### Installation Flow

```
User runs: ./install.sh
    ↓
Root wrapper calls: .researchkit/installer/install.sh
    ↓
1. Parse arguments (--force, --noninteractive, etc.)
    ↓
2. Show welcome message
    ↓
3. Detect platform (macOS, Linux, WSL)
    ↓
4. Check existing installation
   - If exists: prompt to update/keep/cancel
   - If --force: overwrite
    ↓
5. Create directory structure
   - ~/.researchkit/{installer,templates,commands,docs}
    ↓
6. Copy files
   - Templates (6 files)
   - Commands (13 files)
   - Installer scripts (4 files)
   - Documentation (7 files)
    ↓
7. Install to Claude Code
   - Check if ~/.claude exists
   - Copy commands to ~/.claude/commands/
   - Skip if --no-commands
    ↓
8. Generate metadata
   - .researchkit_version (version string)
   - .install_metadata (JSON with install details)
   - .install_manifest (file checksums for integrity)
   - config.yaml (user configuration)
    ↓
9. Show completion message
```

### Update Flow

```
User runs: ~/.researchkit/installer/update.sh
    ↓
1. Check installation exists
   - Error if not found
    ↓
2. Get current version
   - Read from .researchkit_version
    ↓
3. Compare versions
   - If same: "already up-to-date"
   - If different: proceed with update
    ↓
4. Create timestamped backup
   - ~/.researchkit.backup.YYYYMMDD_HHMMSS
   - Skip if --no-backup
    ↓
5. Update files selectively
   - Installer scripts: Always update
   - Commands: Always update
   - Templates: Check for customizations
     * Read .install_manifest for original checksums
     * Compare current checksums
     * If different: PRESERVE (user modified)
     * If same: UPDATE
   - Documentation: Always update
    ↓
6. Update metadata
   - .researchkit_version (new version)
   - .install_metadata (add last_updated)
   - .install_manifest (new checksums)
    ↓
7. Sync to Claude Code
   - Update ~/.claude/commands/
    ↓
8. Show completion
   - Report what changed
   - Report what was preserved
   - Show backup location
```

### Validation Flow

```
User runs: /rk-validate
    ↓
1. Check directory structure
   - installer/, templates/, commands/, docs/ exist
    ↓
2. Check templates
   - All 6 templates present
   - If missing & auto-fix: restore from source
    ↓
3. Check commands
   - All 13 commands present
   - If missing & auto-fix: restore from source
    ↓
4. Check Claude Code integration
   - ~/.claude/commands/ exists
   - Commands copied
   - Warning if missing (not error)
    ↓
5. Check permissions
   - Installer scripts executable
   - If not & auto-fix: chmod +x
    ↓
6. Display results
   - Friendly output (default)
   - JSON output (--json)
   - Quiet output (--quiet)
    ↓
7. Exit with status
   - 0: Healthy (or auto-fixed)
   - 1: Errors (couldn't fix)
```

---

## Command System

### How Commands Work

1. **Commands are Markdown files** (`.md`)
   - Contains instructions for Claude
   - Not bash scripts
   - Claude interprets and executes

2. **Located in** `~/.claude/commands/`
   - Claude Code scans this directory
   - Makes `/rk-*` available globally

3. **Command structure**:
```markdown
# /rk.command-name - Brief Description

You are helping the user with [task].

## Context
[Background information]

## Your Task

### Step 1: [ACTION]
[Detailed instructions]

### Step 2: [ACTION]
[Detailed instructions]

## Output
[What to create and where]
```

### Command Lifecycle

```
User types: /rk-question
    ↓
Claude Code reads: ~/.claude/commands/rk-question.md
    ↓
Claude interprets instructions
    ↓
Claude prompts user for input
    ↓
Claude uses: ~/.researchkit/templates/question-template.md
    ↓
Claude generates: ~/project/.researchkit/questions/question-001.md
```

### Command Types

**Project Setup**:
- `/rk-init` - Creates `.researchkit/` in current directory
- `/rk-constitution` - Uses `constitution-template.md`

**Research Workflow**:
- `/rk-question` - Uses `question-template.md`
- `/rk-identify-paths` - Uses `research-path-template.md`
- `/rk-create-stream` - Research within discipline
- `/rk-capture-story` - Uses `story-template.md`

**Synthesis**:
- `/rk-frameworks` - Uses `framework-template.md`
- `/rk-cross-stream` - Multi-disciplinary synthesis
- `/rk-write` - Writing generation

**Utilities**:
- `/rk-validate` - Calls `~/.researchkit/installer/validate.sh`
- `/rk-collect-documents` - Document management
- `/rk-find-stories` - Story search

**Orchestration**:
- `/rk-research` - End-to-end workflow

---

## Template System

### Template Location and Usage

**Templates stored**:
- Source: `research-kit/.researchkit/templates/`
- Installed: `~/.researchkit/templates/`

**Templates used by**:
```
constitution-template.md  →  /rk-constitution
question-template.md      →  /rk-question
research-path-template.md →  /rk-identify-paths
story-template.md         →  /rk-capture-story
framework-template.md     →  /rk-frameworks
CLAUDE-template.md        →  Internal (all commands)
```

### Customization Detection

**Problem**: Users may customize templates. Updates should preserve customizations.

**Solution**: Checksum-based detection

1. **At install**: Generate checksums for all files
```bash
# .install_manifest
c5f1e9a...  templates/question-template.md
a8b3d2f...  templates/framework-template.md
...
```

2. **At update**: Compare current vs. original
```bash
# If checksums match: File unchanged → UPDATE
# If checksums differ: File modified → PRESERVE
```

3. **Implementation** (in `update.sh`):
```bash
update_templates() {
    for template in *.md; do
        original_checksum=$(grep "$template" .install_manifest | awk '{print $1}')
        current_checksum=$(sha256sum "$template" | awk '{print $1}')

        if [ "$current_checksum" != "$original_checksum" ]; then
            # User modified - preserve it
            ((preserved_count++))
        else
            # Not modified - update it
            cp "$source/$template" "$dest/$template"
            ((updated_count++))
        fi
    done
}
```

---

## Version Management

### Version File

**Location**: `~/.researchkit/.researchkit_version`

**Format**: Semantic versioning string
```
1.0.0
```

### Metadata File

**Location**: `~/.researchkit/.install_metadata`

**Format**: JSON
```json
{
  "version": "1.0.0",
  "installed_at": "2025-10-25T18:30:00Z",
  "last_updated": "2025-10-25T19:45:00Z",
  "install_dir": "/Users/you/.researchkit",
  "os": "macos",
  "arch": "arm64"
}
```

### Manifest File

**Location**: `~/.researchkit/.install_manifest`

**Format**: Checksum list
```
# ResearchKit Installation Manifest
# Generated: 2025-10-25

c5f1e9a7...  templates/question-template.md
a8b3d2f1...  templates/framework-template.md
f3e8c9b2...  commands/rk-init.md
...
```

**Purpose**: Detect file modifications for update preservation

### Version Comparison

**Simple strategy**: String comparison

```bash
compare_versions() {
    local current="$1"
    local target="$2"

    if [ "$current" = "$target" ]; then
        echo "equal"
    else
        echo "upgrade"  # Simplified: any difference is upgrade
    fi
}
```

**Future enhancement**: Semantic version parsing
- Major.Minor.Patch comparison
- Downgrade detection
- Breaking change warnings

---

## Testing Framework

### Test Suite

**Tool**: bats-core (Bash Automated Testing System)

**Structure**:
```
tests/
├── integration/
│   ├── test_install.bats    ← 18 tests
│   ├── test_validate.bats   ← 14 tests
│   └── test_update.bats     ← 13 tests
└── libs/
    ├── bats-assert/         ← Assertion library
    ├── bats-support/        ← Helper functions
    └── bats-file/           ← File assertions
```

**Total**: 45 integration tests

### Running Tests

```bash
# All tests
bats tests/integration/test_install.bats
bats tests/integration/test_validate.bats
bats tests/integration/test_update.bats

# Or individually
bats tests/integration/test_install.bats
```

### Test Pattern

```bash
@test "descriptive test name" {
    # Setup
    tmpdir=$(mktemp -d)

    # Execute
    run ./install.sh --noninteractive "$tmpdir"

    # Assert
    assert_success
    assert_dir_exist "$tmpdir/templates"

    # Cleanup
    rm -rf "$tmpdir"
}
```

### Key Test Categories

**Installation** (18 tests):
- Directory creation
- File copying (6 templates, 13 commands)
- Metadata generation
- Claude Code integration
- Idempotency
- Friendly messaging

**Validation** (14 tests):
- Health checks
- Missing file detection
- Auto-fix functionality
- JSON output
- Permission fixes

**Update** (13 tests):
- Backup creation
- Version comparison
- Customization preservation
- Installer script updates
- Friendly messaging

---

## Design Decisions

### 1. Why Bash Scripts?

**Decision**: Use bash for installer, not Python/Node

**Rationale**:
- ✅ Available on all Unix systems (macOS, Linux, WSL)
- ✅ No dependencies to install
- ✅ Perfect for file operations
- ✅ Users already have it

**Trade-offs**:
- ❌ More verbose than modern languages
- ❌ Harder to test
- ✅ But: Simple, reliable, universal

### 2. Why Markdown Commands?

**Decision**: Commands are `.md` files, not `.sh` scripts

**Rationale**:
- ✅ Claude interprets Markdown instructions
- ✅ More flexible than scripts (can adapt to context)
- ✅ Easy to customize (just edit text)
- ✅ Self-documenting

**Trade-offs**:
- ❌ Requires Claude Code to work
- ✅ But: That's our target platform

### 3. Why Two `.researchkit/` Directories?

**Decision**: System installation (`~/.researchkit/`) separate from project data (`~/project/.researchkit/`)

**Rationale**:
- ✅ System files (commands, templates) don't mix with research data
- ✅ Can delete project without affecting installation
- ✅ Can use ResearchKit in multiple projects
- ✅ Clean separation of concerns

**Trade-offs**:
- ❌ Initially confusing for users
- ✅ But: Much cleaner once understood

### 4. Why Auto-Fix by Default?

**Decision**: Validator auto-fixes issues by default (can disable with `--no-fix`)

**Rationale**:
- ✅ Beginner-friendly (just works)
- ✅ Reduces support burden
- ✅ Safe operations (permissions, missing files)
- ✅ Can disable for advanced users

**Trade-offs**:
- ❌ Might hide underlying issues
- ✅ But: Better UX for beginners

### 5. Why Checksum-Based Customization Detection?

**Decision**: Use SHA256 checksums to detect file modifications

**Rationale**:
- ✅ Reliable (any change detected)
- ✅ Fast (checksum comparison)
- ✅ No false positives
- ✅ Standard tool (shasum, sha256sum)

**Trade-offs**:
- ❌ Can't detect "semantic" vs "formatting" changes
- ✅ But: Conservative is better (preserve when in doubt)

### 6. Why Friendly Messaging?

**Decision**: Extensive friendly messages with emojis

**Rationale**:
- ✅ Beginner audience (many non-technical)
- ✅ Reduces anxiety during installation
- ✅ Explains what's happening
- ✅ Actionable error messages

**Trade-offs**:
- ❌ More verbose than terse Unix tools
- ✅ But: Better user experience

### 7. Why Timestamped Backups?

**Decision**: Create `~/.researchkit.backup.YYYYMMDD_HHMMSS` before updates

**Rationale**:
- ✅ Multiple backups don't overwrite
- ✅ Can restore specific version
- ✅ Sortable by date
- ✅ Self-documenting

**Trade-offs**:
- ❌ Accumulates backups (user must clean up)
- ✅ But: Safety over convenience

---

## Platform Support

### Supported Platforms

- ✅ macOS (tested)
- ✅ Linux (designed for, not fully tested)
- ✅ Windows WSL (designed for, not fully tested)

### Platform-Specific Code

**Platform detection**:
```bash
detect_os() {
    case "$(uname -s)" in
        Darwin*)    echo "macos" ;;
        Linux*)     echo "linux" ;;
        MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
        *)          echo "unknown" ;;
    esac
}
```

**Architecture detection**:
```bash
detect_arch() {
    case "$(uname -m)" in
        x86_64|amd64)  echo "x86_64" ;;
        arm64|aarch64) echo "arm64" ;;
        *)             echo "unknown" ;;
    esac
}
```

**Emoji support**:
```bash
is_tty() {
    [ -t 1 ] && return 0 || return 1
}

# Only show emojis if terminal supports it
if is_tty; then
    ohai "Welcome! 🔬"
else
    ohai "Welcome!"
fi
```

---

## Error Handling

### Error Handler

**Location**: `common.sh`

**Pattern**: ERR trap
```bash
error_handler() {
    local line_no="$1"
    local bash_lineno="$2"
    local command="$3"
    local exit_code="$4"

    echo ""
    error "Error occurred in script execution:"
    info "  Line: $line_no"
    info "  Command: $command"
    info "  Exit code: $exit_code"
    echo ""
}

trap 'error_handler "$LINENO" "$BASH_LINENO" "$BASH_COMMAND" "$?"' ERR
```

**Note**: Removed from `validate.sh` because validation failures are expected, not errors.

### Exit Codes

**Standard codes**:
```
0   - Success
1   - General error
2   - Installation not found
10  - Unknown option
13  - Command return value (fixed in update.sh)
30  - User cancelled
```

**Contract**: See `specs/001-researchkit-installer/contracts/`

---

## Future Enhancements

### Potential Improvements

1. **Full semantic versioning**
   - Parse Major.Minor.Patch
   - Detect downgrades
   - Breaking change warnings

2. **Plugin system**
   - User-defined commands
   - Custom templates
   - Extension points

3. **Configuration file**
   - User preferences
   - Custom install paths
   - Feature toggles

4. **Telemetry** (opt-in)
   - Usage analytics
   - Error reporting
   - Feature adoption

5. **Multi-language support**
   - Translations
   - Locale-aware messaging

6. **Package managers**
   - Homebrew formula
   - apt/yum packages
   - npm package

---

## Contributing

Want to extend ResearchKit? See [Contributing Guide](contributing.md).

---

## Related Documentation

- **User docs**: [Getting Started](getting-started.md)
- **Installation**: [Installation Guide](installation-guide.md)
- **Commands**: [Commands Reference](commands-reference.md)
- **Templates**: [Templates Reference](templates-reference.md)
- **Troubleshooting**: [Troubleshooting](troubleshooting.md)
