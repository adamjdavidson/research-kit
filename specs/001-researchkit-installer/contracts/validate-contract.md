# Contract: validate.sh

**Feature**: ResearchKit CLI Installer
**Command**: `./validate.sh` or `researchkit validate`
**Purpose**: Verify ResearchKit installation integrity and health

---

## Command Signature

```bash
./validate.sh [OPTIONS] [INSTALL_DIR]
```

---

## Input Specification

### Arguments

| Argument | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `INSTALL_DIR` | path | No | `$HOME/.researchkit` | Installation directory to validate |

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `--quiet` | boolean | false | Suppress detailed output, show only errors |
| `--json` | boolean | false | Output results as JSON instead of human-readable text |
| `--fix` | boolean | false | Attempt to repair issues automatically |
| `--help` | boolean | false | Show help message and exit |

### Environment Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `RESEARCHKIT_DIR` | path | `$HOME/.researchkit` | Override default installation directory |

---

## Output Specification

### Success Output (Exit Code 0) - All Checks Pass

**stdout (default format):**
```
Checking your ResearchKit installation... 🔍

✓ Everything looks great!
✓ All 6 templates are ready
✓ All 13 commands are working
✓ Claude Code integration is perfect

ResearchKit is ready to use! 🎉

Your commands:
  • /rk-init - Start researching in current folder
  • /rk-research - Deep research workflow
  • /rk-validate - Check installation health

Try it out - type /rk-init to get started!
```

**stdout (--json format):**
```json
{
  "timestamp": "2025-10-25T14:30:00Z",
  "installation_dir": "/home/user/.researchkit",
  "overall_status": "healthy",
  "checks": [
    {
      "name": "directory_structure",
      "status": "pass",
      "message": "All required directories exist"
    },
    {
      "name": "templates",
      "status": "pass",
      "message": "All templates present (6/6)"
    },
    {
      "name": "commands",
      "status": "pass",
      "message": "All commands present (13/13)"
    },
    {
      "name": "claude_integration",
      "status": "pass",
      "message": "Commands found in .claude/commands/"
    },
    {
      "name": "permissions",
      "status": "pass",
      "message": "All file permissions correct"
    }
  ]
}
```

### Auto-Fix Output (Exit Code 0) - Issues Found and Fixed

**stdout (default format):**
```
Checking your ResearchKit installation... 🔍

I found a couple of small issues, so I fixed them for you!

✓ Fixed: File permissions (2 scripts needed execute permission)
✓ Restored: CLAUDE-template.md from backup

Everything is working now! 🎉

What I fixed:
  • Made installer scripts executable
  • Restored 1 missing template

You're all set - ResearchKit is ready to use!
```

### Warning Output (Exit Code 0) - Minor Issues (Can't Auto-Fix)

**stdout (default format):**
```
Checking your ResearchKit installation... 🔍

Everything works, but I noticed something:

⚠️ Your ResearchKit commands aren't connected to Claude Code yet.

This is okay - the commands are installed, they're just not hooked up.

How to finish the setup (optional):
  1. Make sure Claude Code is installed
  2. I'll connect the commands for you - just run this installer again

Your ResearchKit still works! You can use it with the /rk commands.
```

### Error Output (Exit Code 1) - Critical Issues Can't Auto-Fix

**stdout (default format):**
```
Oops! I found some issues with your ResearchKit installation. 😕

What's wrong:
  ✗ 3 template files are missing
  ✗ Some commands couldn't be found

Don't worry - your research data is safe!

How to fix it:
  1. Run the installer again to restore missing files:
     ./install.sh

  2. Or if that doesn't work, do a fresh install:
     ./install.sh --force

Need help? Visit: https://researchkit.example.com/troubleshooting
```

**stdout (--json format with errors):**
```json
{
  "timestamp": "2025-10-25T14:30:00Z",
  "installation_dir": "/home/user/.researchkit",
  "overall_status": "errors",
  "checks": [
    {
      "name": "directory_structure",
      "status": "pass",
      "message": "All required directories exist"
    },
    {
      "name": "templates",
      "status": "fail",
      "message": "Missing templates (5/6)",
      "details": {
        "missing": ["templates/CLAUDE-template.md"],
        "found": ["templates/constitution-template.md", "templates/framework-template.md", "templates/question-template.md", "templates/research-path-template.md", "templates/story-template.md"]
      }
    },
    {
      "name": "commands",
      "status": "pass",
      "message": "All commands present (13/13)"
    },
    {
      "name": "claude_integration",
      "status": "pass",
      "message": "Commands found in .claude/commands/"
    },
    {
      "name": "permissions",
      "status": "fail",
      "message": "File permission issues",
      "details": {
        "not_executable": ["installer/validate.sh", "installer/install.sh"]
      }
    }
  ],
  "suggestions": [
    "Run: ./install.sh --fix",
    "Or: ./install.sh --force (reinstall)"
  ]
}
```

---

## Exit Codes

| Code | Meaning | Description |
|------|---------|-------------|
| `0` | Healthy or Warnings | Installation is functional (may have warnings) |
| `1` | Errors Found | Critical issues detected that prevent functionality |
| `2` | Invalid Installation | Installation directory doesn't exist or is corrupted |
| `10` | Invalid Arguments | Command-line options invalid |

---

## Validation Checks

### Check 1: Directory Structure

**Purpose:** Verify all required directories exist

**Required Directories:**
- `$INSTALL_DIR/`
- `$INSTALL_DIR/installer/`
- `$INSTALL_DIR/templates/`
- `$INSTALL_DIR/commands/`
- `$INSTALL_DIR/docs/`

**Pass Condition:** All directories exist and are readable

**Fail Condition:** Any required directory missing or unreadable

---

### Check 2: Templates

**Purpose:** Verify all template files are present

**Required Templates:**
- `templates/CLAUDE-template.md`
- `templates/constitution-template.md`
- `templates/framework-template.md`
- `templates/question-template.md`
- `templates/research-path-template.md`
- `templates/story-template.md`

**Pass Condition:** All 6 templates exist and are readable

**Fail Condition:** Any required template missing or unreadable

**Details Output:** List of missing templates

---

### Check 3: Commands

**Purpose:** Verify all command definition files are present

**Required Commands:**
- `commands/rk-capture-story.md`
- `commands/rk-collect-documents.md`
- `commands/rk-constitution.md`
- `commands/rk-create-stream.md`
- `commands/rk-cross-stream.md`
- `commands/rk-find-stories.md`
- `commands/rk-frameworks.md`
- `commands/rk-identify-paths.md`
- `commands/rk-init.md`
- `commands/rk-question.md`
- `commands/rk-research.md`
- `commands/rk-validate.md`
- `commands/rk-write.md`

**Pass Condition:** All 13 commands exist and are readable

**Fail Condition:** Any required command missing or unreadable

**Details Output:** List of missing commands

---

### Check 4: Claude Code Integration

**Purpose:** Verify commands are available to Claude Code

**Expected Files:**
- `$HOME/.claude/commands/rk-capture-story.md`
- `$HOME/.claude/commands/rk-collect-documents.md`
- `$HOME/.claude/commands/rk-constitution.md`
- `$HOME/.claude/commands/rk-create-stream.md`
- `$HOME/.claude/commands/rk-cross-stream.md`
- `$HOME/.claude/commands/rk-find-stories.md`
- `$HOME/.claude/commands/rk-frameworks.md`
- `$HOME/.claude/commands/rk-identify-paths.md`
- `$HOME/.claude/commands/rk-init.md`
- `$HOME/.claude/commands/rk-question.md`
- `$HOME/.claude/commands/rk-research.md`
- `$HOME/.claude/commands/rk-validate.md`
- `$HOME/.claude/commands/rk-write.md`

**Pass Condition:** All commands exist in `.claude/commands/`

**Warning Condition:** `.claude/commands/` directory doesn't exist (commands installed locally)

**Fail Condition:** Some but not all commands present (inconsistent state)

**Details Output:** List of missing commands in `.claude/commands/`

---

### Check 5: File Permissions

**Purpose:** Verify installer scripts are executable

**Required Executable Files:**
- `installer/install.sh`
- `installer/validate.sh`
- `installer/update.sh`
- `installer/common.sh` (optional - may be sourced only)

**Pass Condition:** All installer scripts have execute permission

**Fail Condition:** Any required script not executable

**Auto-Fix (with --fix):** `chmod +x <script>`

**Details Output:** List of non-executable files

---

### Check 6: File Integrity (Optional - Future Enhancement)

**Purpose:** Verify files haven't been corrupted

**Method:** Compare checksums against `.install_manifest`

**Pass Condition:** All checksums match manifest

**Warning Condition:** User-modified templates (expected)

**Fail Condition:** System files (installer, commands) checksum mismatch

---

## Side Effects

### Read-Only Operations (default)

- Reads files to check existence and permissions
- No modifications to file system
- Outputs validation report to stdout

### Write Operations (with --fix)

- Sets execute permissions on installer scripts: `chmod +x installer/*.sh`
- Attempts to restore missing files from backup (if available)
- Creates missing directories: `mkdir -p <dir>`
- Outputs repair actions to stdout

---

## Pre-conditions

**Required:**
- Installation directory exists and is readable
- User has read permissions on all files to be checked

**Optional (for --fix):**
- User has write permissions to repair issues
- Backup files available (for restoration)

---

## Post-conditions

### On Success (Exit Code 0)

- Validation report generated
- Exit code 0
- No file system modifications (unless --fix used)

### On Warnings (Exit Code 0)

- Validation report shows warnings
- Exit code 0 (installation still functional)
- Suggestions provided for resolution

### On Errors (Exit Code 1)

- Validation report shows errors
- Exit code 1
- Repair suggestions provided
- No file system modifications (unless --fix used)

---

## Error Scenarios

### Scenario 1: Installation Not Found

**Input:** `./validate.sh /nonexistent/path`

**Expected Behavior:**
- Detects missing installation directory
- Outputs clear error message
- Exits with code 2

**Error Message:**
```
Error: ResearchKit installation not found
  Path: /nonexistent/path

This path does not contain a ResearchKit installation.

To install ResearchKit:
  ./install.sh /nonexistent/path
```

### Scenario 2: Partial Installation

**Input:** `./validate.sh` (when some files missing)

**Expected Behavior:**
- Detects missing files
- Lists each missing component
- Provides repair instructions
- Exits with code 1

### Scenario 3: Permission Issues

**Input:** `./validate.sh` (when scripts not executable)

**Expected Behavior:**
- Detects permission issues
- Lists affected files
- Suggests `chmod` commands or `--fix` flag
- Exits with code 1

---

## Idempotency Guarantee

Running `./validate.sh` multiple times must:
- Produce the same result (if no changes between runs)
- Not modify any files (unless --fix used)
- Exit with consistent exit code for same state

---

## Performance Expectations

| Operation | Expected Time | Max Acceptable Time |
|-----------|---------------|---------------------|
| Full validation | < 1 second | < 3 seconds |
| JSON output | < 1 second | < 3 seconds |
| Auto-fix mode | < 2 seconds | < 5 seconds |

---

## Examples

### Example 1: Healthy Installation

```bash
$ ./validate.sh
ResearchKit Installation Validation
====================================
✓ Directory structure
✓ Templates (6/6)
✓ Commands (13/13)
✓ Claude Code integration
✓ File permissions

Installation is healthy!
$ echo $?
0
```

### Example 2: Installation with Warnings

```bash
$ ./validate.sh
ResearchKit Installation Validation
====================================
✓ Directory structure
✓ Templates (6/6)
✓ Commands (13/13)
⚠ Claude Code integration
  Warning: .claude/commands/ directory not found
✓ File permissions

1 warning found. Installation functional but incomplete.
$ echo $?
0
```

### Example 3: Corrupted Installation

```bash
$ ./validate.sh
ResearchKit Installation Validation
====================================
✓ Directory structure
✗ Templates (4/6)
  Missing: templates/CLAUDE-template.md
  Missing: templates/question-template.md
✓ Commands (13/13)
✓ Claude Code integration
✗ File permissions
  Not executable: installer/install.sh

2 errors found. Installation is corrupted.

To fix:
  ./validate.sh --fix
$ echo $?
1
```

### Example 4: JSON Output

```bash
$ ./validate.sh --json | jq .
{
  "timestamp": "2025-10-25T14:30:00Z",
  "installation_dir": "/home/user/.researchkit",
  "overall_status": "healthy",
  "checks": [...]
}
$ echo $?
0
```

### Example 5: Auto-Fix Mode

```bash
$ ./validate.sh --fix
ResearchKit Installation Validation
====================================
✓ Directory structure
✗ Templates (5/6)
  Missing: templates/CLAUDE-template.md
  Attempting repair...
  ✓ Restored from backup
✓ Commands (13/13)
✓ Claude Code integration
✗ File permissions
  Not executable: installer/install.sh
  Fixing permissions...
  ✓ chmod +x installer/install.sh

Repaired 2 issues. Re-validating...
✓ All checks passing

Installation is healthy!
$ echo $?
0
```

---

## Testing Checklist

- [ ] Validate healthy installation
- [ ] Validate missing templates
- [ ] Validate missing commands
- [ ] Validate permission issues
- [ ] Validate missing Claude Code integration
- [ ] Validate non-existent installation
- [ ] Output in default format
- [ ] Output in JSON format
- [ ] Output in quiet mode
- [ ] Auto-fix mode (repair issues)
- [ ] Run on macOS
- [ ] Run on Linux
- [ ] Run on WSL
- [ ] Run against custom installation directory
- [ ] Run with shellcheck
- [ ] Verify exit codes
- [ ] Test idempotency (run twice)
