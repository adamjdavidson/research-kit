# Implementation Plan: ResearchKit CLI Installer

**Branch**: `001-researchkit-installer` | **Date**: 2025-10-25 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/001-researchkit-installer/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.claude/commands/speckit.plan.md` for the execution workflow.

## Summary

Build a CLI installer tool that enables quick setup of ResearchKit in any project directory. The installer will automatically create the necessary directory structure (`.researchkit/`, templates, commands), integrate with Claude Code's command system, and provide validation capabilities. Primary user goal: single-command installation that makes ResearchKit workflow commands immediately available. Technical approach will use shell scripts for cross-platform compatibility, file system operations for installation, and integration with Claude Code's `.claude/commands/` directory structure.

## Technical Context

**Language/Version**: Bash 4.0+ (cross-platform shell scripting)
**Primary Dependencies**: Standard POSIX utilities (mkdir, cp, mv, cat, grep), git (optional)
**Storage**: File system operations only (no database)
**Testing**: bats-core (Bash Automated Testing System) with bats-file helpers for filesystem assertions
**Target Platform**: macOS, Linux, Windows with WSL/Git Bash
**Project Type**: CLI tool (single project structure)
**Performance Goals**: Installation completes in under 2 minutes, file operations should complete in seconds
**Constraints**: Must work with Claude Code's existing directory structure (.claude/commands/), minimal external dependencies, idempotent operations
**Scale/Scope**: Single-user local installation, ~20-30 template files, ~5-10 slash commands, supports project directories of any size

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] **Specification-First**: Complete specification exists with user scenarios and acceptance criteria ✓ (spec.md created with 3 prioritized user stories)
- [x] **Test-Driven Development**: Test strategy defined; tests will be written before implementation ✓ (Integration tests for installation, validation, and update workflows; testing framework needs research)
- [x] **Documentation & Contracts**: All interfaces and contracts documented before implementation ✓ (CLI interface contracts and file system contracts will be defined in Phase 1)
- [x] **Incremental Delivery**: Feature broken into prioritized user stories (P1 = MVP) ✓ (P1: Quick Install = MVP, P2: Validation, P3: Updates)
- [x] **Simplicity**: Simplest solution chosen; any complexity justified in "Complexity Tracking" ✓ (Shell scripts are simplest cross-platform approach for file operations)

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
.researchkit/
├── installer/
│   ├── install.sh          # Main installation script
│   ├── validate.sh          # Validation script
│   ├── update.sh            # Update script
│   └── common.sh            # Shared utility functions
├── templates/
│   ├── CLAUDE-template.md
│   ├── constitution-template.md
│   ├── framework-template.md
│   ├── question-template.md
│   ├── research-path-template.md
│   └── story-template.md
├── commands/
│   ├── rk-capture-story.md
│   ├── rk-collect-documents.md
│   ├── rk-constitution.md
│   ├── rk-create-stream.md
│   ├── rk-cross-stream.md
│   ├── rk-find-stories.md
│   ├── rk-frameworks.md
│   ├── rk-identify-paths.md
│   ├── rk-init.md
│   ├── rk-question.md
│   ├── rk-research.md
│   ├── rk-validate.md
│   └── rk-write.md
└── docs/
    └── getting-started.md

tests/
├── integration/
│   ├── test_install.sh
│   ├── test_validate.sh
│   └── test_update.sh
└── fixtures/
    ├── mock-claude-config/
    └── test-projects/

.claude/
└── commands/              # Commands copied here during installation
    └── rk-*.md            # Copied from .researchkit/commands/ (13 files)
```

**Structure Decision**: Single project structure selected. This is a CLI tool that installs ResearchKit components. The `.researchkit/` directory contains the installer scripts, templates, and command definitions. The installer will copy/symlink commands to `.claude/commands/` during installation. Tests use shell integration testing to verify installation, validation, and update behaviors.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No constitution violations. All principles are satisfied:
- Specification exists with testable requirements
- TDD approach defined (tests before implementation)
- Contracts will be documented before coding
- Incremental delivery via P1/P2/P3 priorities
- Simple shell script approach with no unnecessary abstractions
