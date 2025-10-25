# Troubleshooting

Solutions to common ResearchKit issues.

---

## For Absolute Beginners

**New to troubleshooting?** This guide uses terminal commands and assumes basic command-line familiarity.

**If you're not comfortable with terminal commands**, start by running the automatic validator (it fixes most issues):

**In Claude Code, type:**
```
/rk-validate
```

This will automatically check for and fix most common problems.

**Still having issues?** Continue reading this guide for specific solutions, or see the main **[README](../../README.md)** for step-by-step installation help.

---

## Table of Contents

1. [Quick Diagnostics](#quick-diagnostics)
2. [Installation Issues](#installation-issues)
3. [Command Issues](#command-issues)
4. [Update Issues](#update-issues)
5. [Claude Code Integration](#claude-code-integration)
6. [Performance Issues](#performance-issues)
7. [File and Permission Issues](#file-and-permission-issues)
8. [Getting Help](#getting-help)

---

## Quick Diagnostics

**Try these steps first before diving into specific issues.**

### Step 1: Run the Validator

**In Claude Code:**
```
/rk-validate
```

**Or in your terminal:**
```bash
~/.researchkit/installer/validate.sh
```

**What this does:** Automatically checks your ResearchKit installation and fixes most common issues like missing permissions or files.

### Step 2: Check Installation

**In your terminal:**
```bash
ls -la ~/.researchkit
```

**What this does:** Lists the contents of your ResearchKit installation directory.

**You should see:**
```
commands/
templates/
installer/
docs/
.researchkit_version
.install_metadata
config.yaml
```

**If files are missing:** Run `/rk-validate` to restore them.

### Step 3: Check Version

**In your terminal:**
```bash
cat ~/.researchkit/.researchkit_version
```

**What this does:** Shows your installed ResearchKit version.

**You should see:** `1.0.0` (or current version)

### Step 4: Check Claude Code Integration

**In your terminal:**
```bash
ls -la ~/.claude/commands/rk-*.md | wc -l
```

**What this does:** Counts how many ResearchKit commands are installed in Claude Code.

**You should see:** `13` (all commands installed)

**If you see a different number:** Run the installer again: `./install.sh`

---

## Installation Issues

### "Permission denied" During Install

**Symptom**:
```
❌ Cannot write to /Users/you. Please check permissions.
```

**Cause**: Parent directory isn't writable

**Solutions**:

1. **Install to writable location**:
```bash
./install.sh ~/somewhere/writable
```

2. **Fix permissions** (if you own the directory):
```bash
chmod u+w ~
./install.sh
```

3. **Last resort** (not recommended):
```bash
sudo ./install.sh
```

---

### "Claude Code not found" Warning

**Symptom**:
```
⚠️  I couldn't find Claude Code on your system.
```

**Cause**: Claude Code not installed or not at `~/.claude`

**Solutions**:

1. **Install Claude Code first**, then run:
```bash
./install.sh
```

2. **Check Claude Code location**:
```bash
ls -la ~/.claude
```

3. **Manual command installation**:
```bash
mkdir -p ~/.claude/commands
cp ~/.researchkit/commands/*.md ~/.claude/commands/
```

---

### Installation Hangs or Freezes

**Symptom**: Installation doesn't complete

**Causes**:
- Network issues (if installer fetches resources)
- Disk full
- Permission prompts waiting for input

**Solutions**:

1. **Check disk space**:
```bash
df -h ~
```

2. **Run in non-interactive mode**:
```bash
./install.sh --noninteractive
```

3. **Kill and retry**:
```bash
ps aux | grep install.sh
kill [PID]
./install.sh --force
```

---

### "Already installed" Prompt

**Symptom**:
```
==> I found an existing installation from version 1.0.0

Would you like to:
  [U] Update to the latest version
  [K] Keep your current installation
  [C] Cancel
```

**Solutions**:

1. **Update** (recommended):
   - Type `U` and press Enter

2. **Force reinstall**:
```bash
./install.sh --force
```

3. **Clean install**:
```bash
rm -rf ~/.researchkit
./install.sh
```

---

## Command Issues

### Commands Not Found (`/rk-init` doesn't work)

**Symptom**:
```
command not found: /rk-init
```

**Causes**:
1. Claude Code not installed
2. Commands not copied to `~/.claude/commands/`
3. Claude Code session not restarted

**Solutions**:

1. **Check if commands exist**:
```bash
ls ~/.claude/commands/rk-*.md
```

2. **Reinstall commands**:
```bash
./install.sh
```

3. **Restart Claude Code**:
   - Close and reopen Claude Code
   - Commands should now work

4. **Manual verification**:
```bash
cat ~/.claude/commands/rk-init.md
```
   Should show command content.

---

### Commands Execute But Don't Work Correctly

**Symptom**: Command runs but produces wrong output or errors

**Causes**:
- Outdated command files
- Corrupted templates
- Missing templates

**Solutions**:

1. **Validate installation**:
```bash
/rk-validate
```

2. **Update ResearchKit**:
```bash
cd research-kit
git pull
./install.sh
```

3. **Check template exists**:
```bash
ls ~/.researchkit/templates/
```

4. **Reinstall**:
```bash
./install.sh --force
```

---

### `/rk-init` Creates Wrong Structure

**Symptom**: `.researchkit/` folder has missing or incorrect directories

**Cause**: Outdated command file

**Solutions**:

1. **Update command**:
```bash
cd research-kit
git pull
./install.sh
```

2. **Check command content**:
```bash
cat ~/.claude/commands/rk-init.md
```

3. **Manually create structure**:
```bash
mkdir -p .researchkit/{questions,research-paths/paths,documents/{foundational,recent-reviews,supplementary},stories/{meta,by-concept},streams,synthesis/frameworks,writing}
```

---

## Update Issues

### Update Says "Already Up-to-Date" But I'm Not

**Symptom**:
```
Good news - you're already on the latest version!
```

**Cause**: Version file not updated

**Solutions**:

1. **Check version**:
```bash
cat ~/.researchkit/.researchkit_version
```

2. **Force update**:
```bash
# Temporarily change version
echo "0.9.0" > ~/.researchkit/.researchkit_version

# Run update
~/.researchkit/installer/update.sh
```

3. **Fresh install**:
```bash
rm -rf ~/.researchkit
./install.sh
```

---

### Update Fails with "Backup Failed"

**Symptom**:
```
❌ Oops! I ran into a problem while updating ResearchKit.
I couldn't create a backup of your current ResearchKit.
```

**Causes**:
- Disk full
- Permission issues

**Solutions**:

1. **Check disk space**:
```bash
df -h ~
```

2. **Skip backup** (not recommended):
```bash
~/.researchkit/installer/update.sh --no-backup
```

3. **Free up space**:
```bash
# Remove old backups
rm -rf ~/.researchkit.backup.*
```

---

### Update Overwrote My Custom Templates

**Symptom**: Custom template modifications lost after update

**Cause**: Updater should preserve customizations, but if manifest is missing, it can't detect them

**Solutions**:

1. **Restore from backup**:
```bash
# Find backup
ls -la ~ | grep researchkit.backup

# Restore specific template
cp ~/.researchkit.backup.20251025_142230/templates/my-template.md ~/.researchkit/templates/
```

2. **Prevent future overwrites**:
   - Keep custom templates in separate directory
   - Symlink to `~/.researchkit/templates/`

3. **Version control your customizations**:
```bash
cd ~/.researchkit
git init
git add templates/
git commit -m "My custom templates"
```

---

## Claude Code Integration

### Commands Show in List But Don't Execute

**Symptom**: `/rk-init` appears in autocomplete but doesn't run

**Cause**: Command file corrupted or malformed

**Solutions**:

1. **Check file integrity**:
```bash
cat ~/.claude/commands/rk-init.md
```

2. **Reinstall commands**:
```bash
cp ~/.researchkit/commands/*.md ~/.claude/commands/
```

3. **Restart Claude Code**

---

### Commands Work in Some Folders But Not Others

**Symptom**: `/rk-init` works in one directory but not another

**Cause**: This is actually correct behavior - commands are global but create project-specific data

**Explanation**:
- Commands (`/rk-*`) work in ALL directories
- They create `.researchkit/` in CURRENT directory
- Each project has its own `.researchkit/` folder

**Not a bug!**

---

### Autocomplete Shows Old Command Names

**Symptom**: Outdated command names appear

**Cause**: Claude Code cached old commands

**Solutions**:

1. **Restart Claude Code**

2. **Clear Claude Code cache** (if available)

3. **Verify command files**:
```bash
ls ~/.claude/commands/rk-*.md
```

---

## Performance Issues

### Installation Takes Longer Than 2 Minutes

**Symptom**: Installation exceeds expected 1-2 minute duration

**Causes**:
- Slow disk I/O
- Network latency (if fetching resources)
- Large number of files

**Solutions**:

1. **Check disk speed**:
```bash
time dd if=/dev/zero of=~/test.tmp bs=1M count=100
rm ~/test.tmp
```

2. **Use SSD** if available

3. **Close other applications**

---

### Commands Execute Slowly

**Symptom**: `/rk-question` takes a long time to respond

**Cause**: This is Claude's processing time, not ResearchKit

**Normal behavior**: Commands involve Claude processing, which can take time

**Not a ResearchKit issue**

---

## File and Permission Issues

### "File not found" Errors

**Symptom**:
```
Error: ~/.researchkit/templates/question-template.md not found
```

**Solutions**:

1. **Run validator**:
```bash
/rk-validate
```
   Auto-fixes missing files.

2. **Check what's missing**:
```bash
ls ~/.researchkit/templates/
```

3. **Reinstall**:
```bash
./install.sh --force
```

---

### "Permission denied" on Installer Scripts

**Symptom**:
```
bash: ~/.researchkit/installer/install.sh: Permission denied
```

**Cause**: Scripts not executable

**Solutions**:

1. **Run validator** (auto-fixes):
```bash
~/.researchkit/installer/validate.sh
```

2. **Manual fix**:
```bash
chmod +x ~/.researchkit/installer/*.sh
```

---

### Can't Edit Templates

**Symptom**: Permission denied when editing

**Cause**: File ownership or permissions

**Solutions**:

1. **Check ownership**:
```bash
ls -la ~/.researchkit/templates/
```

2. **Fix ownership**:
```bash
chown -R $USER ~/.researchkit
```

3. **Fix permissions**:
```bash
chmod -R u+w ~/.researchkit/templates/
```

---

## Platform-Specific Issues

### macOS: "Developer Tools" Prompt

**Symptom**: Installer triggers Xcode command line tools prompt

**Cause**: Git or other developer tools not installed

**Solution**:
```bash
xcode-select --install
```

---

### Linux: "Command not found: shasum"

**Symptom**: Checksums fail

**Cause**: `shasum` not available (use `sha256sum` instead)

**Fix**: Update `common.sh` to use `sha256sum`:
```bash
checksum_file() {
    sha256sum "$1" | awk '{print $1}'
}
```

---

### WSL: "Cannot find Windows path"

**Symptom**: Installation fails with Windows path errors

**Cause**: Running installer from Windows path instead of WSL path

**Solution**:
```bash
# Run from WSL home
cd ~
git clone ... research-kit
cd research-kit
./install.sh
```

---

## Data Issues

### Lost Research Data

**Symptom**: Project `.researchkit/` folder disappeared

**Causes**:
- Accidentally deleted
- Wrong directory

**Solutions**:

1. **Check if you're in right directory**:
```bash
pwd
ls -la .researchkit
```

2. **Search for it**:
```bash
find ~ -name ".researchkit" -type d
```

3. **Restore from backup** (if you have one):
```bash
# Time Machine (macOS)
# Or your backup solution
```

**Prevention**:
- Use version control (Git) for research projects
- Regular backups

---

### Constitution Disappeared

**Symptom**: `constitution.md` missing from project

**Cause**: Not created yet or deleted

**Solutions**:

1. **Re-create**:
```bash
/rk-constitution
```

2. **Check if it exists**:
```bash
ls .researchkit/constitution.md
```

---

## Getting Help

### Self-Help Checklist

Before asking for help, try:

1. ✅ Run `/rk-validate`
2. ✅ Check version: `cat ~/.researchkit/.researchkit_version`
3. ✅ Review this troubleshooting guide
4. ✅ Check [Installation Guide](installation-guide.md)
5. ✅ Try fresh install: `rm -rf ~/.researchkit && ./install.sh`

---

### Reporting Issues

When reporting issues, include:

1. **Your environment**:
```bash
echo "OS: $(uname -s)"
echo "Version: $(cat ~/.researchkit/.researchkit_version)"
echo "Install dir: $(ls -la ~/.researchkit)"
```

2. **What you tried**:
   - Exact commands run
   - Error messages (full text)

3. **Expected vs. actual behavior**

4. **Validation output**:
```bash
/rk-validate
```

---

### Where to Get Help

1. **Documentation**:
   - [Installation Guide](installation-guide.md)
   - [Commands Reference](commands-reference.md)
   - [Architecture](architecture.md)

2. **GitHub**:
   - [Report an issue](https://github.com/adamjdavidson/research-kit/issues)
   - [Discussions](https://github.com/adamjdavidson/research-kit/discussions)

3. **Community**:
   - [Your community forum/Slack/Discord]

---

## Advanced Troubleshooting

### Enable Debug Mode

Add debug output to scripts:

```bash
# In install.sh or other scripts
set -x  # Enable debug tracing
```

### Check Installer Logs

```bash
# Run with output saved
./install.sh 2>&1 | tee install.log
```

### Manual Installation

If installer fails completely:

```bash
# Create directories
mkdir -p ~/.researchkit/{commands,templates,installer,docs}

# Copy files manually
cp -r .researchkit/commands/* ~/.researchkit/commands/
cp -r .researchkit/templates/* ~/.researchkit/templates/
cp -r .researchkit/installer/* ~/.researchkit/installer/
cp -r .researchkit/docs/* ~/.researchkit/docs/

# Make executable
chmod +x ~/.researchkit/installer/*.sh

# Copy to Claude Code
mkdir -p ~/.claude/commands
cp ~/.researchkit/commands/*.md ~/.claude/commands/

# Create version file
echo "1.0.0" > ~/.researchkit/.researchkit_version
```

---

## Next Steps

- **Back to basics**: [Getting Started](getting-started.md)
- **Understand commands**: [Commands Reference](commands-reference.md)
- **Technical details**: [Architecture](architecture.md)
