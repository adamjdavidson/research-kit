# QuickStart: ResearchKit CLI Installer

**Feature**: 001-researchkit-installer
**Date**: 2025-10-25
**Purpose**: Get started with implementing the ResearchKit CLI Installer

---

## Overview

This guide provides step-by-step instructions for implementing the ResearchKit CLI Installer feature following the TDD (Test-Driven Development) approach mandated by the project constitution.

---

## Prerequisites

Before starting implementation, ensure you have:

- [x] Completed specification (spec.md)
- [x] Completed implementation plan (plan.md)
- [x] Completed research (research.md)
- [x] Completed data model (data-model.md)
- [x] Completed contracts (contracts/)
- [x] Read and understood the project constitution
- [ ] **bats-core** testing framework installed
- [ ] **shellcheck** installed for linting

---

## Setup Development Environment

### 1. Install Testing Framework (bats-core)

**macOS:**
```bash
brew install bats-core
```

**Linux/WSL (via git submodules):**
```bash
cd /path/to/rk4sk

# Add bats-core and helper libraries as submodules
git submodule add https://github.com/bats-core/bats-core.git tests/bats
git submodule add https://github.com/bats-core/bats-support.git tests/test_helper/bats-support
git submodule add https://github.com/bats-core/bats-assert.git tests/test_helper/bats-assert
git submodule add https://github.com/bats-core/bats-file.git tests/test_helper/bats-file

# Initialize submodules
git submodule update --init --recursive
```

### 2. Install ShellCheck

**macOS:**
```bash
brew install shellcheck
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt install shellcheck

# Or download from https://github.com/koalaman/shellcheck
```

### 3. Create Project Structure

```bash
# Navigate to project root
cd /path/to/rk4sk

# Create ResearchKit directory structure
mkdir -p .researchkit/{installer,templates,commands,docs}
mkdir -p tests/{integration,fixtures}

# Verify structure
tree .researchkit tests
```

---

## Implementation Workflow (TDD)

Follow this order strictly per the constitution's TDD principle:

### Phase 1: Tests First (Red)

**Step 1.1: Write Installation Tests**

Create `tests/integration/test_install.bats`:

```bash
#!/usr/bin/env bats

load '../test_helper/bats-support/load'
load '../test_helper/bats-assert/load'
load '../test_helper/bats-file/load'

setup() {
    TEST_DIR="$(temp_make)"
    export INSTALL_DIR="$TEST_DIR/.researchkit"
}

teardown() {
    temp_del "$TEST_DIR"
}

@test "install.sh creates target directory" {
    run .researchkit/installer/install.sh "$INSTALL_DIR"

    assert_success
    assert_dir_exists "$INSTALL_DIR"
}

@test "install.sh creates subdirectories" {
    run .researchkit/installer/install.sh "$INSTALL_DIR"

    assert_success
    assert_dir_exists "$INSTALL_DIR/installer"
    assert_dir_exists "$INSTALL_DIR/templates"
    assert_dir_exists "$INSTALL_DIR/commands"
    assert_dir_exists "$INSTALL_DIR/docs"
}

@test "install.sh copies templates" {
    run .researchkit/installer/install.sh "$INSTALL_DIR"

    assert_success
    assert_file_exists "$INSTALL_DIR/templates/research-plan.md"
    assert_file_exists "$INSTALL_DIR/templates/narrative-outline.md"
}

@test "install.sh creates version file" {
    run .researchkit/installer/install.sh "$INSTALL_DIR"

    assert_success
    assert_file_exists "$INSTALL_DIR/.researchkit_version"
    assert_file_contains "$INSTALL_DIR/.researchkit_version" "^[0-9]+\.[0-9]+\.[0-9]+$"
}

@test "install.sh is idempotent" {
    # First run
    run .researchkit/installer/install.sh "$INSTALL_DIR"
    assert_success

    # Second run should also succeed
    run .researchkit/installer/install.sh "$INSTALL_DIR"
    assert_success
}
```

**Step 1.2: Run Tests (Should Fail)**

```bash
./tests/bats/bin/bats tests/integration/test_install.bats
```

**Expected output:** All tests FAIL (scripts don't exist yet)

---

### Phase 2: Minimal Implementation (Green)

**Step 2.1: Create install.sh Stub**

Create `.researchkit/installer/install.sh`:

```bash
#!/usr/bin/env bash
set -Eeuo pipefail

# Minimal implementation to pass first test
INSTALL_DIR="${1:-$HOME/.researchkit}"
mkdir -p "$INSTALL_DIR"
```

Make executable:
```bash
chmod +x .researchkit/installer/install.sh
```

**Step 2.2: Run Tests Again**

```bash
./tests/bats/bin/bats tests/integration/test_install.bats
```

**Expected output:** First test PASSES, others still fail

**Step 2.3: Iterate Until All Tests Pass**

Add functionality incrementally:
- Create subdirectories (pass test 2)
- Copy templates (pass test 3)
- Create version file (pass test 4)
- Handle idempotency (pass test 5)

After each addition, run tests to verify progress.

---

### Phase 3: Refactor (Keep Tests Green)

**Step 3.1: Add Error Handling**

Enhance `install.sh` with proper error handling per research.md patterns:

```bash
#!/usr/bin/env bash
set -Eeuo pipefail

# Error handler
error_handler() {
  local line_num="$1"
  local command="$2"
  printf "\nError at line %s: %s\n" "$line_num" "$command" >&2
  exit 1
}

trap 'error_handler ${LINENO} "$BASH_COMMAND"' ERR

# Rest of implementation...
```

**Step 3.2: Run Tests (Should Still Pass)**

```bash
./tests/bats/bin/bats tests/integration/test_install.bats
```

All tests should still pass after refactoring.

**Step 3.3: Add Progress Output**

Add user-friendly output per research.md patterns:

```bash
# TTY detection
if [[ -t 1 ]]; then
  tty_blue="$(printf '\033[34m')"
  tty_green="$(printf '\033[32m')"
  tty_reset="$(printf '\033[0m')"
else
  tty_blue=""
  tty_green=""
  tty_reset=""
fi

ohai() {
  printf "${tty_blue}==>${tty_reset} %s\n" "$*"
}

success() {
  printf "${tty_green}✓${tty_reset} %s\n" "$*"
}
```

**Step 3.4: Run Tests (Should Still Pass)**

Tests should pass regardless of cosmetic changes.

---

## Implementing Remaining User Stories

### User Story 1 (P1): Quick Install - MVP

**Tests to Write:**
1. Installation creates all required files ✓ (done above)
2. Commands are copied to `.claude/commands/`
3. Shell profile is updated with PATH entry
4. Installation handles existing installations
5. Installation shows clear error messages on failure

**Implementation Order:**
1. Write tests for each acceptance scenario
2. Run tests (they fail)
3. Implement minimum code to pass tests
4. Refactor for clarity and robustness
5. Verify tests still pass

**Completion Criteria:**
- All P1 acceptance scenarios have passing tests
- `install.sh` handles all edge cases from contracts/install-contract.md
- shellcheck passes with no warnings
- Manual smoke test: run installer in empty directory, verify commands work

---

### User Story 2 (P2): Verify Installation Health

**Tests to Write:**
1. `validate.sh` detects missing directories
2. `validate.sh` detects missing templates
3. `validate.sh` detects missing commands
4. `validate.sh` detects permission issues
5. `validate.sh` outputs correct format (text and JSON)
6. `validate.sh` exit codes match specification

**Implementation:** Same TDD cycle (tests first, implement, refactor)

---

### User Story 3 (P3): Update Existing Installation

**Tests to Write:**
1. `update.sh` detects existing installation
2. `update.sh` creates backup before updating
3. `update.sh` preserves user customizations
4. `update.sh` updates system files only
5. `update.sh` handles "already up-to-date" state

**Implementation:** Same TDD cycle

---

## Code Quality Checkpoints

After implementing each user story, run these checks:

### 1. ShellCheck Linting

```bash
shellcheck .researchkit/installer/*.sh
```

**Must pass with zero warnings.**

### 2. Test Coverage

```bash
./tests/bats/bin/bats tests/integration/
```

**All tests must pass.**

### 3. Manual Smoke Testing

**P1 Smoke Test:**
```bash
# Fresh install
./researchkit/installer/install.sh ~/test-install

# Verify structure
ls -la ~/test-install/.researchkit

# Verify commands
ls -la ~/.claude/commands/researchkit.*

# Clean up
rm -rf ~/test-install/.researchkit
```

**P2 Smoke Test:**
```bash
./researchkit/installer/validate.sh ~/test-install
```

**P3 Smoke Test:**
```bash
./researchkit/installer/update.sh ~/test-install
```

### 4. Cross-Platform Testing

Test on all supported platforms:
- [ ] macOS (Intel or ARM)
- [ ] Linux (Ubuntu or Debian)
- [ ] Windows WSL

---

## Commit Strategy

Per incremental delivery principle, commit after each completed user story:

**After P1 Complete:**
```bash
git add .researchkit/installer/install.sh tests/integration/test_install.bats
git commit -m "feat: implement P1 quick install (MVP)

- Add install.sh with directory creation
- Copy templates and commands
- Install commands to Claude Code
- Handle existing installations
- All P1 tests passing"
```

**After P2 Complete:**
```bash
git add .researchkit/installer/validate.sh tests/integration/test_validate.bats
git commit -m "feat: implement P2 installation validation

- Add validate.sh with health checks
- Check directories, templates, commands
- Support text and JSON output
- All P2 tests passing"
```

**After P3 Complete:**
```bash
git add .researchkit/installer/update.sh tests/integration/test_update.bats
git commit -m "feat: implement P3 installation updates

- Add update.sh with backup support
- Preserve user customizations
- Update system files only
- All P3 tests passing"
```

---

## Validation Before Completion

Before marking the feature complete, verify:

### Constitution Compliance

- [x] **Specification-First**: Spec created before implementation ✓
- [ ] **Test-Driven Development**: All tests written before implementation
- [ ] **Documentation & Contracts**: All interfaces documented in contracts/ ✓
- [ ] **Incremental Delivery**: P1 MVP delivered first, then P2, then P3
- [ ] **Simplicity**: No unnecessary abstractions or features

### Acceptance Criteria

- [ ] Installation completes in under 2 minutes (SC-001)
- [ ] Commands available within 30 seconds of install (SC-002)
- [ ] Installation success rate > 95% (SC-003)
- [ ] Validation detects 100% of missing files (SC-004)
- [ ] Basic research workflow completable in 5 minutes (SC-005)
- [ ] 90% of users complete setup without help (SC-006)
- [ ] Updates preserve 100% of user customizations (SC-007)

### Testing Coverage

- [ ] All acceptance scenarios have passing tests
- [ ] Edge cases from contracts are tested
- [ ] Tests run on all target platforms
- [ ] shellcheck passes with no warnings
- [ ] Manual smoke tests pass

---

## Next Steps After Implementation

Once implementation is complete:

1. **Generate task list** (if not already done):
   ```bash
   /speckit.tasks
   ```

2. **Run analysis** for consistency check:
   ```bash
   /speckit.analyze
   ```

3. **Create pull request** with feature branch

4. **Document lessons learned** for future features

---

## Troubleshooting

### Tests Fail to Run

**Issue:** `./tests/bats/bin/bats: No such file or directory`

**Solution:** Initialize git submodules:
```bash
git submodule update --init --recursive
```

### ShellCheck Warnings

**Issue:** SC2086: Quote variables to prevent word splitting

**Solution:** Always quote variables:
```bash
# Wrong
mkdir $DIR

# Right
mkdir "$DIR"
```

### Permission Denied During Install

**Issue:** Cannot create directory

**Solution:** Ensure parent directory is writable or choose different install location

---

## Resources

- **Research Document**: [research.md](./research.md) - Technical decisions and patterns
- **Contracts**: [contracts/](./contracts/) - Interface specifications
- **Data Model**: [data-model.md](./data-model.md) - Entity definitions
- **bats-core Docs**: https://bats-core.readthedocs.io
- **ShellCheck**: https://www.shellcheck.net
- **Project Constitution**: `.specify/memory/constitution.md`

---

## Summary

**Key Principles:**
1. Tests before implementation (TDD)
2. Incremental delivery (P1 → P2 → P3)
3. Constitution compliance at all stages
4. Cross-platform compatibility
5. Idempotent operations

**Success Criteria:**
- All tests passing
- shellcheck clean
- Manual smoke tests pass
- Constitution checklist complete
- Ready for `/speckit.tasks`

Happy coding! 🚀
