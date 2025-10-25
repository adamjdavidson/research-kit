# Templates Reference

Complete guide to all 6 ResearchKit templates.

---

## Table of Contents

1. [Template Overview](#template-overview)
2. [CLAUDE Template](#claude-template)
3. [Constitution Template](#constitution-template)
4. [Question Template](#question-template)
5. [Research Path Template](#research-path-template)
6. [Story Template](#story-template)
7. [Framework Template](#framework-template)
8. [Using Templates](#using-templates)

---

## Template Overview

ResearchKit includes 6 professional templates that structure your research outputs:

| Template | Purpose | Used By | Output |
|----------|---------|---------|--------|
| CLAUDE | System prompts for commands | All commands | Command behavior |
| Constitution | Research methodology principles | `/rk-constitution` | `constitution.md` |
| Question | Question refinement tracking | `/rk-question` | `questions/*.md` |
| Research Path | Disciplinary tradition analysis | `/rk-identify-paths` | `research-paths/paths/*.md` |
| Story | Vivid narrative capture | `/rk-capture-story` | `stories/meta/*.md` |
| Framework | Actionable framework extraction | `/rk-frameworks` | `synthesis/frameworks/*.md` |

**Templates are located**: `~/.researchkit/templates/`

---

## CLAUDE Template

**File**: `CLAUDE-template.md`

**Purpose**: System prompt template for Claude Code commands

**Used by**: Internal to ResearchKit commands

**What it is**: This template defines how Claude behaves when you run ResearchKit commands. It ensures:
- Consistent tone (friendly, expert, systematic)
- Structured workflows
- Quality outputs
- Constitutional validation

**You don't edit this directly** - it's used internally by all `/rk-*` commands.

**Example usage in commands**:
```markdown
# /rk.question - Refine Research Questions

You are a research methodology expert helping refine vague questions.

## Your Task
[Instructions for Claude...]
```

---

## Constitution Template

**File**: `constitution-template.md`

**Purpose**: Define immutable research methodology principles

**Used by**: `/rk-constitution` command

**Output**: `[project]/.researchkit/constitution.md`

**What it captures**:
- 5-7 core methodological principles
- Non-negotiable research commitments
- Quality standards for all outputs
- Ethical guidelines

**Template Structure**:

```markdown
# Research Constitution

**Project**: [Your Research Topic]
**Created**: [Date]
**Status**: Immutable (can only be amended with explicit rationale)

---

## Core Principles

### 1. [PRINCIPLE_NAME]

**Commitment**: [What you commit to doing]

**Rationale**: [Why this matters for rigor]

**Violation test**: [What would constitute breaking this principle]

**Application**: [How this shows up in practice]

---

### 2. [PRINCIPLE_NAME]

[Same structure...]
```

**Example Principles**:

1. **Multi-Perspective Analysis**
   - Commitment: Examine every question through 3+ disciplinary lenses
   - Rationale: Single perspectives create blind spots
   - Violation: Citing only one research tradition
   - Application: Use `/rk-identify-paths` to ensure 3+ perspectives

2. **Evidence-Based Reasoning**
   - Commitment: All claims must be cited
   - Rationale: Assertions without evidence aren't research
   - Violation: Making claims without sources
   - Application: Track sources with `/rk-collect-documents`

3. **Contradiction Awareness**
   - Commitment: Document tensions rather than hide them
   - Rationale: Real phenomena have contradictions
   - Violation: Smoothing over discipline conflicts
   - Application: Use `/rk-cross-stream` to surface tensions

**When to use**:
- At project start, right after `/rk-init`
- Before conducting research
- Reference throughout to validate work

**Why it matters**: The constitution ensures methodological rigor. Every subsequent step can be validated against these principles.

---

## Question Template

**File**: `question-template.md`

**Purpose**: Track evolution from vague to precise research questions

**Used by**: `/rk-question` command

**Output**: `[project]/.researchkit/questions/question-[number]-[date].md`

**Template Structure**:

```markdown
# Research Question

**Project**: [PROJECT_NAME]
**Version**: [VERSION]
**Date**: [DATE]

---

## Original Broad Question

[Initial vague question]

**Why this matters**: [Your motivation]

**Intended audience**: [Who will use insights]

**Practical context**: [Real-world problem this informs]

---

## Refinement Options

### Option 1: [REFINED_QUESTION_1]

**Focus**: [What this emphasizes - e.g., "identity dynamics"]

**Key assumptions**: [What this takes for granted]

**Disciplines engaged**: [Fields this draws from]

**Scope**: [Broad / Medium / Narrow]

**Practical value**: [How actionable are likely insights]

---

### Option 2: [REFINED_QUESTION_2]

[Same structure...]

### Option 3: [REFINED_QUESTION_3]

[Same structure...]

---

## Selected Question(s)

### Primary Question
[SELECTED_QUESTION]

**Rationale for selection**: [Why this formulation]

**Expected insights**: [What answers this should yield]

**Research paths implied**: [What traditions to investigate]

---

### Secondary Questions (if applicable)

[Supporting questions that emerged]
```

**What it captures**:

1. **Original broad question**
   - Shows starting point
   - Documents motivation

2. **Refinement options** (3-5 variants)
   - Each with different focus/assumptions
   - Shows disciplinary implications
   - Rates practical value

3. **Selected question**
   - Final refined question
   - Rationale for selection
   - Expected research paths

**Example**:

**Original**: "What do we know about organizational change?"

**Option 1**: "How do organizational identities evolve during technological transitions?"
- Focus: Identity dynamics
- Assumes: Organizations have identities
- Disciplines: Organizational psychology, sociology
- Scope: Medium
- Practical value: High (helps leaders understand resistance)

**Option 2**: "What structural conditions enable rapid organizational transformation?"
- Focus: Organizational design
- Assumes: Structure determines outcomes
- Disciplines: Economics, management theory
- Scope: Narrow
- Practical value: Very high (actionable design principles)

**When to use**:
- After defining constitution
- Before conducting research
- Iterate multiple times to refine

**Why it matters**: Precise questions lead to answerable research. This template makes assumptions explicit.

---

## Research Path Template

**File**: `research-path-template.md`

**Purpose**: Document disciplinary research traditions

**Used by**: `/rk-identify-paths` command

**Output**: `[project]/.researchkit/research-paths/paths/path-[number]-[tradition-name].md`

**Template Structure**:

```markdown
# Research Path: [TRADITION_NAME]

**Project**: [PROJECT_NAME]
**Date**: [DATE]

---

## Overview

**Research tradition**: [Name - e.g., "Institutional Theory", "Behavioral Economics"]

**Core insight**: [Central claim of this tradition in one sentence]

**Founding scholars**: [Key contributors]

**Time period**: [When this tradition emerged]

---

## Core Concepts

### Concept 1: [CONCEPT_NAME]

**Definition**: [What it means]

**Why it matters**: [Explanatory power]

### Concept 2: [CONCEPT_NAME]

[Same structure...]

---

## Typical Methods

[How researchers in this tradition gather evidence]

**Strengths**: [What these methods reveal]

**Limitations**: [What they miss]

---

## Key Assumptions

**Ontological** (what exists):
- [What this tradition assumes about reality]

**Epistemological** (how we know):
- [What this tradition accepts as evidence]

**Practical** (what matters):
- [What this tradition values]

---

## What This Tradition Illuminates

[What questions this perspective answers well]

**Strengths**:
- [STRENGTH_1]
- [STRENGTH_2]

---

## What This Tradition Obscures

[What this perspective misses or takes for granted]

**Blind spots**:
- [BLIND_SPOT_1]
- [BLIND_SPOT_2]

---

## Recommended Starting Points

**Foundational**:
- [CLASSIC_WORK_1]
- [CLASSIC_WORK_2]

**Recent reviews**:
- [REVIEW_ARTICLE_1]
```

**What it captures**:

1. **Tradition overview**
   - Name and core insight
   - Founding scholars
   - Historical context

2. **Core concepts**
   - Key theoretical constructs
   - Explanatory framework

3. **Methods**
   - How evidence is gathered
   - Strengths and limitations

4. **Assumptions** (critical!)
   - What it takes for granted
   - Ontology and epistemology

5. **Strengths and blind spots**
   - What it illuminates
   - What it obscures

6. **Reading list**
   - Starting points for research

**Example**:

**Tradition**: Sensemaking Theory

**Core insight**: People create plausible narratives to make sense of ambiguous situations

**Core concepts**:
- Plausibility (not accuracy)
- Retrospective rationalization
- Identity construction

**Illuminates**: How people experience and interpret change

**Obscures**: Structural power dynamics, economic constraints

**When to use**:
- After refining question
- Before conducting research
- Create 3-5 paths for multi-disciplinary work

**Why it matters**: Makes disciplinary assumptions explicit. Prevents single-perspective bias.

---

## Story Template

**File**: `story-template.md`

**Purpose**: Capture vivid, character-driven stories

**Used by**: `/rk-capture-story` command

**Output**: `[project]/.researchkit/stories/meta/[story-name].md`

**Template Structure**:

```markdown
# Story: [STORY_TITLE]

**Date captured**: [DATE]
**Vividness rating**: [1-10]
**Status**: [Raw / Verified / Ready for Writing]

---

## One-Sentence Summary

[Capture the essence: Who, did what, with what surprising consequence]

---

## Full Narrative

[Tell the story with vivid detail:
- Specific names, dates, places
- Direct quotes if available
- Sensory details
- Emotional tone
- Irony, surprise, or tension
- Concrete consequences]

**Word count**: [Aim for 150-300 words]

---

## Key Characters

**Primary**:
- [NAME], [ROLE] - [One-line description]

**Secondary**:
- [NAME], [ROLE] - [One-line description]

---

## Key Moments

**Moment 1**: [DATE/TIME] - [What happened]

**Moment 2**: [DATE/TIME] - [What happened]

**Turning point**: [The moment that changed everything]

---

## Emotional Tone

**Primary emotion**: [What does this story make you feel?]

**Why this matters**: [What makes this emotionally resonant?]

---

## Concepts Illustrated

**Primary concepts**:
- [CONCEPT_1] - [How story illustrates it]
- [CONCEPT_2] - [How story illustrates it]

**Frameworks this supports**:
- [FRAMEWORK_1]
- [FRAMEWORK_2]

---

## Source

**Citation**: [Full bibliographic citation]

**Page/location**: [Where in source]

**Context**: [What was author explaining with this story]

**Verification status**: [Verified / Secondhand / Anecdotal]

---

## Vividness Elements

Rate 1-10 on:
- **Specificity**: [Concrete details vs. abstract]
- **Characters**: [Named individuals vs. archetypes]
- **Dialogue**: [Direct quotes vs. paraphrase]
- **Sensory detail**: [Can you see/hear/feel it]
- **Surprise**: [Unexpected twist or irony]
- **Consequence**: [Clear stakes and outcomes]

**Overall vividness**: [1-10]

[Use 8+ for writing. Below 8 needs more detail.]
```

**What it captures**:

1. **One-sentence summary**
   - Who, what, consequence
   - Twitter-length essence

2. **Full narrative**
   - Vivid details
   - Quotes, names, dates
   - 150-300 words

3. **Characters**
   - Real people with names/roles
   - Not archetypes

4. **Key moments**
   - Specific times/dates
   - Turning points

5. **Emotional tone**
   - What you feel
   - Why it resonates

6. **Concepts illustrated**
   - What theories this demonstrates
   - Links to frameworks

7. **Source**
   - Full citation
   - Verification status

8. **Vividness rating**
   - Scored 1-10
   - 8+ ready for writing

**Example**:

**Story**: "Kodak's Digital Camera Burial"

**Summary**: Steve Sasson invented the digital camera at Kodak in 1975, executives told him not to tell anyone, and Kodak missed the digital revolution.

**Key moments**:
- 1975: Sasson, age 24, demonstrates prototype
- Executive response: "That's cute—but don't tell anyone about it"
- 2012: Kodak files for bankruptcy

**Vividness**: 9/10
- Specific person (Steve Sasson, age 24)
- Direct quote
- Dramatic irony (invented future, told to hide it)
- Clear consequence (bankruptcy)

**Concepts illustrated**:
- Institutional inertia
- Disruptive innovation
- Organizational identity threat

**When to use**:
- Whenever you encounter a compelling story during research
- Capture immediately with full detail
- Use `/rk-find-stories` later when writing

**Why it matters**: Stories make frameworks memorable. Capturing with full vivid detail during research is far easier than reconstructing later.

---

## Framework Template

**File**: `framework-template.md`

**Purpose**: Extract actionable frameworks from research

**Used by**: `/rk-frameworks` command

**Output**: `[project]/.researchkit/synthesis/frameworks/framework-[name].md`

**Template Structure**:

```markdown
# Framework: [FRAMEWORK_NAME]

**Version**: [VERSION]
**Date**: [DATE]
**Status**: [Draft / Refined / Validated / Ready for Writing]

---

## Framework Summary (1-2 sentences)

[What this framework is and what it helps explain or decide]

---

## The Core Insight

[Central "aha" or key principle]

**In plain language**: [Explain to intelligent non-expert]

---

## The Problem This Framework Addresses

**Practitioner challenge**: [Real-world problem this solves]

**Without this framework**: [What happens without this mental model]

**With this framework**: [What becomes possible]

---

## Framework Components

### Component 1: [COMPONENT_NAME]

**Description**: [What is this component?]

**Why it matters**: [Why essential?]

**How to identify it**: [Questions to ask / signals to look for]

**Example**: [Concrete example]

---

### Component 2: [COMPONENT_NAME]

[Same structure...]

### Component 3: [COMPONENT_NAME]

[Same structure...]

---

## How the Components Interact

[Relationships, tensions, or dynamics between components]

**Visual representation**:
```
[ASCII diagram or description]
Example:
    Component A ←→ Component B
         ↓             ↓
    Creates tension in Component C
```

---

## When to Use This Framework

**Ideal contexts**:
- [CONTEXT_1]
- [CONTEXT_2]

**Not appropriate when**:
- [WRONG_CONTEXT_1]
- [WRONG_CONTEXT_2]

**Boundary conditions**: [When does this framework apply vs. not apply]

---

## How to Apply This Framework

**Step 1**: [ACTION]
- [Specific guidance]

**Step 2**: [ACTION]
- [Specific guidance]

**Step 3**: [ACTION]
- [Specific guidance]

**Step 4**: [ACTION]
- [Specific guidance]

---

## Illustrative Stories

### Story 1: [STORY_NAME]

**In one sentence**: [Story summary]

**What it illustrates**: [Which component/interaction]

**Vividness**: [Rating]

**Full story**: [Link to stories/meta/[story-name].md OR embed if short]

---

### Story 2: [STORY_NAME]

[Same structure...]

---

## Evidence Base

**Primary sources**:
- [SOURCE_1] - [Key finding]
- [SOURCE_2] - [Key finding]

**Research traditions contributing**:
- [TRADITION_1] - [What it contributed]
- [TRADITION_2] - [What it contributed]

**Cross-stream synthesis**: [How disciplines converged to produce this framework]

---

## Validation Against Constitution

[Check each constitutional principle]

✓ **[PRINCIPLE_1]**: [How this framework upholds it]

✓ **[PRINCIPLE_2]**: [How this framework upholds it]

---

## Practitioner Takeaways

**Key insight**: [Most important thing to remember]

**Actionable steps**:
1. [SPECIFIC_ACTION_1]
2. [SPECIFIC_ACTION_2]
3. [SPECIFIC_ACTION_3]

**Common mistakes to avoid**:
- [MISTAKE_1]
- [MISTAKE_2]
```

**What it captures**:

1. **Core insight**
   - The "aha" moment
   - Plain language explanation

2. **Problem addressed**
   - Real-world challenge
   - Before/after comparison

3. **Components**
   - 3-5 key elements
   - How to identify each
   - Examples

4. **Interactions**
   - How components relate
   - Visual diagram

5. **Boundary conditions**
   - When to use
   - When NOT to use

6. **Application process**
   - Step-by-step how-to
   - Specific guidance

7. **Illustrative stories**
   - Links to story library
   - Shows framework in action

8. **Evidence base**
   - Sources from research
   - Multi-disciplinary synthesis

9. **Validation**
   - Checks against constitution
   - Ensures rigor

10. **Practitioner takeaways**
    - Actionable steps
    - Common mistakes

**Example Framework**:

**Name**: "The Identity-Strategy Tension"

**Core insight**: Organizational change requires balancing "who we are" (identity) with "what we need to do" (strategy). Ignoring either creates failure.

**Components**:
1. **Organizational Identity**: Deep beliefs about "what we are"
2. **Strategic Imperatives**: Market demands for change
3. **The Tension**: Identity resists what strategy requires

**When to use**: During organizational change, mergers, pivots

**Not appropriate**: Routine operations, incremental improvements

**Stories**:
- Kodak (identity as "film company" prevented digital pivot)
- IBM (identity shift from "hardware" to "services" enabled survival)

**When to use**:
- After cross-stream synthesis
- When ready to make research actionable
- Extract 1-3 frameworks per project

**Why it matters**: Transforms research into practitioner-ready tools. This is the payoff of rigorous multi-disciplinary work.

---

## Using Templates

### Where Templates Live

```
~/.researchkit/templates/
├── CLAUDE-template.md           # Internal use by commands
├── constitution-template.md     # Used by /rk-constitution
├── framework-template.md        # Used by /rk-frameworks
├── question-template.md         # Used by /rk-question
├── research-path-template.md    # Used by /rk-identify-paths
└── story-template.md           # Used by /rk-capture-story
```

### Automatic Template Use

Templates are used automatically by commands. You don't manually copy them.

**Example workflow**:
```bash
/rk-question
# Claude uses question-template.md internally
# Outputs: .researchkit/questions/question-001-20251025.md
```

### Customizing Templates

You CAN customize templates:

1. **Edit the template** in `~/.researchkit/templates/`
2. **Next use** of the command will use your customized version
3. **Updates preserve customizations** (installer detects modifications)

**Example**:
```bash
# Edit the question template
nano ~/.researchkit/templates/question-template.md

# Add your own sections
## My Custom Section
[CUSTOM_FIELD]

# Next time you run /rk-question, it will include your custom section
```

**Note**: The updater detects template modifications and preserves them. See [Installation Guide](installation-guide.md#updating-researchkit).

### Template Validation

Templates are validated during `/rk-validate`:

```bash
/rk-validate
# Checks all 6 templates present
# Auto-restores missing templates
```

---

## Template Design Principles

All ResearchKit templates follow these principles:

1. **Practitioner-ready**
   - Plain language
   - Actionable outputs
   - Real-world focus

2. **Evidence-based**
   - Require citations
   - Track sources
   - Enable verification

3. **Multi-disciplinary**
   - Engage multiple perspectives
   - Surface assumptions
   - Document blind spots

4. **Story-driven**
   - Pair concepts with narratives
   - Capture vivid details
   - Rate vividness

5. **Rigorous**
   - Validate against constitution
   - Make assumptions explicit
   - Document contradictions

6. **Iterative**
   - Support refinement
   - Track versions
   - Enable evolution

---

## Next Steps

- **See templates in action**: [Getting Started Guide](getting-started.md)
- **Understand commands**: [Commands Reference](commands-reference.md)
- **Troubleshoot issues**: [Troubleshooting](troubleshooting.md)
