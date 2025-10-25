#!/usr/bin/env bats
# test_update.bats - Integration tests for update.sh

# Load bats helpers
load '../libs/bats-support/load'
load '../libs/bats-assert/load'
load '../libs/bats-file/load'

# Setup and teardown
setup() {
    TEST_INSTALL_DIR="$(mktemp -d)"
    INSTALLER_PATH="$(pwd)/.researchkit/installer/install.sh"
    UPDATER_PATH="$(pwd)/.researchkit/installer/update.sh"

    # Create a test installation
    "$INSTALLER_PATH" --noninteractive "$TEST_INSTALL_DIR" >/dev/null 2>&1
}

teardown() {
    if [ -n "$TEST_INSTALL_DIR" ] && [ -d "$TEST_INSTALL_DIR" ]; then
        # Clean up backup directories too
        rm -rf "${TEST_INSTALL_DIR}"*
    fi
}

# =============================================================================
# Basic Update Tests
# =============================================================================

@test "update.sh exists and is executable" {
    assert_file_exist "$UPDATER_PATH"
    assert_file_executable "$UPDATER_PATH"
}

@test "update.sh --help shows usage information" {
    run "$UPDATER_PATH" --help
    assert_success
    assert_output --partial "ResearchKit Updater"
    assert_output --partial "USAGE:"
}

@test "update.sh detects existing installation" {
    run "$UPDATER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
}

@test "update.sh creates timestamped backup before update" {
    # Change version to trigger update
    echo "0.9.0" > "$TEST_INSTALL_DIR/.researchkit_version"

    run "$UPDATER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success

    # Check for backup directory (only in immediate parent dir)
    backup_count=$(find "$(dirname "$TEST_INSTALL_DIR")" -maxdepth 1 -type d -name "$(basename "$TEST_INSTALL_DIR").backup.*" 2>/dev/null | wc -l | tr -d ' ')
    [ "$backup_count" -ge 1 ]
}

@test "update.sh reports 'already up-to-date' when at latest version" {
    run "$UPDATER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    assert_output --partial "already on the latest version"
}

@test "update.sh --no-backup skips backup creation" {
    # Change version to trigger update
    echo "0.9.0" > "$TEST_INSTALL_DIR/.researchkit_version"

    run "$UPDATER_PATH" --noninteractive --no-backup "$TEST_INSTALL_DIR"
    assert_success
    assert_output --partial "Skipping backup"

    # Verify no backup was created
    backup_count=$(find "$(dirname "$TEST_INSTALL_DIR")" -maxdepth 1 -type d -name "$(basename "$TEST_INSTALL_DIR").backup.*" 2>/dev/null | wc -l | tr -d ' ')
    [ "$backup_count" -eq 0 ]
}

@test "update.sh exits with error when no installation found" {
    run "$UPDATER_PATH" --noninteractive "/nonexistent/path"
    assert_failure
    assert_output --partial "couldn't find ResearchKit"
}

@test "update.sh preserves config.yaml" {
    # Modify config file
    echo "# Custom config" >> "$TEST_INSTALL_DIR/config.yaml"

    run "$UPDATER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success

    # Verify custom content still exists
    grep -q "Custom config" "$TEST_INSTALL_DIR/config.yaml"
}

@test "update.sh updates version file" {
    # Change version to something older
    echo "0.9.0" > "$TEST_INSTALL_DIR/.researchkit_version"

    run "$UPDATER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success

    # Verify version was updated
    version=$(cat "$TEST_INSTALL_DIR/.researchkit_version")
    [ "$version" = "1.0.0" ]
}

@test "update.sh updates installer scripts" {
    # Change version to trigger update
    echo "0.9.0" > "$TEST_INSTALL_DIR/.researchkit_version"

    # Modify an installer script
    echo "# Old version" > "$TEST_INSTALL_DIR/installer/install.sh"

    run "$UPDATER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success

    # Verify it was updated (should not contain "Old version")
    ! grep -q "Old version" "$TEST_INSTALL_DIR/installer/install.sh"
}

@test "update.sh shows friendly messages" {
    run "$UPDATER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success
    assert_output --partial "ResearchKit"
    assert_output --partial "version"
}

# =============================================================================
# Backup and Preservation Tests
# =============================================================================

@test "update.sh preserves user-modified templates" {
    # Simulate user modification by changing a template
    echo "# User customization" >> "$TEST_INSTALL_DIR/templates/CLAUDE-template.md"

    # Update the manifest to mark it as modified
    # (In real scenario, checksum would differ)

    run "$UPDATER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success

    # Template should still have user content
    grep -q "User customization" "$TEST_INSTALL_DIR/templates/CLAUDE-template.md"
}

@test "update.sh backup contains original files" {
    # Change version to trigger update
    echo "0.9.0" > "$TEST_INSTALL_DIR/.researchkit_version"

    run "$UPDATER_PATH" --noninteractive "$TEST_INSTALL_DIR"
    assert_success

    # Find the backup directory
    backup_dir=$(find "$(dirname "$TEST_INSTALL_DIR")" -maxdepth 1 -type d -name "$(basename "$TEST_INSTALL_DIR").backup.*" 2>/dev/null | head -1)

    # Verify backup has the same structure
    assert_dir_exist "$backup_dir/templates"
    assert_dir_exist "$backup_dir/commands"
}
