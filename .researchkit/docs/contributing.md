# Contributing to ResearchKit

Guide for extending, customizing, and contributing to ResearchKit.

---

## Table of Contents

1. [Ways to Contribute](#ways-to-contribute)
2. [Customizing ResearchKit](#customizing-researchkit)
3. [Creating Custom Commands](#creating-custom-commands)
4. [Creating Custom Templates](#creating-custom-templates)
5. [Development Setup](#development-setup)
6. [Testing](#testing)
7. [Contribution Guidelines](#contribution-guidelines)
8. [Code Style](#code-style)

---

## Ways to Contribute

### For Users

1. **Report issues** - Found a bug? [Open an issue](https://github.com/yourusername/research-kit/issues)
2. **Suggest features** - Have an idea? [Start a discussion](https://github.com/yourusername/research-kit/discussions)
3. **Improve documentation** - Fix typos, clarify explanations
4. **Share your research** - Show how you use ResearchKit

### For Developers

1. **Fix bugs** - Check [open issues](https://github.com/yourusername/research-kit/issues)
2. **Add features** - Implement [requested features](https://github.com/yourusername/research-kit/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)
3. **Improve installer** - Better error handling, cross-platform support
4. **Add tests** - Increase test coverage
5. **Create commands** - Build new research workflows

### For Researchers

1. **Share templates** - Custom templates for specific disciplines
2. **Write workflows** - Document research methodologies
3. **Case studies** - Share successful research projects
4. **Teaching materials** - Help others learn ResearchKit

---

## Customizing ResearchKit

### Customizing Templates

**Where templates live**:
```
~/.researchkit/templates/
├── constitution-template.md
├── question-template.md
├── framework-template.md
├── story-template.md
├── research-path-template.md
└── CLAUDE-template.md
```

**To customize**:

1. **Edit the template**:
```bash
nano ~/.researchkit/templates/question-template.md
```

2. **Add your sections**:
```markdown
## My Custom Section

**Custom field**: [YOUR_CUSTOM_FIELD]

**Why this matters**: [EXPLANATION]
```

3. **Save and use**:
   - Next time you run `/rk-question`, it will use your template
   - Your customizations are preserved during updates (checksum-based detection)

**Example customization**:

Add discipline-specific fields to `question-template.md`:
```markdown
## Disciplinary Grounding

**Primary discipline**: [Psychology / Sociology / Economics / etc.]

**Secondary disciplines**: [List supporting disciplines]

**Methodological approach**: [Qualitative / Quantitative / Mixed]
```

---

### Customizing Commands

Commands are harder to customize because they're Markdown instructions for Claude, but you can:

**1. Create command variants**:
```bash
# Copy existing command
cp ~/.researchkit/commands/rk-question.md ~/.researchkit/commands/rk-question-psychology.md

# Edit for psychology-specific questions
nano ~/.researchkit/commands/rk-question-psychology.md

# Update command name in file
# /rk.question-psychology - Psychology Research Questions
```

**2. Use in Claude Code**:
```bash
# Copy to Claude Code
cp ~/.researchkit/commands/rk-question-psychology.md ~/.claude/commands/

# Now available as /rk-question-psychology
```

---

### Configuration

**Config file**: `~/.researchkit/config.yaml`

```yaml
# ResearchKit Configuration
version: 1.0.0
install_dir: /Users/you/.researchkit

# Feature toggles
features:
  claude_integration: true
  auto_update: false

# Default settings
defaults:
  verbose: false
```

**Currently limited** - future versions will expand configuration options.

---

## Creating Custom Commands

### Command Structure

Commands are Markdown files that instruct Claude:

```markdown
# /rk.my-command - Brief Description

You are helping the user with [specific task].

## Context

[Background information Claude needs]

## Your Task

### Step 1: [ACTION_NAME]

[Detailed instructions for Claude]

**Prompts to ask user**:
- "Question 1?"
- "Question 2?"

**What to do with answers**:
- [Processing logic]

### Step 2: [ACTION_NAME]

[More instructions...]

## Templates to Use

Use the template at: ~/.researchkit/templates/[template-name].md

[Instructions on how to fill it]

## Output

Create file: .researchkit/[category]/[filename].md

**File structure**:
[Describe output format]

## Validation

Check against constitution:
- [PRINCIPLE_1]
- [PRINCIPLE_2]
```

### Example: Custom Command for Literature Review

**File**: `~/.researchkit/commands/rk-literature-review.md`

```markdown
# /rk.literature-review - Systematic Literature Review

You are helping the user conduct a systematic literature review.

## Context

A systematic literature review follows a structured process to identify, evaluate, and synthesize research on a topic.

## Your Task

### Step 1: Define Search Strategy

Ask the user:
- "What databases will you search?" (e.g., Google Scholar, JSTOR, Web of Science)
- "What are your search terms?" (keywords and Boolean operators)
- "What are your inclusion criteria?" (publication date, peer-reviewed, etc.)
- "What are your exclusion criteria?"

### Step 2: Create Search Log

Create file: .researchkit/documents/literature-review/search-log.md

Include:
- Database searched
- Search query used
- Date of search
- Number of results
- Articles selected for review

### Step 3: Create Review Matrix

Create file: .researchkit/documents/literature-review/review-matrix.md

For each article, capture:
- Citation
- Research question
- Methodology
- Key findings
- Relevance to user's research
- Quality rating (1-5)

### Step 4: Synthesis

After reviewing all articles, help user synthesize:
- Common themes
- Contradictions
- Gaps in literature
- Methodological patterns

Save to: .researchkit/documents/literature-review/synthesis.md

## Output

Creates:
- search-log.md
- review-matrix.md
- synthesis.md

All in: .researchkit/documents/literature-review/
```

**To use**:
```bash
# Copy to Claude Code
cp ~/.researchkit/commands/rk-literature-review.md ~/.claude/commands/

# Use in any project
cd ~/my-research-project
/rk-literature-review
```

---

## Creating Custom Templates

### Template Structure

Templates use placeholders that Claude fills in:

```markdown
# [TEMPLATE_TITLE]

**Project**: [PROJECT_NAME]
**Date**: [DATE]
**Version**: [VERSION]

---

## Section 1: [SECTION_NAME]

**Field 1**: [FIELD_1_VALUE]

**Field 2**: [FIELD_2_VALUE]

### Subsection

[DETAILED_CONTENT]

---

## Section 2: [SECTION_NAME]

[MORE_CONTENT]
```

**Placeholder patterns**:
- `[UPPERCASE_WITH_UNDERSCORES]` - Claude fills these in
- `**Label**: [VALUE]` - Structured fields
- Markdown sections - Organize content

### Example: Custom Template for Research Proposal

**File**: `~/.researchkit/templates/proposal-template.md`

```markdown
# Research Proposal: [PROPOSAL_TITLE]

**Researcher**: [RESEARCHER_NAME]
**Institution**: [INSTITUTION]
**Date**: [DATE]
**Funding Body**: [FUNDING_BODY]

---

## 1. Research Question

**Primary question**: [RESEARCH_QUESTION]

**Significance**: [Why this question matters]

**Expected contribution**: [What new knowledge this will produce]

---

## 2. Literature Review

**Current state of knowledge**: [Summary of existing research]

**Gaps identified**:
- [GAP_1]
- [GAP_2]
- [GAP_3]

**How this research addresses gaps**: [EXPLANATION]

---

## 3. Theoretical Framework

**Core theory**: [THEORY_NAME]

**Key concepts**:
- [CONCEPT_1]: [Definition]
- [CONCEPT_2]: [Definition]

**Hypotheses / Research propositions**:
1. [HYPOTHESIS_1]
2. [HYPOTHESIS_2]

---

## 4. Methodology

**Research design**: [Qualitative / Quantitative / Mixed]

**Data collection**:
- **Method 1**: [DESCRIPTION]
- **Method 2**: [DESCRIPTION]

**Sample**:
- **Population**: [TARGET_POPULATION]
- **Sample size**: [N]
- **Sampling method**: [METHOD]

**Data analysis**:
- [ANALYSIS_METHOD_1]
- [ANALYSIS_METHOD_2]

**Validity and reliability**: [How you'll ensure quality]

---

## 5. Timeline

**Phase 1** ([MONTHS]): [ACTIVITIES]

**Phase 2** ([MONTHS]): [ACTIVITIES]

**Phase 3** ([MONTHS]): [ACTIVITIES]

**Total duration**: [X] months

---

## 6. Budget

**Personnel**: $[AMOUNT]

**Equipment**: $[AMOUNT]

**Travel**: $[AMOUNT]

**Other**: $[AMOUNT]

**Total**: $[TOTAL]

---

## 7. Expected Outcomes

**Academic outputs**:
- [OUTPUT_1] (e.g., journal article in [JOURNAL])
- [OUTPUT_2]

**Practical impact**:
- [IMPACT_1]
- [IMPACT_2]

**Dissemination plan**: [How you'll share findings]

---

## 8. References

[CITATION_1]

[CITATION_2]

[CITATION_3]
```

**To use with custom command**:

Create `rk-proposal.md`:
```markdown
# /rk.proposal - Create Research Proposal

You are helping the user create a research proposal.

## Your Task

Use the template at: ~/.researchkit/templates/proposal-template.md

Guide the user through each section...
```

---

## Development Setup

### Prerequisites

- macOS, Linux, or Windows WSL
- Bash 4.0+
- Git
- shellcheck (for linting)
- bats-core (for testing)

### Clone Repository

```bash
git clone https://github.com/yourusername/research-kit.git
cd research-kit
```

### Install Testing Tools

```bash
# macOS
brew install shellcheck bats-core

# Linux (Ubuntu/Debian)
sudo apt-get install shellcheck
git clone https://github.com/bats-core/bats-core.git
cd bats-core
sudo ./install.sh /usr/local
```

### Project Structure

```
research-kit/
├── README.md                    ← Root documentation
├── install.sh                   ← Simple wrapper
├── .researchkit/
│   ├── commands/                ← 13 command files
│   ├── templates/               ← 6 template files
│   ├── installer/               ← Installer scripts
│   │   ├── install.sh
│   │   ├── update.sh
│   │   ├── validate.sh
│   │   └── common.sh
│   └── docs/                    ← Documentation
├── tests/
│   ├── integration/             ← Integration tests
│   └── libs/                    ← Test libraries
└── specs/                       ← Specifications
```

---

## Testing

### Run All Tests

```bash
# Installation tests (18 tests)
bats tests/integration/test_install.bats

# Validation tests (14 tests)
bats tests/integration/test_validate.bats

# Update tests (13 tests)
bats tests/integration/test_update.bats
```

### Run Specific Test

```bash
# Run single test file
bats tests/integration/test_install.bats

# Run with filter
bats tests/integration/test_install.bats --filter "creates all required subdirectories"
```

### Writing Tests

**Test pattern**:
```bash
@test "descriptive test name" {
    # Setup
    TEST_DIR=$(mktemp -d)

    # Execute
    run .researchkit/installer/install.sh --noninteractive "$TEST_DIR"

    # Assert
    assert_success
    assert_dir_exist "$TEST_DIR/templates"
    assert_file_exist "$TEST_DIR/.researchkit_version"

    # Cleanup
    rm -rf "$TEST_DIR"
}
```

**Available assertions**:
- `assert_success` - Exit code 0
- `assert_failure` - Non-zero exit
- `assert_output` - Check output text
- `assert_file_exist` - File exists
- `assert_dir_exist` - Directory exists
- `assert_file_executable` - File has execute permission

### Linting

```bash
# Lint all shell scripts
shellcheck .researchkit/installer/*.sh install.sh

# Specific script
shellcheck .researchkit/installer/install.sh
```

---

## Contribution Guidelines

### Before You Start

1. **Check existing issues** - Is your idea already being discussed?
2. **Open an issue first** - Discuss your proposal before coding
3. **Fork the repository** - Work in your own fork

### Development Workflow

1. **Create a branch**:
```bash
git checkout -b feature/my-feature
```

2. **Make changes**:
   - Follow code style (see below)
   - Add tests
   - Update documentation

3. **Test thoroughly**:
```bash
bats tests/integration/test_*.bats
shellcheck .researchkit/installer/*.sh
```

4. **Commit**:
```bash
git add .
git commit -m "Add feature: brief description

Detailed explanation of what changed and why."
```

5. **Push and create PR**:
```bash
git push origin feature/my-feature
```

Then open a Pull Request on GitHub.

### Pull Request Guidelines

**PR should include**:
- ✅ Clear description of what changed and why
- ✅ Tests for new functionality
- ✅ Updated documentation
- ✅ Passing CI checks (tests + linting)
- ✅ One feature/fix per PR (not multiple unrelated changes)

**PR description template**:
```markdown
## What Changed

[Brief summary]

## Why

[Motivation for this change]

## Testing

- [ ] Added new tests
- [ ] All existing tests pass
- [ ] Tested on macOS
- [ ] Tested on Linux (if applicable)

## Documentation

- [ ] Updated relevant docs
- [ ] Added inline comments for complex logic

## Checklist

- [ ] Code follows style guide
- [ ] Shellcheck passes
- [ ] Tests pass
- [ ] No breaking changes (or documented if unavoidable)
```

---

## Code Style

### Bash Scripts

**General**:
- Use `#!/usr/bin/env bash` shebang
- Set strict mode: `set -Eeuo pipefail`
- Use 4-space indentation (not tabs)
- Maximum line length: 120 characters

**Naming**:
- Functions: `snake_case`
- Variables: `SCREAMING_SNAKE_CASE` for globals, `snake_case` for locals
- Always declare locals: `local var_name="value"`

**Example**:
```bash
#!/usr/bin/env bash
set -Eeuo pipefail

# Global configuration
DEFAULT_INSTALL_DIR="$HOME/.researchkit"
VERSION="1.0.0"

# Function to install templates
install_templates() {
    local source_dir="$1"
    local dest_dir="$2"
    local count=0

    for template in "$source_dir"/*.md; do
        if [ -f "$template" ]; then
            cp "$template" "$dest_dir/"
            ((count++)) || true
        fi
    done

    echo "$count"
}
```

**Error handling**:
```bash
# Check prerequisites
if [ ! -d "$SOURCE_DIR" ]; then
    abort "Source directory not found: $SOURCE_DIR" 2
fi

# Safe command execution
if ! mkdir -p "$DEST_DIR" 2>/dev/null; then
    abort "Failed to create directory: $DEST_DIR" 3
fi
```

**Output**:
```bash
# Use functions from common.sh
ohai "Section header"
success "Operation completed"
info "Informational message"
warn "Warning message"
error "Error message"
```

### Markdown Files

**Commands**:
- Use `#` for title with `/rk.command-name`
- H2 (`##`) for major sections
- H3 (`###`) for subsections
- Clear, imperative instructions for Claude
- Include examples

**Templates**:
- Use `[PLACEHOLDER]` for values Claude fills in
- `**Label**: [VALUE]` for structured fields
- Clear section headers
- Include inline guidance

**Documentation**:
- Use H1 (`#`) for document title
- Table of contents for long docs
- Code blocks with language hints
- Examples for every feature

---

## Feature Development

### Adding a New Command

1. **Create command file**:
```bash
nano .researchkit/commands/rk-mynewcommand.md
```

2. **Write command**:
```markdown
# /rk.mynewcommand - Brief Description

You are helping the user with [task].

## Your Task
[Instructions...]
```

3. **Add to test suite**:
```bash
# In tests/integration/test_install.bats
@test "install.sh copies all 14 commands" {  # Update count
    # Update test to include new command
}
```

4. **Update documentation**:
   - Add to [commands-reference.md](commands-reference.md)
   - Mention in [README.md](../../README.md)

5. **Test**:
```bash
bats tests/integration/test_install.bats
```

### Adding a New Template

Same process as commands, but in `.researchkit/templates/`

### Improving Installer

1. **Identify issue** - Performance, UX, cross-platform
2. **Add test first** (TDD approach)
3. **Implement fix**
4. **Run all tests**
5. **Update docs if behavior changed**

---

## Documentation

### Documentation Standards

**All documentation should**:
- Be clear and concise
- Include examples
- Target appropriate audience (beginner, advanced, technical)
- Be kept up-to-date with code changes

**When to update docs**:
- Adding new commands → Update commands-reference.md
- Changing installer behavior → Update installation-guide.md
- Fixing bugs → Update troubleshooting.md
- Adding features → Update README.md

### Documentation Structure

```
.researchkit/docs/
├── getting-started.md       ← For beginners (workflow)
├── installation-guide.md    ← For all users (install/update)
├── commands-reference.md    ← Reference (all 13 commands)
├── templates-reference.md   ← Reference (all 6 templates)
├── architecture.md          ← For developers (technical)
├── troubleshooting.md       ← For all users (problems)
└── contributing.md          ← For contributors (this file)
```

---

## Release Process

1. **Update version**:
   - In `.researchkit/installer/install.sh`: `VERSION="X.Y.Z"`
   - In `.researchkit/installer/update.sh`: `VERSION="X.Y.Z"`

2. **Update changelog**:
```markdown
## [X.Y.Z] - 2025-10-25

### Added
- New feature X
- New command Y

### Fixed
- Bug Z

### Changed
- Behavior W
```

3. **Tag release**:
```bash
git tag -a vX.Y.Z -m "Release version X.Y.Z"
git push origin vX.Y.Z
```

4. **Create GitHub release**:
   - Release notes from changelog
   - Link to documentation

---

## Community

### Getting Help

- **GitHub Discussions**: General questions
- **GitHub Issues**: Bug reports, feature requests
- **Pull Requests**: Code contributions

### Being a Good Contributor

- ✅ Be respectful and professional
- ✅ Search before posting (avoid duplicates)
- ✅ Provide context (OS, version, steps to reproduce)
- ✅ Be patient (maintainers are volunteers)
- ✅ Give credit to others
- ✅ Help other users when you can

---

## Thank You!

Thank you for considering contributing to ResearchKit! Every contribution, whether it's code, documentation, bug reports, or helping other users, makes ResearchKit better for everyone.

---

## Related Documentation

- **Getting Started**: [Getting Started Guide](getting-started.md)
- **Commands**: [Commands Reference](commands-reference.md)
- **Templates**: [Templates Reference](templates-reference.md)
- **Architecture**: [Architecture](architecture.md)
- **Troubleshooting**: [Troubleshooting](troubleshooting.md)
