# Tasks: ResearchKit CLI Installer

**Input**: Design documents from `/specs/001-researchkit-installer/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Tests are included per TDD requirement from the project constitution.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: `.researchkit/`, `tests/` at repository root
- Paths shown below follow the single project structure from plan.md

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and testing framework setup

- [X] T001 Install bats-core testing framework (macOS: brew install bats-core, Linux: git submodules)
- [X] T002 [P] Install shellcheck linter (macOS: brew install shellcheck, Linux: apt install shellcheck)
- [X] T003 Create project directory structure (.researchkit/{installer,templates,commands,docs}, tests/{integration,fixtures})
- [X] T004 [P] Initialize git submodules for bats helpers (bats-support, bats-assert, bats-file)
- [X] T005 [P] Create template files (6 templates in .researchkit/templates/: CLAUDE-template.md, constitution-template.md, framework-template.md, question-template.md, research-path-template.md, story-template.md)
- [X] T006 [P] Create command definition files (13 commands in .researchkit/commands/: rk-capture-story.md, rk-collect-documents.md, rk-constitution.md, rk-create-stream.md, rk-cross-stream.md, rk-find-stories.md, rk-frameworks.md, rk-identify-paths.md, rk-init.md, rk-question.md, rk-research.md, rk-validate.md, rk-write.md)
- [X] T007 [P] Create documentation files (.researchkit/docs/getting-started.md)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Shared utility functions that ALL user stories depend on

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T008 Create common.sh with shared utility functions in .researchkit/installer/common.sh
- [X] T009 [P] Implement error handling functions (error_handler, abort, need_cmd) in common.sh
- [X] T010 [P] Implement output functions (ohai, success, warn) with TTY detection in common.sh
- [X] T011 [P] Implement platform detection functions (detect_os, detect_arch, detect_profile) in common.sh
- [X] T012 [P] Implement idempotency helper functions (detect_existing_install, backup_if_exists) in common.sh

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Quick Install from Scratch (Priority: P1) 🎯 MVP

**Goal**: Single-command installation that creates all ResearchKit directories, copies templates/commands, and integrates with Claude Code

**Independent Test**: Run installer in empty directory and verify all ResearchKit commands become available in Claude Code immediately

### Tests for User Story 1 (TDD Required)

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T013 [P] [US1] Create test_install.bats with setup/teardown using temp directories in tests/integration/test_install.bats
- [ ] T014 [P] [US1] Write test: "install.sh creates target directory" in tests/integration/test_install.bats
- [ ] T015 [P] [US1] Write test: "install.sh creates all subdirectories" in tests/integration/test_install.bats
- [ ] T016 [P] [US1] Write test: "install.sh copies all 6 templates" in tests/integration/test_install.bats
- [ ] T017 [P] [US1] Write test: "install.sh copies all 13 commands to Claude Code" in tests/integration/test_install.bats
- [ ] T018 [P] [US1] Write test: "install.sh creates version file with semantic version" in tests/integration/test_install.bats
- [ ] T019 [P] [US1] Write test: "install.sh creates install manifest with checksums" in tests/integration/test_install.bats
- [ ] T020 [P] [US1] Write test: "install.sh creates config.yaml with defaults" in tests/integration/test_install.bats
- [ ] T021 [P] [US1] Write test: "install.sh is idempotent (can run twice safely)" in tests/integration/test_install.bats
- [ ] T022 [P] [US1] Write test: "install.sh detects existing installation and warns user" in tests/integration/test_install.bats
- [ ] T023 [P] [US1] Write test: "install.sh handles permission denied errors gracefully" in tests/integration/test_install.bats
- [ ] T024 [P] [US1] Write test: "install.sh updates shell profile with PATH entry" in tests/integration/test_install.bats
- [ ] T024A [P] [US1] Write test: "install.sh detects Claude Code and warns if not available" in tests/integration/test_install.bats

**Run tests - they should FAIL (Red phase)**

### Implementation for User Story 1

- [ ] T025 [US1] Create install.sh stub with shebang and strict mode (set -Eeuo pipefail) in .researchkit/installer/install.sh
- [ ] T026 [US1] Source common.sh and setup error trap in install.sh
- [ ] T027 [US1] Implement argument parsing (TARGET_DIR, --force, --noninteractive, --version, --no-commands) in install.sh
- [ ] T028 [US1] Implement existing installation detection logic in install.sh
- [ ] T029 [US1] Implement directory structure creation (mkdir -p for all subdirectories) in install.sh
- [ ] T030 [US1] Implement template file copying (6 templates from source to .researchkit/templates/) in install.sh
- [ ] T031 [US1] Implement command file copying (13 commands to .claude/commands/) in install.sh
- [ ] T032 [US1] Implement version file creation (.researchkit_version with semantic version) in install.sh
- [ ] T033 [US1] Implement manifest file creation (.install_manifest with SHA256 checksums) in install.sh
- [ ] T034 [US1] Implement metadata file creation (.install_metadata with JSON timestamps) in install.sh
- [ ] T035 [US1] Implement config.yaml generation with default settings in install.sh
- [ ] T036 [US1] Implement shell profile update (detect profile, add PATH if not present) in install.sh
- [ ] T037 [US1] Add friendly welcome message at start ("I'll set up ResearchKit on your computer - this takes about 1 minute...") in install.sh
- [ ] T038 [US1] Add platform detection message ("I see you're on macOS..." or "...Linux" or "...Windows WSL") in install.sh
- [ ] T039 [US1] Implement reassuring progress messages for each major step ("✓ Research templates installed", "✓ Commands ready to use") in install.sh
- [ ] T040 [US1] Add plain-English error messages with solutions (e.g., "Oops! I couldn't create a folder. Try: mkdir -p ~/.researchkit") in install.sh
- [ ] T041 [US1] Add clear "next steps" completion message ("Success! Type /rk-init in any folder to start your first research project") in install.sh
- [ ] T042 [US1] Add existing installation detection with friendly options ("I found an existing installation. Would you like to update it or keep it?") in install.sh
- [ ] T043 [US1] Add detailed usage guidance in final message ("/rk-init creates new project, /rk-research starts researching, see ~/.researchkit/docs/getting-started.md") in install.sh
- [ ] T044 [US1] Implement Claude Code installation detection (.claude/commands/ directory check) in install.sh
- [ ] T044A [US1] Add friendly warning message if Claude Code not detected ("I couldn't find Claude Code on your system. ResearchKit commands are installed locally - you'll need to install Claude Code to use them.") in install.sh
- [ ] T044B [US1] Make install.sh executable (chmod +x)

**Run tests - they should PASS (Green phase)**

### Refactoring for User Story 1

- [ ] T045 [US1] Run shellcheck on install.sh and fix all warnings
- [ ] T046 [US1] Add --help flag with usage documentation to install.sh
- [ ] T047 [US1] Extract file copying logic into reusable function in install.sh
- [ ] T048 [US1] Add validation after installation (verify all 6 templates and 13 commands created) in install.sh

**Run tests - they should STILL PASS**

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently (MVP complete!)

---

## Phase 4: User Story 2 - Verify Installation Health (Priority: P2)

**Goal**: Validation command that checks installation integrity and reports issues with actionable fixes

**Independent Test**: Run validation on fresh installation (should pass), then corrupt a file and verify detection

### Tests for User Story 2 (TDD Required)

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T049 [P] [US2] Create test_validate.bats with fixtures in tests/integration/test_validate.bats
- [ ] T050 [P] [US2] Write test: "validate.sh reports all checks passing for healthy installation (6 templates, 13 commands)" in tests/integration/test_validate.bats
- [ ] T051 [P] [US2] Write test: "validate.sh detects missing directory" in tests/integration/test_validate.bats
- [ ] T052 [P] [US2] Write test: "validate.sh detects missing template file (from 6 templates) and auto-fixes" in tests/integration/test_validate.bats
- [ ] T053 [P] [US2] Write test: "validate.sh detects missing command file (from 13 commands)" in tests/integration/test_validate.bats
- [ ] T054 [P] [US2] Write test: "validate.sh detects non-executable installer scripts and auto-fixes" in tests/integration/test_validate.bats
- [ ] T055 [P] [US2] Write test: "validate.sh detects missing Claude Code integration" in tests/integration/test_validate.bats
- [ ] T056 [P] [US2] Write test: "validate.sh outputs friendly human-readable format by default" in tests/integration/test_validate.bats
- [ ] T057 [P] [US2] Write test: "validate.sh outputs valid JSON with --json flag" in tests/integration/test_validate.bats
- [ ] T058 [P] [US2] Write test: "validate.sh returns exit code 0 for healthy installation" in tests/integration/test_validate.bats
- [ ] T059 [P] [US2] Write test: "validate.sh auto-fixes issues by default (no --fix flag needed)" in tests/integration/test_validate.bats
- [ ] T060 [P] [US2] Write test: "validate.sh provides plain-English explanations for all issues" in tests/integration/test_validate.bats

**Run tests - they should FAIL (Red phase)**

### Implementation for User Story 2

- [ ] T056 [US2] Create validate.sh stub with shebang and strict mode in .researchkit/installer/validate.sh
- [ ] T057 [US2] Source common.sh and setup error trap in validate.sh
- [ ] T058 [US2] Implement argument parsing (INSTALL_DIR, --quiet, --json, --fix) in validate.sh
- [ ] T059 [US2] Implement check 1: directory structure validation in validate.sh
- [ ] T060 [US2] Implement check 2: template files validation (6 templates) in validate.sh
- [ ] T061 [US2] Implement check 3: command files validation (13 commands) in validate.sh
- [ ] T062 [US2] Implement check 4: Claude Code integration check (.claude/commands/) in validate.sh
- [ ] T063 [US2] Implement check 5: file permissions check (executables) in validate.sh
- [ ] T064 [US2] Implement human-readable output format with ✓/✗ symbols in validate.sh
- [ ] T065 [US2] Implement JSON output format (--json flag) in validate.sh
- [ ] T066 [US2] Implement exit code logic (0 for healthy/warnings, 1 for errors) in validate.sh
- [ ] T067 [US2] Implement --fix mode (chmod +x for permissions, restore from backup) in validate.sh
- [ ] T068 [US2] Add actionable suggestions for each type of failure in validate.sh
- [ ] T069 [US2] Make validate.sh executable (chmod +x)
- [ ] T070 [US2] Add friendly confirmation message for healthy installation ("✓ Everything looks great! ResearchKit is ready to use.") in validate.sh
- [ ] T071 [US2] Implement auto-fix by default with reassuring messages ("I fixed a permission issue with your templates folder") in validate.sh
- [ ] T072 [US2] Add plain-English error messages with step-by-step solutions ("To fix this, open Terminal and type: mkdir ~/.researchkit/templates") in validate.sh
- [ ] T073 [US2] Add reassuring tone for non-fixable issues ("Don't worry - your research is safe. Here's how to fix it...") in validate.sh
- [ ] T074 [US2] Add clear explanations of what each check does (avoid technical jargon) in validate.sh
- [ ] T075 [US2] Add friendly "Try it out" message after successful validation with command examples ("/rk-init to start researching") in validate.sh

**Run tests - they should PASS (Green phase)**

### Refactoring for User Story 2

- [ ] T076 [US2] Run shellcheck on validate.sh and fix all warnings
- [ ] T077 [US2] Add --help flag with usage documentation to validate.sh
- [ ] T078 [US2] Extract validation check logic into reusable functions in validate.sh

**Run tests - they should STILL PASS**

**Checkpoint**: User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Update Existing Installation (Priority: P3)

**Goal**: Update command that preserves user customizations while updating system files

**Independent Test**: Install old version, customize templates, run update, verify customizations preserved and system files updated

### Tests for User Story 3 (TDD Required)

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T073 [P] [US3] Create test_update.bats with version fixtures in tests/integration/test_update.bats
- [ ] T074 [P] [US3] Write test: "update.sh detects existing installation" in tests/integration/test_update.bats
- [ ] T075 [P] [US3] Write test: "update.sh creates timestamped backup before update" in tests/integration/test_update.bats
- [ ] T076 [P] [US3] Write test: "update.sh preserves user-modified templates" in tests/integration/test_update.bats
- [ ] T077 [P] [US3] Write test: "update.sh updates system files (installer scripts)" in tests/integration/test_update.bats
- [ ] T078 [P] [US3] Write test: "update.sh updates command files in .claude/commands/" in tests/integration/test_update.bats
- [ ] T079 [P] [US3] Write test: "update.sh preserves config.yaml settings" in tests/integration/test_update.bats
- [ ] T080 [P] [US3] Write test: "update.sh updates version file to new version" in tests/integration/test_update.bats
- [ ] T081 [P] [US3] Write test: "update.sh reports 'already up-to-date' when at latest version" in tests/integration/test_update.bats
- [ ] T082 [P] [US3] Write test: "update.sh --no-backup skips backup creation" in tests/integration/test_update.bats
- [ ] T083 [P] [US3] Write test: "update.sh exits with error when no installation found" in tests/integration/test_update.bats

**Run tests - they should FAIL (Red phase)**

### Implementation for User Story 3

- [ ] T084 [US3] Create update.sh stub with shebang and strict mode in .researchkit/installer/update.sh
- [ ] T085 [US3] Source common.sh and setup error trap in update.sh
- [ ] T086 [US3] Implement argument parsing (INSTALL_DIR, --version, --no-backup, --noninteractive) in update.sh
- [ ] T087 [US3] Implement existing installation detection (error if not found) in update.sh
- [ ] T088 [US3] Implement version comparison logic (current vs target) in update.sh
- [ ] T089 [US3] Implement backup creation (timestamped directory copy) in update.sh
- [ ] T090 [US3] Implement checksum comparison for detecting user modifications in update.sh
- [ ] T091 [US3] Implement selective file updates (system files only, preserve user files) in update.sh
- [ ] T092 [US3] Implement installer script updates (.researchkit/installer/*.sh) in update.sh
- [ ] T093 [US3] Implement command file updates (.researchkit/commands/ and .claude/commands/) in update.sh
- [ ] T094 [US3] Implement documentation updates (.researchkit/docs/*.md) in update.sh
- [ ] T095 [US3] Implement version file update (.researchkit_version) in update.sh
- [ ] T096 [US3] Implement metadata file update (last_updated timestamp) in update.sh
- [ ] T097 [US3] Add user prompts for modified templates (interactive mode) in update.sh
- [ ] T098 [US3] Add progress indicators showing which files updated vs preserved in update.sh
- [ ] T099 [US3] Make update.sh executable (chmod +x)
- [ ] T100 [US3] Add reassurance that research files are safe at the start ("Your research files are safe and won't be touched") in update.sh
- [ ] T101 [US3] Add clear explanation of what will change before making updates ("I'll update 13 commands. Your customizations will be preserved.") in update.sh
- [ ] T102 [US3] Add friendly progress messages during update ("✓ Updated rk-research command", "✓ Your templates are safe") in update.sh
- [ ] T103 [US3] Add summary of what changed after completion ("Updated 13 commands, preserved 2 custom templates. You're all set!") in update.sh
- [ ] T104 [US3] Add reassuring messages about preserved customizations ("I kept your custom research-plan template") in update.sh
- [ ] T105 [US3] Add friendly "already up-to-date" message ("Good news - you're already on the latest version!") in update.sh
- [ ] T106 [US3] Add helpful pointer to backup location with explanation ("Your backup is here if you need it: ~/.researchkit.backup...") in update.sh

**Run tests - they should PASS (Green phase)**

### Refactoring for User Story 3

- [ ] T107 [US3] Run shellcheck on update.sh and fix all warnings
- [ ] T108 [US3] Add --help flag with usage documentation to update.sh
- [ ] T109 [US3] Extract backup logic into reusable function in common.sh

**Run tests - they should STILL PASS**

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Quality improvements that affect multiple user stories

- [ ] T110 [P] Run shellcheck on all .sh files and address remaining warnings
- [ ] T111 [P] Add integration test for complete install → validate → update workflow in tests/integration/test_workflow.bats
- [ ] T112 [P] Test cross-platform compatibility on macOS
- [ ] T113 [P] Test cross-platform compatibility on Linux
- [ ] T114 [P] Test cross-platform compatibility on WSL
- [ ] T115 [P] Test with directory paths containing spaces
- [ ] T116 [P] Verify all exit codes match contracts (install-contract.md, validate-contract.md, update-contract.md)
- [ ] T117 [P] Verify all error messages are actionable (provide clear fix suggestions)
- [ ] T118 [P] Performance testing: verify installation completes in under 2 minutes
- [ ] T119 [P] Add logging to all scripts (optional --verbose mode)
- [ ] T120 Create README.md with installation instructions in .researchkit/
- [ ] T121 Verify quickstart.md matches actual implementation in .researchkit/docs/

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Phase 6)**: Depends on all user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - No dependencies on other stories (validates US1 output but doesn't require US1 implementation)
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - No dependencies on other stories (updates US1 output but doesn't require US1 implementation)

**All three user stories are independently implementable and testable!**

### Within Each User Story

- Tests MUST be written and FAIL before implementation (TDD)
- Implementation proceeds sequentially within each story
- Refactoring occurs after tests pass
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel (Phase 1)
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Once Foundational phase completes, all three user stories can start in parallel (if team capacity allows)
- All tests for a user story marked [P] can be written in parallel
- All Polish tasks marked [P] can run in parallel (Phase 6)

---

## Parallel Example: User Story 1 Tests

```bash
# Launch all test writing tasks for User Story 1 together:
Task T014: Write test "install.sh creates target directory"
Task T015: Write test "install.sh creates all subdirectories"
Task T016: Write test "install.sh copies all 6 templates"
Task T017: Write test "install.sh copies all 13 commands to Claude Code"
# ... etc (all test writing tasks can happen simultaneously)
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 (Quick Install)
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

This gives you a working installer that can be used immediately!

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo (now with validation)
4. Add User Story 3 → Test independently → Deploy/Demo (now with updates)
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 (install.sh)
   - Developer B: User Story 2 (validate.sh)
   - Developer C: User Story 3 (update.sh)
3. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story is independently completable and testable
- Tests MUST fail before implementing (TDD - Red, Green, Refactor)
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- All installer scripts must pass shellcheck with zero warnings
- Cross-platform compatibility is critical - test on macOS, Linux, and WSL
