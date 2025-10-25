# Contract: install.sh

**Feature**: ResearchKit CLI Installer
**Command**: `./install.sh`
**Purpose**: Install ResearchKit in the user's environment

---

## Command Signature

```bash
./install.sh [OPTIONS] [TARGET_DIR]
```

---

## Input Specification

### Arguments

| Argument | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `TARGET_DIR` | path | No | `$HOME/.researchkit` | Installation directory |

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `--force` | boolean | false | Overwrite existing installation without prompting |
| `--noninteractive` | boolean | false | Skip all prompts (use defaults) |
| `--version VERSION` | string | `latest` | Specific version to install |
| `--no-commands` | boolean | false | Skip Claude Code command installation |
| `--help` | boolean | false | Show help message and exit |

### Environment Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `RESEARCHKIT_DIR` | path | `$HOME/.researchkit` | Override default installation directory |
| `NONINTERACTIVE` | boolean | `0` | Same as `--noninteractive` option |
| `RESEARCHKIT_VERSION` | string | `latest` | Same as `--version` option |

---

## Output Specification

### Success Output (Exit Code 0)

**stdout:**
```
Welcome to ResearchKit! 🔬

I'll set up ResearchKit on your computer - this takes about 1 minute.

I see you're on macOS - perfect!

Setting up your research workspace...
✓ Research templates installed (6 templates ready to use)
✓ Commands ready to use (13 research commands)
✓ Claude Code integration complete
✓ Documentation added

All done! 🎉

Next steps:
  1. Open any folder where you want to do research
  2. Type: /rk-init
  3. Start researching with: /rk-research

Your ResearchKit commands:
  • /rk-init - Start a new research project
  • /rk-research - Begin your research
  • /rk-validate - Check everything's working

Learn more: ~/.researchkit/docs/getting-started.md
```

### Update Detection Output (Exit Code 0)

**stdout:**
```
Welcome back to ResearchKit! 🔬

I found an existing installation from Oct 25, 2025.

Would you like to:
  [U] Update to the latest version
  [K] Keep your current installation
  [C] Cancel

Your choice (U/K/C): _

(If user chooses U - Update)

Great! I'll update ResearchKit for you.
Your research files are safe and won't be touched.

Updating...
✓ Updated 13 commands
✓ Your custom templates are safe
✓ Documentation refreshed

Update complete! 🎉

What changed:
  • 13 commands updated with new features
  • 2 templates kept (your customizations preserved)

You're all set - happy researching!
```

### Error Output (Exit Code > 0)

**stdout (not stderr - friendly errors go to stdout):**
```
Oops! I ran into a problem setting up ResearchKit. 😕

What happened:
  I couldn't create a folder in your home directory.

Why this happened:
  The folder might be read-only, or your disk might be full.

How to fix it:
  1. Check if you have space on your computer:
     • Open Finder → About This Mac → Storage
     • You need at least 10 MB free

  2. If you have space, try installing to a different folder:
     • Run: ./install.sh ~/Documents/.researchkit

Need help? Check ~/.researchkit/docs/troubleshooting.md
or visit: https://researchkit.example.com/help
```

---

## Exit Codes

| Code | Meaning | Description |
|------|---------|-------------|
| `0` | Success | Installation completed successfully |
| `1` | General Error | Unspecified error occurred |
| `2` | Permission Denied | Insufficient permissions to write files |
| `10` | Missing Dependency | Required command not found (e.g., git, curl) |
| `11` | Network Error | Failed to download required files |
| `20` | Validation Failed | Post-install validation detected issues |
| `30` | User Cancelled | User aborted installation via prompt |

---

## Side Effects

### File System Changes

**Created Directories:**
- `$TARGET_DIR/` - Installation root
- `$TARGET_DIR/installer/` - Installer scripts
- `$TARGET_DIR/templates/` - Research templates
- `$TARGET_DIR/commands/` - Command definitions
- `$TARGET_DIR/docs/` - Documentation
- `$HOME/.claude/commands/` - Claude Code commands (if doesn't exist)

**Created Files:**
- `$TARGET_DIR/.researchkit_version` - Version identifier
- `$TARGET_DIR/.install_manifest` - File checksums
- `$TARGET_DIR/.install_metadata` - Install metadata (JSON)
- `$TARGET_DIR/config.yaml` - Configuration file
- `$TARGET_DIR/templates/*.md` - Template files (6):
  - CLAUDE-template.md
  - constitution-template.md
  - framework-template.md
  - question-template.md
  - research-path-template.md
  - story-template.md
- `$TARGET_DIR/commands/*.md` - Command source files (13):
  - rk-capture-story.md
  - rk-collect-documents.md
  - rk-constitution.md
  - rk-create-stream.md
  - rk-cross-stream.md
  - rk-find-stories.md
  - rk-frameworks.md
  - rk-identify-paths.md
  - rk-init.md
  - rk-question.md
  - rk-research.md
  - rk-validate.md
  - rk-write.md
- `$TARGET_DIR/docs/*.md` - Documentation files (getting-started.md)
- `$HOME/.claude/commands/rk-*.md` - Copied commands (13)

**Modified Files:**
- Shell profile (`~/.bashrc`, `~/.zshrc`, or `~/.bash_profile`) - Adds PATH entry (if not present)

### System State Changes

- ResearchKit commands become available in Claude Code
- `$TARGET_DIR/bin/` added to user's PATH (after shell restart)
- Installation metadata recorded for future updates

---

## Pre-conditions

**Required:**
- User has read/write permissions in target directory parent
- Shell environment is bash 4.0+ compatible
- Standard POSIX utilities available (mkdir, cp, mv, cat, grep)

**Optional:**
- Git available (for version information)
- Claude Code installed (for command integration)
- Internet connection (for version checking - future enhancement)

---

## Post-conditions

**On Success:**
- All files installed to `$TARGET_DIR`
- Commands copied to `.claude/commands/`
- Shell profile updated with PATH entry
- Validation report shows all checks passing
- Exit code 0

**On Failure:**
- No partial installation (rolled back if possible)
- Clear error message describing problem
- Non-zero exit code indicating error type
- Original state preserved (for update scenarios)

---

## Error Scenarios

### Scenario 1: Permission Denied

**Input:** `./install.sh /read-only-dir`

**Expected Behavior:**
- Detects write permission issue immediately
- Outputs clear error message to stderr
- Exits with code 2
- No files created

**Error Message:**
```
Error: Cannot write to /read-only-dir
Permission denied when creating installation directory.

Try:
  - Choose a different installation directory
  - Run with appropriate permissions
  - Use default location: ./install.sh (installs to ~/.researchkit)
```

### Scenario 2: Existing Installation (Interactive)

**Input:** `./install.sh` (when ResearchKit already installed)

**Expected Behavior:**
- Detects existing installation
- Prompts user for action
- Waits for user input
- Executes chosen action (update/skip/abort)

**Prompt:**
```
==> Existing ResearchKit installation detected
  Location: /home/user/.researchkit
  Version: 1.0.0

Options:
  [U] Update existing installation
  [S] Skip (keep current installation)
  [A] Abort installation

Choice [U/S/A]:
```

### Scenario 3: Missing Claude Code

**Input:** `./install.sh`

**Expected Behavior:**
- Installation proceeds normally
- Warns about missing `.claude/commands/` directory
- Creates commands in ResearchKit directory
- Exits with code 0 (warning, not error)

**Warning Message:**
```
Warning: Claude Code commands directory not found
  Expected: /home/user/.claude/commands/

ResearchKit commands were installed to:
  /home/user/.researchkit/commands/

To enable commands in Claude Code:
  1. Ensure Claude Code is installed
  2. Create commands directory: mkdir -p ~/.claude/commands
  3. Copy commands: cp ~/.researchkit/commands/rk-*.md ~/.claude/commands/
```

---

## Idempotency Guarantee

Running `./install.sh` multiple times with the same arguments must:
- Produce the same result
- Not cause errors or corruption
- Preserve user customizations (in update mode)
- Exit successfully with code 0

**Safe Operations:**
- `mkdir -p` - Creates only if doesn't exist
- `ln -sfn` - Symlinks force-update safely
- `grep -qF` before append - Prevents duplicate profile entries
- Backup before overwrite - Preserves original state

---

## Performance Expectations

| Operation | Expected Time | Max Acceptable Time |
|-----------|---------------|---------------------|
| Fresh install | < 5 seconds | < 10 seconds |
| Update install | < 3 seconds | < 10 seconds |
| Directory creation | < 1 second | < 2 seconds |
| File copying | < 2 seconds | < 5 seconds |
| Profile modification | < 1 second | < 2 seconds |

**Note:** Times assume local file operations. Network operations (future versions) may be slower.

---

## Examples

### Example 1: Fresh Install (Default Location)

```bash
$ ./install.sh
==> ResearchKit Installer
==> Detected OS: macos
==> Installing ResearchKit
✓ Installation complete!
$ echo $?
0
```

### Example 2: Install to Custom Directory

```bash
$ ./install.sh ~/projects/research/.researchkit
==> ResearchKit Installer
==> Installing ResearchKit to /Users/user/projects/research/.researchkit
✓ Installation complete!
```

### Example 3: Force Reinstall (Non-Interactive)

```bash
$ ./install.sh --force --noninteractive
==> ResearchKit Installer
==> Existing installation detected
==> Force mode enabled - overwriting
✓ Installation complete!
```

### Example 4: Install Specific Version

```bash
$ ./install.sh --version 1.2.0
==> ResearchKit Installer
==> Installing ResearchKit version 1.2.0
✓ Installation complete!
```

### Example 5: Install Without Claude Code Commands

```bash
$ ./install.sh --no-commands
==> ResearchKit Installer
==> Skipping Claude Code command installation
✓ Installation complete!
```

---

## Testing Checklist

- [ ] Fresh install to default location
- [ ] Fresh install to custom directory
- [ ] Update existing installation
- [ ] Install with `--force` flag
- [ ] Install in `--noninteractive` mode
- [ ] Install with `--no-commands` flag
- [ ] Permission denied scenario
- [ ] Missing parent directory
- [ ] Disk full scenario
- [ ] Existing installation prompt (interactive)
- [ ] Run twice (idempotency)
- [ ] Install on macOS
- [ ] Install on Linux
- [ ] Install on WSL
- [ ] Path with spaces
- [ ] Verify shell profile modification
- [ ] Verify commands in `.claude/commands/`
- [ ] Run with `shellcheck`
