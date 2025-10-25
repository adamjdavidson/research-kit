<!--
SYNC IMPACT REPORT
==================
Version Change: [TEMPLATE] → 1.0.0
Action: Initial ratification of project constitution

Modified Principles:
- All principles defined from template (initial creation)

Added Sections:
- Core Principles (5 principles)
- Quality Standards
- Development Workflow
- Governance

Removed Sections:
- None (initial creation)

Templates Requiring Updates:
- ✅ .specify/templates/plan-template.md (updated constitution check gates)
- ✅ .specify/templates/spec-template.md (aligned with spec-first principle)
- ✅ .specify/templates/tasks-template.md (aligned with incremental delivery)
- ✅ Command files (.claude/commands/*.md) - no agent-specific references found

Follow-up TODOs:
- None (all placeholders filled)

Date: 2025-10-25
-->

# rk4sk Constitution

## Core Principles

### I. Specification-First

Every feature MUST begin with a complete specification before implementation. Specifications
MUST include user scenarios with acceptance criteria, functional requirements, and success
metrics. Implementation without an approved specification is prohibited. Specifications MUST
be independently reviewable and testable.

**Rationale**: Clear specifications prevent scope creep, enable independent validation, and
ensure alignment between stakeholder expectations and delivered functionality.

### II. Test-Driven Development

Tests MUST be written before implementation code. The TDD cycle is strictly enforced:
1. Write tests that define expected behavior
2. Verify tests fail (Red)
3. Implement minimal code to pass tests (Green)
4. Refactor while keeping tests green

Tests MUST cover user acceptance scenarios from the specification. Integration tests MUST
verify contracts between components.

**Rationale**: TDD ensures testability by design, provides living documentation of expected
behavior, and prevents regression. Tests written after implementation tend to test what was
built rather than what was required.

### III. Documentation & Contracts

All interfaces, APIs, and component contracts MUST be documented before implementation.
Documentation MUST include:
- Input/output specifications
- Error conditions and handling
- Examples of correct usage
- Performance characteristics where relevant

Contract changes MUST be versioned and communicated. Breaking changes require MAJOR version
increments.

**Rationale**: Explicit contracts enable independent development, testing, and maintenance.
They serve as the source of truth for integration and prevent implicit coupling.

### IV. Incremental Delivery

Features MUST be broken into independently testable user stories with assigned priorities
(P1, P2, P3...). Each user story MUST be deliverable as a standalone increment that provides
value. Implementation MUST proceed in priority order. The highest-priority story (P1) MUST
constitute a viable MVP (Minimum Viable Product).

**Rationale**: Incremental delivery enables early feedback, reduces risk, and ensures that
if development stops at any point, the most valuable functionality has been delivered.

### V. Simplicity

Start with the simplest solution that satisfies the specification. YAGNI (You Aren't Gonna
Need It) principles apply: do not add functionality, abstraction, or infrastructure not
required by current specifications. Complexity MUST be justified against the constitution
and documented in the implementation plan.

**Rationale**: Premature optimization and speculative features increase maintenance burden,
introduce bugs, and slow delivery. Simple solutions are easier to understand, test, and
modify when requirements actually change.

## Quality Standards

### Testing Requirements

- **Contract Tests**: Required for all public interfaces and API boundaries
- **Integration Tests**: Required for multi-component user journeys
- **Unit Tests**: Optional unless specifically required by specification
- **Test Coverage**: Tests MUST verify acceptance criteria from specifications

### Code Quality

- All code MUST pass configured linters and formatters
- Compiler/interpreter warnings MUST be treated as errors
- Dead code and unused dependencies MUST be removed
- Comments SHOULD explain "why" not "what" (code should be self-documenting for "what")

### Performance & Observability

- Performance requirements MUST be stated in specifications when relevant
- All errors MUST be logged with sufficient context for debugging
- Production code MUST include structured logging for key operations
- Monitoring and alerting requirements MUST be specified for production systems

## Development Workflow

### Workflow Phases

1. **Specification** (`/speckit.specify`): Create or update feature specification
2. **Clarification** (`/speckit.clarify`): Identify and resolve underspecified areas
3. **Planning** (`/speckit.plan`): Generate implementation plan with design artifacts
4. **Task Generation** (`/speckit.tasks`): Create dependency-ordered, parallelizable tasks
5. **Analysis** (`/speckit.analyze`): Cross-artifact consistency validation
6. **Implementation** (`/speckit.implement`): Execute tasks in priority/dependency order

### Review Gates

- **Specification Review**: MUST verify completeness, testability, and priority assignment
- **Plan Review**: MUST verify constitution compliance and complexity justification
- **Implementation Review**: MUST verify TDD compliance, test passage, and acceptance criteria

### Versioning

Version numbers MUST follow semantic versioning (MAJOR.MINOR.PATCH):
- **MAJOR**: Breaking changes to public interfaces or contracts
- **MINOR**: New features or capabilities (backward compatible)
- **PATCH**: Bug fixes, documentation, performance improvements (no new features)

## Governance

### Amendment Process

1. Proposed amendments MUST be documented with rationale
2. Impact analysis MUST identify affected templates, workflows, and active specifications
3. Version increment MUST follow semantic versioning rules:
   - MAJOR: Principle removals or redefinitions (backward incompatible)
   - MINOR: New principles or sections (expanded guidance)
   - PATCH: Clarifications, wording fixes (no semantic change)
4. All dependent templates MUST be synchronized before amendment is ratified
5. Amendment date MUST be recorded in LAST_AMENDED_DATE

### Compliance

This constitution supersedes all other development practices and guidelines. All
specifications, plans, and implementations MUST comply with these principles. Non-compliance
MUST be explicitly justified in implementation plans under "Complexity Tracking" and approved
before proceeding.

### Review Cycle

Constitution MUST be reviewed:
- When principles conflict with practical needs (propose amendment)
- When new project requirements emerge that aren't addressed (propose addition)
- Quarterly to ensure continued relevance

**Version**: 1.0.0 | **Ratified**: 2025-10-25 | **Last Amended**: 2025-10-25
