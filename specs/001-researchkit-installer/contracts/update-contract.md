# Contract: update.sh

**Feature**: ResearchKit CLI Installer
**Command**: `./update.sh` or `researchkit update`
**Purpose**: Update existing ResearchKit installation while preserving customizations

---

## Command Signature

```bash
./update.sh [OPTIONS] [INSTALL_DIR]
```

---

## Input Specification

### Arguments

| Argument | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `INSTALL_DIR` | path | No | `$HOME/.researchkit` | Installation directory to update |

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `--version VERSION` | string | `latest` | Specific version to update to |
| `--no-backup` | boolean | false | Skip creating backup before update |
| `--noninteractive` | boolean | false | Skip all prompts (use defaults) |
| `--help` | boolean | false | Show help message and exit |

### Environment Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `RESEARCHKIT_DIR` | path | `$HOME/.researchkit` | Override default installation directory |
| `NONINTERACTIVE` | boolean | `0` | Same as `--noninteractive` option |

---

## Output Specification

### Success Output (Exit Code 0) - Updates Applied

**stdout:**
```
Great news! I found some updates for ResearchKit. 🔬

I'll update ResearchKit for you - this will only take a moment.
Your research files are safe and won't be touched.

I see you're on version 1.0.0, and I'll update you to 1.1.0.

First, I'll make a backup of everything (just to be safe)...
✓ Backup created - your current setup is saved

Updating your ResearchKit...
✓ Updated 3 templates (2 kept because you customized them)
✓ Updated 13 commands with new features
✓ Updated installer tools
✓ Everything synced with Claude Code

All done! 🎉

What changed:
  • 3 templates got new features
  • 2 templates kept your customizations (narrative-outline.md, analysis-template.md)
  • 13 commands updated with improvements

Your backup is here if you need it:
  ~/.researchkit.backup.20251025_143000

You're all set - happy researching!
```

### Already Up-to-Date Output (Exit Code 0)

**stdout:**
```
Checking for ResearchKit updates... 🔍

Good news - you're already on the latest version! ✓

Your ResearchKit is up to date (version 1.1.0).
No updates needed right now.

Keep researching! 🎉
```

### Error Output (Exit Code > 0)

**stdout (not stderr - friendly errors go to stdout):**
```
Hmm, I couldn't find ResearchKit on your computer. 😕

What happened:
  I looked for ResearchKit at ~/.researchkit but it's not there yet.

Why this happened:
  ResearchKit hasn't been installed on this computer yet, or it was
  installed somewhere else.

How to fix it:
  1. Install ResearchKit first by running:
     ./install.sh

  2. Or, if you installed it somewhere else, tell me where:
     ./update.sh /path/to/your/.researchkit

Need help? Check the getting started guide at:
  ~/.researchkit/docs/getting-started.md
```

---

## Exit Codes

| Code | Meaning | Description |
|------|---------|-------------|
| `0` | Success | Update completed or already up-to-date |
| `1` | General Error | Unspecified error occurred |
| `2` | Installation Not Found | No existing installation at specified path |
| `10` | Backup Failed | Unable to create backup before update |
| `20` | Update Conflict | User customizations conflict with update |
| `30` | User Cancelled | User aborted update via prompt |

---

## Side Effects

### File System Changes (Successful Update)

**Backed Up:**
- Entire `$INSTALL_DIR/` directory copied to timestamped backup

**Modified Files (System Files Only):**
- `$INSTALL_DIR/installer/*.sh` - Installer scripts updated
- `$INSTALL_DIR/commands/*.md` - Command definitions updated (if changed)
- `$INSTALL_DIR/docs/*.md` - Documentation updated
- `$HOME/.claude/commands/rk-*.md` - Commands recopied

**Preserved Files (User Customizations):**
- `$INSTALL_DIR/config.yaml` - User configuration preserved
- `$INSTALL_DIR/templates/*.md` - User-modified templates preserved
- Any files in `$INSTALL_DIR/` not part of base installation

**Updated Metadata:**
- `$INSTALL_DIR/.researchkit_version` - Version number updated
- `$INSTALL_DIR/.install_metadata` - `last_updated` timestamp updated
- `$INSTALL_DIR/.install_manifest` - File checksums updated

---

## Pre-conditions

**Required:**
- Existing ResearchKit installation at `$INSTALL_DIR`
- User has read/write permissions on installation directory
- Sufficient disk space for backup (typically < 1MB)

**Optional:**
- Network connection (for fetching updates - future enhancement)
- Git available (for version control operations)

---

## Post-conditions

### On Success

- Installation updated to target version
- Backup created at `$INSTALL_DIR.backup.<timestamp>`
- User customizations preserved
- Commands synced to Claude Code
- Exit code 0

### On Failure

- Original installation unchanged (rollback if partial failure)
- Error message explaining issue
- Non-zero exit code
- Backup preserved (if created before failure)

---

## Update Strategy

### File Categories

**1. System Files (Always Updated):**
- `installer/*.sh` - Installer scripts
- `commands/*.md` - Command definitions
- `docs/*.md` - Documentation
- Metadata files (`.researchkit_version`, `.install_manifest`)

**2. User Configuration (Preserved):**
- `config.yaml` - User settings
- User-modified templates (detected via checksum comparison)

**3. New Files (Added):**
- Any new templates, commands, or documentation in target version

### Conflict Resolution

**Customized Templates:**
1. Compare current file checksum with manifest
2. If modified by user → preserve current version, show warning
3. If unmodified → update to new version
4. Original new version available in backup if user wants to merge

**Conflicting Updates:**
- If update would overwrite user changes to system files → prompt user
- Options: Keep current, Use new version, Show diff, Abort update

---

## Error Scenarios

### Scenario 1: Installation Not Found

**Input:** `./update.sh /nonexistent/path`

**Expected Behavior:**
- Detects missing installation
- Outputs clear error message
- Exits with code 2

**Error Message:**
```
Error: Installation not found at /nonexistent/path

Cannot update: no existing installation detected.

To install ResearchKit:
  ./install.sh /nonexistent/path
```

### Scenario 2: Backup Failed

**Input:** `./update.sh` (when disk full or permissions issue)

**Expected Behavior:**
- Attempts to create backup
- Detects backup failure
- Aborts update before making changes
- Exits with code 10

**Error Message:**
```
Oops! I ran into a problem while updating ResearchKit. 😕

What happened:
  I couldn't create a backup of your current ResearchKit.

Why this happened:
  Your computer's disk might be full, or there might be a permissions issue.

The good news:
  I didn't make any changes, so your current ResearchKit is exactly as it was.

How to fix it:
  1. Check if you have space on your computer:
     • Open Finder → About This Mac → Storage
     • You need at least 10 MB free for the backup

  2. If you have space, try checking file permissions:
     • Run: ls -la ~/.researchkit

  3. If you're sure everything's fine, you can skip the backup:
     • Run: ./update.sh --no-backup
     • (Not recommended - backups keep you safe!)

Need help? Visit: https://researchkit.example.com/troubleshooting
```

### Scenario 3: User Customizations Detected

**Input:** `./update.sh` (when templates modified)

**Expected Behavior:**
- Detects modified templates
- Preserves user versions
- Updates only system files
- Shows warning about preserved files

**Warning Message:**
```
Updating your templates...

✓ Updated CLAUDE-template.md with new features
✓ Kept your custom question-template.md (I can see you made changes!)
✓ Updated framework-template.md

I noticed you customized question-template.md, so I kept your version.
If you want to see what's new in the latest version, check your backup at:
  ~/.researchkit.backup.20251025_143000/templates/question-template.md

You can copy any new features you want from there! 📝
```

---

## Idempotency Guarantee

Running `./update.sh` multiple times with the same target version must:
- Detect already up-to-date state
- Exit successfully without changes
- Not create redundant backups
- Not produce errors

**Safe Operations:**
- Check version before proceeding
- Only update files that changed
- Preserve user customizations consistently

---

## Performance Expectations

| Operation | Expected Time | Max Acceptable Time |
|-----------|---------------|---------------------|
| Version check | < 1 second | < 2 seconds |
| Backup creation | < 2 seconds | < 5 seconds |
| File updates | < 3 seconds | < 10 seconds |
| Full update | < 5 seconds | < 15 seconds |

**Note:** Times assume local file operations. Network operations (future versions) may be slower.

---

## Examples

### Example 1: Standard Update

```bash
$ ./update.sh
==> ResearchKit Updater
==> Detected installation: /home/user/.researchkit
==> Current version: 1.0.0
==> Target version: 1.1.0
✓ Update complete!
$ echo $?
0
```

### Example 2: Already Up-to-Date

```bash
$ ./update.sh
==> ResearchKit Updater
==> Current version: 1.1.0
✓ Already at latest version (1.1.0)
$ echo $?
0
```

### Example 3: Update to Specific Version

```bash
$ ./update.sh --version 1.2.0
==> ResearchKit Updater
==> Current version: 1.1.0
==> Target version: 1.2.0
✓ Update complete!
```

### Example 4: Update Without Backup

```bash
$ ./update.sh --no-backup
==> ResearchKit Updater
==> Skipping backup (--no-backup specified)
==> Updating files
✓ Update complete!
```

### Example 5: Update Custom Directory

```bash
$ ./update.sh ~/projects/research/.researchkit
==> ResearchKit Updater
==> Detected installation: /home/user/projects/research/.researchkit
✓ Update complete!
```

---

## Testing Checklist

- [ ] Update from older version to latest
- [ ] Update when already at latest version
- [ ] Update to specific version
- [ ] Update with user-customized templates
- [ ] Update with --no-backup flag
- [ ] Update in --noninteractive mode
- [ ] Update non-existent installation (error)
- [ ] Update with insufficient disk space (backup fails)
- [ ] Update with insufficient permissions
- [ ] Verify backup created correctly
- [ ] Verify user customizations preserved
- [ ] Verify commands synced to Claude Code
- [ ] Run twice (idempotency)
- [ ] Update on macOS
- [ ] Update on Linux
- [ ] Update on WSL
- [ ] Run with shellcheck
