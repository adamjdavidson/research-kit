# Data Model: ResearchKit CLI Installer

**Feature**: 001-researchkit-installer
**Date**: 2025-10-25

## Overview

The ResearchKit CLI Installer is primarily a file-manipulation tool with no database or complex data structures. This document defines the key entities and their relationships as they exist in the file system.

---

## Entity: Installation

**Description**: Represents a ResearchKit installation in a specific directory.

### Attributes

- **install_dir** (string, path): Root directory of the installation (e.g., `$HOME/.researchkit`)
- **version** (string): Version of ResearchKit installed (stored in `.researchkit_version` file)
- **install_date** (ISO 8601 timestamp): When installation was created
- **last_updated** (ISO 8601 timestamp): When installation was last modified
- **install_type** (enum): `fresh` | `update` | `repair`

### File System Representation

```
.researchkit/
├── .researchkit_version    # Version identifier (e.g., "1.0.0")
├── .install_manifest       # List of installed files with checksums
└── .install_metadata       # JSON with install_date, last_updated, install_type
```

### Validation Rules

- `install_dir` must be writable
- `version` must match semantic versioning format (X.Y.Z)
- `install_date` cannot be in the future
- `last_updated` must be >= `install_date`

### State Transitions

```
[No Installation] --install--> [Fresh Installation]
[Fresh Installation] --update--> [Updated Installation]
[Updated Installation] --repair--> [Repaired Installation]
[Any State] --uninstall--> [No Installation]
```

---

## Entity: Template

**Description**: A markdown template file for research workflows.

### Attributes

- **name** (string): Template identifier (e.g., "research-plan", "narrative-outline")
- **file_path** (string, path): Relative path within `.researchkit/templates/`
- **checksum** (string, SHA256): File integrity hash
- **required** (boolean): Whether template is required for valid installation
- **user_customized** (boolean): Whether user has modified the template

### File System Representation

```
.researchkit/templates/
├── research-plan.md
├── narrative-outline.md
├── source-tracking.md
├── analysis-template.md
└── constitution-research.md
```

### Validation Rules

- `name` must be unique within installation
- `file_path` must exist and be readable
- `checksum` must match manifest entry (if not user_customized)
- Required templates must not be deleted

### Relationships

- **belongs_to**: Installation (many templates per installation)
- **used_by**: Research projects (templates are copied to project directories)

---

## Entity: Command

**Description**: A slash command for Claude Code that executes ResearchKit workflows.

### Attributes

- **name** (string): Command identifier (e.g., "researchkit.research", "researchkit.narrative")
- **source_path** (string, path): Path in `.researchkit/commands/`
- **target_path** (string, path): Path in `.claude/commands/` after installation
- **checksum** (string, SHA256): File integrity hash
- **description** (string): One-line description of command purpose

### File System Representation

**Source (before installation):**
```
.researchkit/commands/
├── researchkit.research.md
├── researchkit.narrative.md
├── researchkit.sources.md
├── researchkit.analyze.md
└── researchkit.validate.md
```

**Target (after installation):**
```
.claude/commands/
├── researchkit.research.md     # Copied from source
├── researchkit.narrative.md    # Copied from source
├── researchkit.sources.md      # Copied from source
├── researchkit.analyze.md      # Copied from source
└── researchkit.validate.md     # Copied from source
```

### Validation Rules

- `name` must start with "researchkit."
- `source_path` must exist in `.researchkit/commands/`
- `target_path` must be writable (`.claude/commands/` exists)
- Command file must be valid markdown
- Command must define expected prompt structure

### Relationships

- **belongs_to**: Installation (many commands per installation)
- **integrates_with**: Claude Code command system

---

## Entity: Configuration

**Description**: Installation-wide settings and preferences.

### Attributes

- **template_dir** (string, path): Directory containing templates
- **command_dir** (string, path): Directory containing command definitions
- **auto_update** (boolean): Whether to check for updates automatically
- **backup_on_update** (boolean): Whether to backup before updates
- **interactive_mode** (boolean): Whether to prompt for confirmations
- **log_level** (enum): `silent` | `normal` | `verbose`

### File System Representation

```
.researchkit/config.yaml

# Example contents:
template_dir: "$HOME/.researchkit/templates"
command_dir: "$HOME/.researchkit/commands"
auto_update: false
backup_on_update: true
interactive_mode: true
log_level: normal
```

### Validation Rules

- `template_dir` and `command_dir` must be readable directories
- Boolean values must be `true` or `false`
- `log_level` must be one of: `silent`, `normal`, `verbose`

### Relationships

- **belongs_to**: Installation (one configuration per installation)

---

## Entity: Validation Report

**Description**: Results of installation health checks.

### Attributes

- **timestamp** (ISO 8601): When validation was performed
- **overall_status** (enum): `healthy` | `warnings` | `errors`
- **checks** (array): List of individual check results
  - **check_name** (string): Name of the check (e.g., "directory_structure")
  - **status** (enum): `pass` | `fail`
  - **message** (string): Human-readable result description
  - **details** (string, optional): Additional error/warning information

### Example Structure

```json
{
  "timestamp": "2025-10-25T14:30:00Z",
  "overall_status": "warnings",
  "checks": [
    {
      "check_name": "directory_structure",
      "status": "pass",
      "message": "All required directories exist"
    },
    {
      "check_name": "templates",
      "status": "fail",
      "message": "Missing templates (1/5)",
      "details": "Missing: templates/research-plan.md"
    },
    {
      "check_name": "commands",
      "status": "pass",
      "message": "All commands installed (5/5)"
    },
    {
      "check_name": "claude_integration",
      "status": "pass",
      "message": "Commands found in .claude/commands/"
    },
    {
      "check_name": "permissions",
      "status": "fail",
      "message": "File permission issues",
      "details": "Not executable: installer/validate.sh"
    }
  ]
}
```

### Validation Rules

- `timestamp` must not be in the future
- `overall_status` = `errors` if any check has `status: fail`
- `overall_status` = `healthy` if all checks have `status: pass`
- Each check must have `check_name`, `status`, and `message`

### Relationships

- **generated_by**: Validation command (`validate.sh`)
- **validates**: Installation

---

## Entity Relationships

```
Installation (1) ---has_many---> Templates (N)
Installation (1) ---has_many---> Commands (N)
Installation (1) ---has_one----> Configuration (1)
Installation (1) ---generates--> Validation Reports (N)

Commands (N) ---copied_to----> Claude Code Commands Directory
Templates (N) ---copied_to----> User Research Projects
```

---

## File System Layout Summary

```
$HOME/.researchkit/                    # Installation root
├── .researchkit_version               # Version file (Installation entity)
├── .install_manifest                  # File checksums
├── .install_metadata                  # Install date, last updated
├── config.yaml                        # Configuration entity
├── installer/                         # Installer scripts
│   ├── install.sh
│   ├── validate.sh
│   ├── update.sh
│   └── common.sh
├── templates/                         # Template entities
│   ├── research-plan.md
│   ├── narrative-outline.md
│   ├── source-tracking.md
│   ├── analysis-template.md
│   └── constitution-research.md
├── commands/                          # Command entities (source)
│   ├── researchkit.research.md
│   ├── researchkit.narrative.md
│   ├── researchkit.sources.md
│   ├── researchkit.analyze.md
│   └── researchkit.validate.md
└── docs/                              # Documentation
    ├── quickstart.md
    ├── commands.md
    └── workflow.md

$HOME/.claude/commands/                # Claude Code integration
└── researchkit.*.md                   # Copied Command entities
```

---

## Notes

- No database or complex data structures - all entities are files
- Validation primarily checks file existence, permissions, and checksums
- State is tracked in simple text files (version, manifest, metadata)
- Configuration uses YAML for human readability and editability
- Validation reports can be output as JSON for tooling or text for humans
