# Feature Specification: ResearchKit CLI Installer

**Feature Branch**: `001-researchkit-installer`
**Created**: 2025-10-25
**Status**: Draft
**Input**: User description: "CLI tool for installing ResearchKit in command line using Claude Code"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Quick Install from Scratch (Priority: P1)

A researcher (possibly non-technical) wants to set up ResearchKit using a simple, guided installation process. The installer should automatically detect their system, explain each step in plain English, provide reassuring progress updates, and give clear next steps upon completion. Users should feel confident and supported throughout the installation, with built-in troubleshooting if anything goes wrong.

**Why this priority**: This is the core functionality that delivers immediate value. Without a working installation, users cannot use any ResearchKit features. This represents the minimum viable product. **Critical**: Many users are not technical, so the installation experience must be exceptionally clear and friendly.

**Independent Test**: Can be fully tested by running the installer command and verifying: (1) friendly messages appear throughout, (2) all ResearchKit commands become available, (3) clear next steps are provided, (4) errors (if any) include plain-English solutions.

**Acceptance Scenarios**:

1. **Given** a user runs the installer, **When** installation begins, **Then** they see a friendly welcome message explaining what will happen ("I'll set up ResearchKit on your computer - this will take about 1 minute...")
2. **Given** installation is in progress, **When** each step completes, **Then** user sees reassuring progress messages ("✓ Research templates installed", "✓ Commands ready to use")
3. **Given** the installer has completed successfully, **When** showing the completion message, **Then** user receives clear next steps in plain English ("Success! Type /rk-init in any folder to start your first research project")
4. **Given** the installer encounters an error (missing dependencies, permissions issues), **When** installation fails, **Then** user receives a friendly error message explaining the problem and exact steps to fix it ("Oops! I couldn't create a folder. Try running: mkdir -p ~/.researchkit")
5. **Given** user already has ResearchKit installed, **When** they run the installer again, **Then** they receive a friendly explanation and clear options ("I found an existing installation from Oct 25. Would you like to update it or keep it as-is?")
6. **Given** installation completes, **When** user reads final message, **Then** they understand exactly how to use ResearchKit ("/rk-init creates a new research project, /rk-research starts researching, see ~/.researchkit/docs/getting-started.md for more")

---

### User Story 2 - Verify Installation Health (Priority: P2)

After installation, users want to verify that ResearchKit is working correctly. The validation should automatically check everything, fix common issues, and provide a simple "all good" or "here's what I fixed" message. Users should never see technical error messages without clear guidance on what to do.

**Why this priority**: Ensures users have confidence that their installation is correct and helps troubleshoot problems. This is secondary to getting a basic installation working but important for user success. **Critical**: Auto-fix by default so non-technical users don't need to manually repair issues.

**Independent Test**: Can be tested by running the validation command after a fresh installation (should show "all good"), deliberately breaking something (should auto-fix and report what was fixed), and verifying non-technical users understand all messages.

**Acceptance Scenarios**:

1. **Given** a successful ResearchKit installation, **When** user runs the validation command, **Then** they receive a friendly confirmation ("✓ Everything looks great! ResearchKit is ready to use.")
2. **Given** a file permission issue, **When** user runs validation, **Then** it automatically fixes the issue and reports in plain English ("I fixed a permission issue with your templates folder")
3. **Given** a missing template file, **When** user runs validation, **Then** it attempts to restore from backup and explains what happened ("I restored research-plan.md from backup - you're all set!")
4. **Given** validation cannot auto-fix an issue, **When** reporting the problem, **Then** user receives step-by-step instructions in plain English ("To fix this, open Terminal and type: mkdir ~/.researchkit/templates")

---

### User Story 3 - Update Existing Installation (Priority: P3)

Users with an existing ResearchKit installation want to upgrade to the latest version. They need reassurance that their research data is safe, clear explanation of what will change, and confidence that the update process is risk-free. The updater should explain everything before making changes and preserve all user research and customizations automatically.

**Why this priority**: Important for long-term maintenance but not critical for initial adoption. Users can manually update files if needed, making this lower priority than getting the initial installation working. **Critical**: Users need reassurance that their research won't be lost.

**Independent Test**: Can be tested by installing an older version, creating research files, running the updater, and verifying: (1) research files are untouched, (2) user sees clear explanation before update, (3) user knows what changed after update.

**Acceptance Scenarios**:

1. **Given** user runs the update command, **When** update begins, **Then** they see a clear explanation of what will happen ("I'll update ResearchKit commands. Your research files are safe and won't be touched.")
2. **Given** update is in progress, **When** files are being updated, **Then** user sees reassuring progress ("✓ Updated rk-research command", "✓ Your templates are safe")
3. **Given** user has customized templates, **When** update runs, **Then** customizations are automatically preserved and user is informed ("I kept your custom research-plan template")
4. **Given** update completes successfully, **When** showing completion message, **Then** user sees a summary of what changed ("Updated 13 commands, preserved 2 custom templates. You're all set!")
5. **Given** an error occurs during update, **When** reporting the problem, **Then** user receives reassurance and clear fix steps ("Don't worry - your research is safe. To complete the update: [clear steps]")

---

### Edge Cases

- What happens when the installer is run without proper permissions (e.g., read-only directory)?
- How does the system handle partial installations that failed midway?
- What happens if Claude Code is not properly configured or available?
- How does the installer behave in a git repository vs. non-git directory?
- What happens when required directory structures already exist but are incomplete?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST create the ResearchKit directory structure including `.researchkit/`, templates, and command directories
- **FR-002**: System MUST install all ResearchKit slash commands into the appropriate Claude Code commands directory
- **FR-003**: System MUST copy all research workflow templates (6 templates: CLAUDE-template.md, constitution-template.md, framework-template.md, question-template.md, research-path-template.md, story-template.md) to the templates directory
- **FR-004**: System MUST validate that Claude Code is available and properly configured before installation
- **FR-005**: System MUST provide a single command entry point that handles the entire installation process
- **FR-006**: System MUST check for existing installations and prevent accidental overwrites without user confirmation
- **FR-007**: System MUST create a constitution file tailored for research workflows (similar to SpecKit's constitution)
- **FR-008**: System MUST provide clear progress indicators during installation showing which components are being installed
- **FR-009**: System MUST validate installation integrity after completion and report any issues
- **FR-010**: System MUST work on common platforms (macOS, Linux, Windows with WSL)
- **FR-011**: System MUST generate initial documentation explaining available commands and basic workflow
- **FR-012**: System MUST preserve existing files when updating an installation (non-destructive updates)
- **FR-013**: System MUST use plain English messaging throughout, avoiding technical jargon (e.g., "Setting up your research workspace" not "Creating directory structure")
- **FR-014**: System MUST provide reassuring progress updates for each major step ("✓ Research templates installed", "✓ Commands ready to use")
- **FR-015**: System MUST display clear "next steps" guidance after installation completes ("Type /rk-init in any folder to start researching")
- **FR-016**: System MUST include a friendly welcome message explaining what will happen ("I'll set up ResearchKit - this takes about 1 minute")
- **FR-017**: System MUST provide step-by-step troubleshooting for common errors (permissions, missing dependencies, disk space)
- **FR-018**: Validation MUST attempt to auto-fix common issues by default (permissions, missing files, etc.) rather than requiring manual user intervention
- **FR-019**: Error messages MUST include both the problem AND the solution in plain English ("Oops! I couldn't create a folder. Try: mkdir -p ~/.researchkit")
- **FR-020**: System MUST reassure users that their research data is safe during updates ("Your research files won't be touched")
- **FR-021**: System MUST detect user's platform automatically and adapt messages accordingly ("I see you're on macOS...")

### Key Entities

- **Installation Package**: Collection of templates, commands, configuration files, and scripts that comprise ResearchKit
- **Configuration**: Settings that define ResearchKit behavior, directory structure, and command availability
- **Template Set**: Research-specific templates (6 templates) for research planning, constitution building, framework analysis, question development, research paths, and story capture
- **Command Registry**: Slash commands (13 commands) that integrate with Claude Code for research workflows: /rk-init, /rk-research, /rk-validate, /rk-write, /rk-question, /rk-constitution, /rk-frameworks, /rk-identify-paths, /rk-create-stream, /rk-cross-stream, /rk-find-stories, /rk-capture-story, /rk-collect-documents
- **Validation Report**: Health check results showing installation integrity and any issues detected

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Installation completes in under 2 minutes on a standard development machine
- **SC-002**: Users can execute ResearchKit commands through Claude Code within 30 seconds of installation completion
- **SC-003**: Installation success rate exceeds 95% for users with Claude Code properly configured
- **SC-004**: Validation command automatically fixes 90% of common issues without user intervention
- **SC-005**: Users can complete a basic research workflow (create research plan → add sources → generate narrative outline) within 5 minutes of installation
- **SC-006**: 95% of non-technical users understand all installation messages without external help
- **SC-007**: Update process preserves 100% of existing user research projects and customizations
- **SC-008**: Error messages include clear solutions 100% of the time (never show "error" without explaining how to fix it)
- **SC-009**: 90% of users know exactly what to do next after installation completes (measured by understanding "Type /rk-init to start")
- **SC-010**: Zero technical jargon in user-facing messages (all messages use plain English)

## Assumptions *(optional)*

- Users have Claude Code already installed and configured
- **Users may have little to no command-line experience** (installer must guide them)
- Users have read/write permissions in their home directory (standard for personal computers)
- No internet connection required after initial installer download (all files bundled)
- Git is not required (optional for advanced users only)

## Out of Scope *(optional)*

- Teaching users how to conduct research or write essays (that's ResearchKit's job)
- Installing or configuring Claude Code itself (prerequisite)
- Creating custom research templates beyond the standard set
- Integration with specific research tools or databases
- Automatic updates or update notifications
- Multi-user or team collaboration features
- Cloud-based installation or hosted versions
