# Installation Guide

Complete guide to installing, updating, and troubleshooting ResearchKit.

---

## For Absolute Beginners

**New to command line/terminal?** This guide assumes you're comfortable with basic terminal commands.

**If you don't know what a terminal is or how to use it**, please start with the main **[README](../../README.md)** instead. The README has step-by-step instructions with:
- How to open your terminal (Mac/Windows/Linux)
- What each command does
- What you'll see when it works
- Troubleshooting for common issues

**Come back to this guide** after you've successfully installed using the README, or if you want technical details about the installation process.

---

## Table of Contents

1. [Installation](#installation)
2. [What Gets Installed](#what-gets-installed)
3. [Updating ResearchKit](#updating-researchkit)
4. [Validating Installation](#validating-installation)
5. [Uninstalling](#uninstalling)
6. [Advanced Installation](#advanced-installation)
7. [Troubleshooting](#troubleshooting)

---

## Installation

### Quick Install (For Those Comfortable with Terminal)

**In your terminal, run these commands:**

```bash
git clone https://github.com/adamjdavidson/research-kit.git
cd research-kit
./install.sh
```

**What this does:**
- `git clone` - Downloads ResearchKit from GitHub to your computer
- `cd research-kit` - Moves into the ResearchKit directory
- `./install.sh` - Runs the installer script

**What you'll see:** Friendly installation messages showing progress, ending with "All done! 🎉"

### What Happens During Installation

The installer:
1. **Detects your platform** (macOS, Linux, or Windows WSL)
2. **Creates `~/.researchkit/`** directory structure
3. **Copies templates** (6 research templates)
4. **Copies commands** (13 research commands)
5. **Installs to Claude Code** (copies commands to `~/.claude/commands/`)
6. **Creates metadata files** (version, manifest, config)

Installation takes about **1 minute** and requires about **10 MB** of disk space.

### Installation Output

You'll see friendly messages like:

```
==> Welcome to ResearchKit! 🔬

I'll set up ResearchKit on your computer - this takes about 1 minute.

I see you're on macOS - perfect!

==> Setting up your research workspace...
[OK] Research templates installed (6 templates ready to use)
[OK] Commands ready to use (13 research commands)
[OK] Claude Code integration complete
[OK] Documentation added

==> All done! 🎉

Next steps:
  1. Open any folder where you want to do research
  2. Type: /rk-init
  3. Start researching with: /rk-research

Your ResearchKit commands:
  • /rk-init - Start researching in current folder
  • /rk-research - Deep research workflow
  • /rk-validate - Check installation health
```

---

## What Gets Installed

### Directory Structure

```
~/.researchkit/
├── commands/              # 13 command files
│   ├── rk-init.md
│   ├── rk-research.md
│   ├── rk-question.md
│   └── ... (10 more)
├── templates/             # 6 template files
│   ├── question-template.md
│   ├── framework-template.md
│   ├── story-template.md
│   └── ... (3 more)
├── installer/             # Installer scripts
│   ├── install.sh
│   ├── update.sh
│   ├── validate.sh
│   └── common.sh
├── docs/                  # Documentation
│   ├── getting-started.md
│   ├── installation-guide.md
│   └── ... (more docs)
├── .researchkit_version   # Version file
├── .install_metadata      # Installation metadata
├── .install_manifest      # File checksums
└── config.yaml            # Configuration
```

### Claude Code Integration

Commands are also copied to:
```
~/.claude/commands/
├── rk-init.md
├── rk-research.md
├── rk-question.md
└── ... (all 13 commands)
```

This makes them available in any Claude Code session via `/rk-*` commands.

---

## Updating ResearchKit

### Method 1: Git Pull + Reinstall (Recommended)

**In your terminal, run these commands:**

```bash
cd research-kit
git pull
./install.sh
```

**What this does:**
- `cd research-kit` - Moves into the ResearchKit directory
- `git pull` - Downloads the latest version from GitHub
- `./install.sh` - Runs the installer (detects existing installation and offers to update)

**What you'll see:** The installer detects existing installations and offers to update:

```
==> I found an existing installation from version 1.0.0

Would you like to:
  [U] Update to the latest version
  [K] Keep your current installation
  [C] Cancel

Your choice (U/K/C):
```

### Method 2: Built-in Updater

```bash
~/.researchkit/installer/update.sh
```

### What Happens During Update

The updater:
1. **Creates a timestamped backup** (e.g., `~/.researchkit.backup.20251025_142230`)
2. **Detects customizations** (checks file checksums)
3. **Updates system files** (installer scripts, commands)
4. **Preserves your modifications** (skips modified templates)
5. **Updates version metadata**

### Update Output

```
==> Great news! I found some updates for ResearchKit. 🔬

I'll update ResearchKit for you - this will only take a moment.
Your research files are safe and won't be touched.

I see you're on version 1.0.0, and I'll update you to 1.1.0.

First, I'll make a backup of everything (just to be safe)...
[OK] Backup created - your current setup is saved

==> Updating your ResearchKit...
[OK] Updated installer tools
[OK] Everything synced with Claude Code

==> All done! 🎉

What changed:
  • 5 templates got new features
  • 1 template kept your customizations
  • 13 commands updated with improvements

Your backup is here if you need it:
  ~/.researchkit.backup.20251025_142230
```

### Skip Backup (Not Recommended)

```bash
~/.researchkit/installer/update.sh --no-backup
```

---

## Validating Installation

Check if ResearchKit is healthy and auto-fix common issues.

**From within Claude Code, run:**

```
/rk-validate
```

**Or from your terminal, run:**

```bash
~/.researchkit/installer/validate.sh
```

**What this does:** Checks if all ResearchKit files are present and working, and automatically fixes common issues like missing permissions.

### Validation Checks

The validator checks:
- ✓ Directory structure (installer, templates, commands, docs)
- ✓ All 6 templates present
- ✓ All 13 commands present
- ✓ Claude Code integration
- ✓ File permissions (scripts are executable)

### Healthy Installation

```
==> Checking your ResearchKit installation... 🔍

[OK] Everything looks great!
[OK] All 6 templates are ready
[OK] All 13 commands are working
[OK] Claude Code integration is perfect

==> ResearchKit is ready to use! 🎉
```

### Auto-Fix

The validator automatically fixes common issues:

```
==> Checking your ResearchKit installation... 🔍

[OK] I found a couple of small issues, so I fixed them for you!

[OK] Made installer/install.sh executable

==> Everything is working now! 🎉

What I fixed:
  • Made installer/install.sh executable

You're all set - ResearchKit is ready to use!
```

### Disable Auto-Fix

```bash
~/.researchkit/installer/validate.sh --no-fix
```

### JSON Output (for scripting)

```bash
~/.researchkit/installer/validate.sh --json
```

Output:
```json
{
  "timestamp": "2025-10-25T18:30:00Z",
  "installation_dir": "/Users/you/.researchkit",
  "overall_status": "healthy",
  "checks": [
    {"name": "templates", "status": "pass", "message": "All templates present (6/6)"},
    {"name": "commands", "status": "pass", "message": "All commands present (13/13)"}
  ],
  "issues_found": [],
  "fixes_applied": []
}
```

---

## Uninstalling

### Remove ResearchKit

**In your terminal, run these commands:**

```bash
rm -rf ~/.researchkit
rm -rf ~/.claude/commands/rk-*.md
```

**What this does:**
- `rm -rf ~/.researchkit` - Removes the ResearchKit system installation
- `rm -rf ~/.claude/commands/rk-*.md` - Removes ResearchKit commands from Claude Code

**⚠️ Important:** This only removes the ResearchKit system files, NOT your research data.

### Your Research Data is Safe

ResearchKit never touches your research projects. When you run `/rk-init`, it creates project directories (`.researchkit/` folders) in your current working directories - these are completely separate from the system installation at `~/.researchkit/`.

**Bottom line:** You can safely uninstall ResearchKit without losing any research projects. Your `.researchkit/` project folders remain untouched.

---

## Advanced Installation

### Custom Installation Directory

```bash
./install.sh ~/custom/path
```

### Non-Interactive Mode

```bash
./install.sh --noninteractive
```

Uses defaults, never prompts.

### Skip Claude Code Integration

```bash
./install.sh --no-commands
```

Installs to `~/.researchkit/` but doesn't copy to `~/.claude/commands/`.

### Force Reinstall

```bash
./install.sh --force
```

Overwrites existing installation without prompting.

### Specific Version

```bash
cd research-kit
git checkout v1.0.0
./install.sh
```

### All Options

```bash
./install.sh --help
```

Output:
```
ResearchKit Installer

USAGE:
    ./install.sh [OPTIONS] [TARGET_DIR]

OPTIONS:
    --force              Overwrite existing installation without prompting
    --noninteractive     Skip all prompts (use defaults)
    --no-commands        Skip Claude Code command installation
    --version VERSION    Install specific version (default: latest)
    --help               Show this help message

ARGUMENTS:
    TARGET_DIR          Installation directory (default: ~/.researchkit)

EXAMPLES:
    ./install.sh
    ./install.sh --force
    ./install.sh ~/my-researchkit
    ./install.sh --no-commands ~/.researchkit
```

---

## Troubleshooting

### "Claude Code not found"

**Symptom**: Warning during installation:
```
⚠️  I couldn't find Claude Code on your system.
```

**Solution**: This is just a warning. ResearchKit installs to `~/.researchkit/` successfully. After you install Claude Code, run the installer again to enable the `/rk-*` commands.

### "Permission denied"

**Symptom**:
```
❌ Cannot write to /Users/you. Please check permissions.
```

**Solution**: The parent directory isn't writable. Try:
```bash
sudo ./install.sh  # Not recommended
# OR
./install.sh ~/somewhere/writable
```

### "command not found: /rk-init"

**Symptom**: Commands don't work in Claude Code

**Possible causes**:
1. **Claude Code not installed**: Install Claude Code first
2. **Installation skipped commands**: Run `./install.sh` again
3. **Wrong Claude Code directory**: Check if `~/.claude/commands/` exists

**Solution**:
```bash
/rk-validate  # Check installation health
./install.sh  # Reinstall if needed
```

### Files Missing After Update

**Symptom**: Templates or commands missing after update

**Solution**: Run the validator with auto-fix:
```bash
~/.researchkit/installer/validate.sh
```

This will restore missing files from the source.

### Restore from Backup

If an update went wrong:

```bash
# Find your backup
ls -la ~ | grep researchkit.backup

# Restore it
rm -rf ~/.researchkit
mv ~/.researchkit.backup.20251025_142230 ~/.researchkit
```

### Check Installation Version

```bash
cat ~/.researchkit/.researchkit_version
```

### Complete Reinstall

```bash
# 1. Remove everything
rm -rf ~/.researchkit
rm -rf ~/.claude/commands/rk-*.md

# 2. Fresh install
cd research-kit
./install.sh
```

---

## Platform-Specific Notes

### macOS

- Uses `~/.zshrc` for shell configuration
- Emoji support in terminal is excellent
- No special requirements

### Linux

- Uses `~/.bashrc` for shell configuration
- Emoji support varies by terminal
- Requires bash 4.0+

### Windows (WSL)

- Uses `~/.bashrc` for shell configuration
- Install in WSL environment, not Windows directly
- Requires WSL 2 recommended

---

## Getting Help

Still having issues?

1. **Check the validator**: `/rk-validate`
2. **Read troubleshooting**: [troubleshooting.md](troubleshooting.md)
3. **Report an issue**: [GitHub Issues](https://github.com/adamjdavidson/research-kit/issues)

---

## Next Steps

- **Start researching**: Read [Getting Started](getting-started.md)
- **Learn the commands**: See [Commands Reference](commands-reference.md)
- **Understand templates**: See [Templates Reference](templates-reference.md)
