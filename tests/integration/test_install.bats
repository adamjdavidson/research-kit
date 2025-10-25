#!/usr/bin/env bats
# test_install.bats - Integration tests for install.sh

# Load bats helpers
load '../libs/bats-support/load'
load '../libs/bats-assert/load'
load '../libs/bats-file/load'

# Setup and teardown
setup() {
    # Create a temporary directory for testing
    TEST_INSTALL_DIR="$(mktemp -d)"
    INSTALLER_PATH="$(pwd)/.researchkit/installer/install.sh"
}

teardown() {
    # Clean up test directory
    if [ -n "$TEST_INSTALL_DIR" ] && [ -d "$TEST_INSTALL_DIR" ]; then
        rm -rf "$TEST_INSTALL_DIR"
    fi
}

# =============================================================================
# Basic Installation Tests
# =============================================================================

@test "install.sh exists and is executable" {
    assert_file_exist "$INSTALLER_PATH"
    assert_file_executable "$INSTALLER_PATH"
}

@test "install.sh --help shows usage information" {
    run "$INSTALLER_PATH" --help
    assert_success
    assert_output --partial "ResearchKit Installer"
    assert_output --partial "USAGE:"
    assert_output --partial "OPTIONS:"
}

@test "install.sh creates target directory" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    assert_dir_exist "$TEST_INSTALL_DIR"
}

@test "install.sh creates all required subdirectories" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    assert_dir_exist "$TEST_INSTALL_DIR/installer"
    assert_dir_exist "$TEST_INSTALL_DIR/templates"
    assert_dir_exist "$TEST_INSTALL_DIR/commands"
    assert_dir_exist "$TEST_INSTALL_DIR/docs"
}

@test "install.sh copies all 6 templates" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success

    # Check that templates directory has 6 .md files
    template_count=$(find "$TEST_INSTALL_DIR/templates" -name "*.md" | wc -l | tr -d ' ')
    [ "$template_count" -eq 6 ]
}

@test "install.sh copies all 13 commands" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success

    # Check that commands directory has 13 .md files
    command_count=$(find "$TEST_INSTALL_DIR/commands" -name "*.md" | wc -l | tr -d ' ')
    [ "$command_count" -eq 13 ]
}

@test "install.sh creates version file with semantic version" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    assert_file_exist "$TEST_INSTALL_DIR/.researchkit_version"

    # Version should be in format X.Y.Z
    version=$(cat "$TEST_INSTALL_DIR/.researchkit_version")
    [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "install.sh creates install manifest with checksums" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    assert_file_exist "$TEST_INSTALL_DIR/.install_manifest"

    # Manifest should contain checksum lines
    grep -q "^[a-f0-9]" "$TEST_INSTALL_DIR/.install_manifest"
}

@test "install.sh creates config.yaml with defaults" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    assert_file_exist "$TEST_INSTALL_DIR/config.yaml"

    # Config should contain version
    grep -q "version:" "$TEST_INSTALL_DIR/config.yaml"
}

@test "install.sh creates metadata file with JSON" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    assert_file_exist "$TEST_INSTALL_DIR/.install_metadata"

    # Metadata should be valid JSON
    grep -q '"version"' "$TEST_INSTALL_DIR/.install_metadata"
    grep -q '"installed_at"' "$TEST_INSTALL_DIR/.install_metadata"
}

@test "install.sh is idempotent (can run twice safely)" {
    # First installation
    run "$INSTALLER_PATH" --noninteractive --force "$TEST_INSTALL_DIR"
    assert_success

    # Second installation (should not fail)
    run "$INSTALLER_PATH" --noninteractive --force "$TEST_INSTALL_DIR"
    assert_success
}

@test "install.sh shows friendly welcome message" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    assert_output --partial "Welcome to ResearchKit"
}

@test "install.sh shows platform detection" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    # Should detect macOS, Linux, or Windows
    assert_output --regexp "(macOS|Linux|Windows)"
}

@test "install.sh shows completion message with next steps" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    assert_output --partial "All done"
    assert_output --partial "Next steps"
    assert_output --partial "/rk-init"
}

# =============================================================================
# Error Handling Tests
# =============================================================================

@test "install.sh handles invalid directory gracefully" {
    # Try to install to a read-only location (should fail gracefully)
    run "$INSTALLER_PATH" --noninteractive "/dev/null/impossible"
    assert_failure
}

@test "install.sh --no-commands skips Claude Code installation" {
    run "$INSTALLER_PATH" --noninteractive --no-commands "$TEST_INSTALL_DIR"
    assert_success
    assert_output --partial "Skipping Claude Code command installation"
}

# =============================================================================
# File Content Tests
# =============================================================================

@test "installed templates contain expected template files" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success

    # Check for specific expected templates
    assert_file_exist "$TEST_INSTALL_DIR/templates/CLAUDE-template.md"
    assert_file_exist "$TEST_INSTALL_DIR/templates/constitution-template.md"
    assert_file_exist "$TEST_INSTALL_DIR/templates/framework-template.md"
}

@test "installed commands contain expected command files" {
    run "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success

    # Check for specific expected commands
    assert_file_exist "$TEST_INSTALL_DIR/commands/rk-init.md"
    assert_file_exist "$TEST_INSTALL_DIR/commands/rk-research.md"
    assert_file_exist "$TEST_INSTALL_DIR/commands/rk-validate.md"
}
