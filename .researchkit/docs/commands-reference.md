# Commands Reference

Complete reference for all 13 ResearchKit commands.

---

## How to Use Commands

**All ResearchKit commands are used within Claude Code**, not in your regular terminal.

**To use a command:**
1. Open your terminal
2. Navigate to your project directory: `cd my-research-project`
3. Start Claude Code: `claude`
4. Type the command: `/rk-init` (or any other ResearchKit command)

**What's the `/` for?** In Claude Code, commands start with a forward slash `/`. This tells Claude Code you're running a command, not just chatting.

**Example:**
```
You: /rk-question
Claude: I'll help you refine your research question...
```

**New to Claude Code?** See the main **[README](../../README.md)** for step-by-step instructions on how to start Claude Code.

---

## Table of Contents

1. [Command Overview](#command-overview)
2. [Project Setup](#project-setup)
3. [Question Development](#question-development)
4. [Research Planning](#research-planning)
5. [Research Execution](#research-execution)
6. [Story Management](#story-management)
7. [Synthesis](#synthesis)
8. [Writing](#writing)
9. [Maintenance](#maintenance)

---

## Command Overview

ResearchKit provides 13 commands that guide you through rigorous research.

**IMPORTANT: Use commands in this order** (see [Complete Workflow](#complete-workflow) for details):
1. **Setup Phase** - `/rk-init` → `/rk-constitution`
2. **Planning Phase** - `/rk-question` → `/rk-identify-paths`
3. **Research Phase** - `/rk-create-stream` (repeat for each perspective)
4. **Throughout Research** - `/rk-capture-story`, `/rk-collect-documents`, `/rk-find-stories`
5. **Synthesis Phase** - `/rk-cross-stream` → `/rk-frameworks`
6. **Writing Phase** - `/rk-write`
7. **Maintenance** - `/rk-validate` (use anytime)
8. **Complete Workflow** - `/rk-research` (guides through all steps)

### All Commands

| Command | Phase | Purpose |
|---------|-------|---------|
| `/rk-init` | Setup | Initialize project in current directory |
| `/rk-constitution` | Setup | Define research principles |
| `/rk-question` | Question | Refine vague questions |
| `/rk-identify-paths` | Planning | Identify research traditions |
| `/rk-create-stream` | Research | Research within a discipline |
| `/rk-collect-documents` | Research | Organize source documents |
| `/rk-capture-story` | Research | Capture vivid stories |
| `/rk-find-stories` | Research | Search story library |
| `/rk-cross-stream` | Synthesis | Synthesize across disciplines |
| `/rk-frameworks` | Synthesis | Extract actionable frameworks |
| `/rk-write` | Writing | Generate professional writing |
| `/rk-research` | Workflow | Complete research workflow |
| `/rk-validate` | Maintenance | Check installation health |

---

## Project Setup

### `/rk-init` - Initialize Project

**Purpose**: Initialize ResearchKit in the current directory

**When to use**: Once at the start of a new research project

**What it does**:
1. Checks if already initialized
2. Asks for project name and description
3. Creates `.researchkit/` directory structure:
   - `constitution.md` - Research principles
   - `questions/` - Question evolution
   - `research-paths/` - Research traditions
   - `documents/` - Collected sources
   - `stories/` - Story library
   - `streams/` - Disciplinary research
   - `synthesis/` - Frameworks
   - `writing/` - Drafts

**Usage**:

**In your terminal:**
```bash
cd ~/my-research-topic
claude
```

**Then in Claude Code:**
```
/rk-init
```

**Prompts**:
- "What's the name of this research project?"
- "Brief description (optional):"

**Output**: `.researchkit/` folder with complete structure

**Notes**:
- Can run in any directory
- Preserves existing data if reinitialized
- Creates `.gitignore` for document management

---

### `/rk-constitution` - Define Research Principles

**Purpose**: Create your research methodology "constitution"

**When to use**: After `/rk-init`, before starting research

**What it does**:
1. Explains the constitution concept
2. Provides example principles
3. Helps you define 5-7 core principles
4. Saves to `.researchkit/constitution.md`

**Usage**:

**In Claude Code:**
```
/rk-constitution
```

**Example Principles**:
- Multi-Perspective Analysis (examine through 3+ lenses)
- Evidence-Based Reasoning (all claims cited)
- Contradiction Awareness (document tensions)
- Framework Extraction (produce actionable insights)
- Practitioner Readiness (accessible to non-experts)
- Narrative Evidence (pair concepts with vivid stories)

**Output**: `constitution.md` with your principles

**Why it matters**: Ensures methodological rigor throughout research. Every subsequent step can be validated against these principles.

---

## Question Development

### `/rk-question` - Refine Questions

**Purpose**: Transform vague questions into precise, answerable questions

**When to use**: After defining constitution, before research

**What it does**:
1. Takes your broad question
2. Analyzes hidden assumptions
3. Generates 3-5 refined variants with different:
   - Focus (identity vs. strategy vs. culture)
   - Assumptions (what each takes for granted)
   - Disciplines (psychology vs. economics vs. sociology)
4. Helps you select or refine further

**Usage**:

**In Claude Code:**
```
/rk-question
```

**Example**:

**Input**: "What do we know about organizational change?"

**Output**:
- Q1: "How do organizational identities evolve during technological transitions?" (focuses on identity)
- Q2: "What structural conditions enable rapid organizational transformation?" (focuses on structure)
- Q3: "How do power dynamics shape the pace of organizational change?" (focuses on politics)

**Output File**: `questions/question-001-[date].md`

**Notes**:
- Iterative - can refine multiple times
- Tracks question evolution
- Shows assumptions explicitly

---

## Research Planning

### `/rk-identify-paths` - Identify Research Traditions

**Purpose**: Identify 3-5 disciplinary research traditions for your question

**When to use**: After refining question, before research

**What it does**:
1. Analyzes your question
2. Identifies relevant research traditions (e.g., "Institutional Theory", "Sensemaking Theory")
3. For each tradition, defines:
   - Core concepts
   - Key scholars
   - Typical methods
   - What it takes for granted
   - What it illuminates
4. Saves research paths

**Usage**:

**In Claude Code:**
```
/rk-identify-paths
```

**Example Output**:

**Path 1: Organizational Psychology**
- Core concepts: Identity, sensemaking, motivation
- Key scholars: Weick, Dutton, Pratt
- Methods: Interviews, ethnography
- Assumes: Individual cognition drives behavior
- Illuminates: How people experience change

**Output**: `research-paths/paths/path-001-[tradition-name].md`

**Why it matters**: Multi-disciplinary research by design. Prevents single-perspective bias.

---

### `/rk-collect-documents` - Organize Sources

**Purpose**: Organize and tag source documents

**When to use**: Throughout research as you find sources

**What it does**:
1. Asks for document details:
   - Title, authors, year
   - Document type (book, article, report)
   - Category (foundational, recent-review, supplementary)
   - Research path(s) it relates to
   - Key concepts
   - Summary
2. Creates structured document entry
3. Updates document index

**Usage**:

**In Claude Code:**
```
/rk-collect-documents
```

**Document Categories**:
- **Foundational**: Seminal works, classic texts
- **Recent Reviews**: State-of-the-art summaries
- **Supplementary**: Supporting evidence

**Output**:
- `documents/[category]/[author-year-title].md`
- Updated `documents/index.md`

**Notes**:
- Tracks citations
- Links to research paths
- Searchable by concept

---

## Research Execution

### `/rk-create-stream` - Research a Discipline

**Purpose**: Conduct deep research within a single tradition

**When to use**: After identifying research paths

**What it does**:
1. Lists your research paths
2. You select which one to research
3. Guides you through:
   - Reading foundational works
   - Identifying key concepts
   - Documenting evidence
   - Capturing stories
   - Noting contradictions
4. Creates research stream file

**Usage**:

**In Claude Code:**
```
/rk-create-stream
```

**Prompts**:
- "Which research path are you investigating?"
- "What are the 3-5 key concepts?"
- "What evidence did you find?"
- "What contradictions or tensions emerged?"

**Output**: `streams/stream-001-[tradition-name].md`

**Notes**:
- One stream per tradition
- Documents evidence trail
- Links to captured stories

---

## Story Management

### `/rk-capture-story` - Capture Stories

**Purpose**: Capture vivid, character-driven stories that illustrate concepts

**When to use**: Whenever you encounter a compelling story during research

**What it does**:
1. Guides you through story capture:
   - One-sentence summary
   - Full narrative with vivid detail
   - Key characters (names, roles)
   - Specific moments (dates, places, quotes)
   - Emotional tone
   - Concepts this illustrates
   - Source citation
   - Vividness rating (1-10)
2. Saves story with metadata
3. Updates story index

**Usage**:

**In Claude Code:**
```
/rk-capture-story
```

**Story Elements**:
- **Specific person**: "Steve Sasson, age 24"
- **Specific moment**: "In 1975, when he showed executives..."
- **Direct quote**: "That's cute—but don't tell anyone about it"
- **Irony/surprise**: Invented digital camera, told not to pursue it
- **Consequence**: Kodak missed the digital revolution

**Output**:
- `stories/meta/[story-name].md`
- Updated `stories/index.md`

**Why it matters**: Stories make frameworks memorable. Capturing them with full detail during research is far easier than reconstructing later.

---

### `/rk-find-stories` - Search Stories

**Purpose**: Search your story library by concept or keyword

**When to use**: When writing or synthesizing, looking for illustrative stories

**What it does**:
1. Asks what concept you're looking for
2. Searches story index
3. Shows matching stories with:
   - Summary
   - Vividness rating
   - Concepts illustrated
   - Source
4. Can retrieve full story text

**Usage**:

**In Claude Code:**
```
/rk-find-stories
```

**Search by**:
- Concept tags
- Keywords
- Character names
- Source

**Output**: List of matching stories with metadata

**Notes**:
- Stories are tagged during capture
- Searchable by multiple concepts
- Rated for vividness (use 8+ for writing)

---

## Synthesis

### `/rk-cross-stream` - Synthesize Across Disciplines

**Purpose**: Synthesize findings across multiple research traditions

**When to use**: After completing 3+ research streams

**What it does**:
1. Reviews all research streams
2. Identifies:
   - Points of agreement across traditions
   - Contradictions and tensions
   - Complementary insights
   - Gaps each tradition leaves
3. Generates synthesis document

**Usage**:

**In Claude Code:**
```
/rk-cross-stream
```

**Synthesis Structure**:
- **Convergence**: Where traditions agree
- **Divergence**: Where they contradict
- **Complementarity**: How they fill each other's gaps
- **Blind Spots**: What all traditions miss
- **Emerging Insights**: New understanding from synthesis

**Output**: `synthesis/cross-stream-synthesis-[date].md`

**Why it matters**: Multi-disciplinary synthesis produces insights no single tradition offers.

---

### `/rk-frameworks` - Extract Frameworks

**Purpose**: Extract actionable frameworks from research synthesis

**When to use**: After cross-stream synthesis

**What it does**:
1. Reviews synthesis
2. Helps you extract 1-3 frameworks
3. For each framework:
   - Core insight ("aha moment")
   - Problem it addresses
   - Framework components
   - When to use / not use
   - Application process
   - Illustrative stories
   - Evidence sources
4. Validates against constitution

**Usage**:

**In Claude Code:**
```
/rk-frameworks
```

**Framework Components**:
- **Core Insight**: What's the "aha"?
- **Problem**: What challenge does this address?
- **Components**: Key elements and relationships
- **Boundary Conditions**: When does it apply?
- **Application**: How to use it step-by-step
- **Stories**: Vivid illustrations (from story library)
- **Evidence**: Supporting research

**Output**: `synthesis/frameworks/framework-[name].md`

**Why it matters**: Transforms research into practitioner-ready tools.

---

## Writing

### `/rk-write` - Generate Writing

**Purpose**: Generate professional writing from your research

**When to use**: After extracting frameworks

**What it does**:
1. Reviews your frameworks and stories
2. Helps you choose:
   - Writing format (essay, report, guide)
   - Target audience (academics, practitioners, general)
   - Tone (formal, conversational, narrative)
3. Generates outline
4. Drafts sections with:
   - Evidence integration
   - Story weaving
   - Clear frameworks
   - Practitioner focus
5. Validates against constitution

**Usage**:

**In Claude Code:**
```
/rk-write
```

**Writing Formats**:
- **Essay**: Narrative-driven argument
- **Research Report**: Formal findings
- **Practitioner Guide**: How-to with frameworks
- **White Paper**: Policy recommendations

**Output**: `writing/draft-[title]-[date].md`

**Notes**:
- Integrates stories naturally
- Cites all evidence
- Accessible to target audience
- Actionable takeaways

---

## Maintenance

### `/rk-validate` - Validate Installation

**Purpose**: Check ResearchKit installation health

**When to use**:
- After installation
- When commands aren't working
- Before starting important research

**What it does**:
1. Checks directory structure
2. Verifies all 6 templates present
3. Verifies all 13 commands present
4. Checks Claude Code integration
5. Verifies file permissions
6. **Auto-fixes** common issues (can disable with `--no-fix`)

**Usage**:

**In Claude Code:**
```
/rk-validate
```

**Output**:
```
==> Checking your ResearchKit installation... 🔍

[OK] Everything looks great!
[OK] All 6 templates are ready
[OK] All 13 commands are working
[OK] Claude Code integration is perfect

==> ResearchKit is ready to use! 🎉
```

**Options**:
```bash
~/.researchkit/installer/validate.sh --json      # JSON output
~/.researchkit/installer/validate.sh --no-fix    # Don't auto-fix
~/.researchkit/installer/validate.sh --quiet     # Minimal output
```

**Auto-fixes**:
- Missing file permissions
- Missing templates (restores from source)
- Broken symlinks

See [Installation Guide](installation-guide.md#validating-installation) for details.

---

## Complete Workflow

### `/rk-research` - Full Research Workflow

**Purpose**: Guided end-to-end research workflow

**When to use**: For complete research projects

**What it does**:
Orchestrates all commands in sequence:
1. Initialize project (`/rk-init`)
2. Define constitution (`/rk-constitution`)
3. Refine question (`/rk-question`)
4. Identify research paths (`/rk-identify-paths`)
5. Create research streams (`/rk-create-stream`)
6. Cross-stream synthesis (`/rk-cross-stream`)
7. Extract frameworks (`/rk-frameworks`)
8. Generate writing (`/rk-write`)

With reminders to:
- Collect documents as you go
- Capture stories during research
- Validate against constitution

**Usage**:

**In Claude Code:**
```
/rk-research
```

**When to use**:
- First time using ResearchKit (learn the workflow)
- Complex multi-disciplinary research
- Want structured guidance

**When to skip**:
- Already familiar with workflow
- Focused single-discipline research
- Just need specific commands

---

## Command Patterns

### Sequential vs. Iterative

**Sequential** (use once):
- `/rk-init` - One per project
- `/rk-constitution` - One per project

**Iterative** (use multiple times):
- `/rk-question` - Refine questions multiple times
- `/rk-create-stream` - One per research tradition
- `/rk-capture-story` - Every time you find a story
- `/rk-collect-documents` - Every time you find a source

### File Outputs

All commands create dated/numbered files, so you can:
- Track evolution (questions refine over time)
- Compare versions
- Never lose work

Example naming:
```
questions/question-001-20251025.md
questions/question-002-20251026.md
questions/question-003-refined-20251027.md
```

---

## Tips

### 1. Start Small
Don't try to use all commands at once. **Start with these three in Claude Code:**
```
/rk-init
/rk-constitution
/rk-question
```

Then add others as needed.

### 2. Capture Stories Early
Use `/rk-capture-story` the moment you find a vivid story. It's much harder to reconstruct details later.

### 3. One Stream at a Time
Use `/rk-create-stream` to research one discipline thoroughly before moving to the next. Deep beats shallow.

### 4. Validate Often
Run `/rk-validate` if commands stop working or after updates.

### 5. Use `/rk-find-stories` When Writing
When drafting, search for stories by concept to illustrate frameworks.

---

## Next Steps

- **Learn the workflow**: [Getting Started Guide](getting-started.md)
- **Understand templates**: [Templates Reference](templates-reference.md)
- **Troubleshoot issues**: [Troubleshooting](troubleshooting.md)
