#!/usr/bin/env bats
# test_validate.bats - Integration tests for validate.sh

# Load bats helpers
load '../libs/bats-support/load'
load '../libs/bats-assert/load'
load '../libs/bats-file/load'

# Setup and teardown
setup() {
    TEST_INSTALL_DIR="$(mktemp -d)"
    INSTALLER_PATH="$(pwd)/.researchkit/installer/install.sh"
    VALIDATOR_PATH="$(pwd)/.researchkit/installer/validate.sh"

    # Create a test installation
    "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR" >/dev/null 2>&1
}

teardown() {
    if [ -n "$TEST_INSTALL_DIR" ] && [ -d "$TEST_INSTALL_DIR" ]; then
        rm -rf "$TEST_INSTALL_DIR"
    fi
}

# =============================================================================
# Basic Validation Tests
# =============================================================================

@test "validate.sh exists and is executable" {
    assert_file_exist "$VALIDATOR_PATH"
    assert_file_executable "$VALIDATOR_PATH"
}

@test "validate.sh --help shows usage information" {
    run "$VALIDATOR_PATH" --help
    assert_success
    assert_output --partial "ResearchKit Installation Validator"
    assert_output --partial "USAGE:"
}

@test "validate.sh reports all checks passing for healthy installation" {
    run "$VALIDATOR_PATH" "$TEST_INSTALL_DIR"
    assert_success
    assert_output --partial "Everything looks great"
    assert_output --partial "6 templates"
    assert_output --partial "13 commands"
}

@test "validate.sh detects missing directory" {
    rm -rf "$TEST_INSTALL_DIR/templates"

    run "$VALIDATOR_PATH" "$TEST_INSTALL_DIR"
    assert_failure
}

@test "validate.sh outputs friendly human-readable format by default" {
    run "$VALIDATOR_PATH" "$TEST_INSTALL_DIR"
    assert_success
    assert_output --partial "Checking your ResearchKit installation"
    assert_output --partial "ResearchKit is ready to use"
}

@test "validate.sh outputs valid JSON with --json flag" {
    run "$VALIDATOR_PATH" --json "$TEST_INSTALL_DIR"
    assert_success
    assert_output --partial '"timestamp"'
    assert_output --partial '"overall_status"'
    assert_output --partial '"checks"'
}

@test "validate.sh returns exit code 0 for healthy installation" {
    run "$VALIDATOR_PATH" "$TEST_INSTALL_DIR"
    assert_success
    [ "$status" -eq 0 ]
}

@test "validate.sh detects missing template file" {
    rm -f "$TEST_INSTALL_DIR/templates/CLAUDE-template.md"

    run "$VALIDATOR_PATH" --no-fix "$TEST_INSTALL_DIR"
    assert_failure
    assert_output --partial "Missing templates"
}

@test "validate.sh detects missing command file" {
    rm -f "$TEST_INSTALL_DIR/commands/rk-init.md"

    run "$VALIDATOR_PATH" --no-fix "$TEST_INSTALL_DIR"
    assert_failure
    assert_output --partial "Missing commands"
}

@test "validate.sh detects non-executable installer scripts" {
    chmod -x "$TEST_INSTALL_DIR/installer/install.sh"

    run "$VALIDATOR_PATH" --no-fix "$TEST_INSTALL_DIR"
    assert_failure
}

@test "validate.sh --quiet suppresses detailed output" {
    run "$VALIDATOR_PATH" --quiet "$TEST_INSTALL_DIR"
    assert_success
    # Quiet mode should have less output
    [ "${#lines[@]}" -lt 10 ]
}

@test "validate.sh handles non-existent installation gracefully" {
    run "$VALIDATOR_PATH" "/nonexistent/path"
    assert_failure
    assert_output --partial "not found"
}

# =============================================================================
# Auto-Fix Tests
# =============================================================================

@test "validate.sh auto-fixes file permissions by default" {
    chmod -x "$TEST_INSTALL_DIR/installer/install.sh"

    run "$VALIDATOR_PATH" "$TEST_INSTALL_DIR"
    # Should succeed because it auto-fixed
    assert_success
    assert_output --partial "fixed"

    # Verify the file is now executable
    assert_file_executable "$TEST_INSTALL_DIR/installer/install.sh"
}

@test "validate.sh shows what it fixed" {
    chmod -x "$TEST_INSTALL_DIR/installer/install.sh"

    run "$VALIDATOR_PATH" "$TEST_INSTALL_DIR"
    assert_success
    assert_output --partial "I found a couple of small issues, so I fixed them for you"
    assert_output --partial "What I fixed"
}
