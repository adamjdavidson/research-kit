# /rk.frameworks - Extract Frameworks from Research

You are helping the user extract actionable frameworks from their research.

## Prerequisites

Check if `.researchkit/` folder exists in current directory or parent directories.

**If NOT found:**
- Tell user: "No ResearchKit project found. Run `/rk.init` first."
- Exit

## Context

After conducting research across multiple streams, users need to synthesize insights into actionable frameworks that practitioners can actually use.

This command helps extract frameworks that are:
- Grounded in research evidence
- Illustrated with vivid stories
- Practical and actionable
- Clear about boundaries (when to use/not use)

## Your Task

### Step 1: Review Research

Load all research artifacts:
- `.researchkit/streams/*/concepts.md` - Concepts from each stream
- `.researchkit/streams/*/notes.md` - Research notes
- `.researchkit/stories/index.md` - Available stories

Ask: "What framework do you want to extract? Or should I suggest frameworks based on your research?"

### Step 2: Identify Framework Candidates

If user wants suggestions, analyze concepts across streams:

```
Based on your research, I see potential frameworks around:

1. **[Framework Concept 1]**
   - Appears in: [stream1], [stream2]
   - Core insight: [What it helps explain]
   - Practical use: [What decisions it informs]

2. **[Framework Concept 2]**
   - Appears in: [stream3]
   - Core insight: [What it helps explain]
   - Practical use: [What decisions it informs]

3. **[Framework Concept 3]**
   - Cross-stream synthesis
   - Integrates: [concept from stream1] + [concept from stream2]
   - Practical use: [What decisions it informs]

Which framework would you like to develop first?
```

### Step 3: Extract Framework Components

For the selected framework, guide user through structured extraction:

#### A. Core Insight
```
What's the central "aha" or key principle this framework captures?

In plain language (as if explaining to an intelligent non-expert):
```

#### B. The Problem It Addresses
```
What practitioner challenge does this framework help solve?

Without this framework: [What happens when people lack this mental model?]
With this framework: [What becomes possible or clearer?]
```

#### C. Framework Components
```
What are the key elements or dimensions of this framework?

For each component:
- What is it?
- Why does it matter?
- How do you identify it in practice?
```

#### D. Illustrative Stories
```
Query story library: /rk.find-stories --concept [framework-concept]

Which stories best illustrate this framework?
- Lead story (highest vividness): [story-name]
- Supporting stories: [other stories]
- Contrasting story (what happens without framework): [story-name]
```

#### E. Boundary Conditions
```
When does this framework apply?
When does it NOT apply?
What are warning signs of misapplication?
```

#### F. Application Process
```
How would a practitioner actually USE this framework?

Step-by-step:
1. [First step]
2. [Second step]
3. [Third step]
...
```

### Step 4: Create Framework Document

Using template from `templates/framework-template.md`, create:

`.researchkit/synthesis/frameworks/[framework-slug].md`

Fill in all template sections:
- Framework summary
- Core insight
- Problem addressed
- Components and interactions
- When to use / not use
- Illustrative stories (with vividness ratings)
- Evidence base (cite specific research)
- Practical applications for different audiences
- Common misunderstandings
- Diagnostic questions

### Step 5: Link Evidence

For each claim in the framework:

```markdown
**Claim**: [Statement in framework]
**Evidence**:
- [Stream name]: [Concept or finding] from [Source (Year)]
- [Stream name]: [Concept or finding] from [Source (Year)]

**Stories illustrating**:
- [[story-name]] (Vividness: X/10) - [What it shows]
```

Ensure traceability back to research.

### Step 6: Cross-Reference

Update related files:

**In concept files (`.researchkit/streams/*/concepts.md`):**
Add reference:
```markdown
## [CONCEPT_NAME]

[... existing content ...]

**Used in Frameworks**:
- [[framework-name]] - [How this concept is used in the framework]
```

**In story files (`.researchkit/stories/meta/[story].md`):**
Add to "What This Illustrates":
```markdown
### Frameworks
- [[framework-name]] - [How story illustrates this framework]
```

### Step 7: Test Framework Clarity

Ask user to walk through application:

```
Let's test this framework with a scenario:

Imagine: [Concrete scenario relevant to framework]

Using this framework:
1. What would you identify first?
2. What would you assess?
3. What decision would this inform?

Does the framework make this clearer?
```

If unclear, refine framework components or application steps.

### Step 8: Suggest Next Steps

```
✅ Framework extracted: [Framework Name]

Location: .researchkit/synthesis/frameworks/[framework-slug].md

The framework includes:
- [X] components defined
- [X] stories linked (vividness 8+: [X])
- [X] sources cited
- [X] application steps

Next steps:
- Refine: Edit the framework file directly
- Extract another: /rk.frameworks (select different concept)
- Use in writing: /rk.write with this framework
- Validate: /rk.validate to check against constitution
```

## Framework Quality Guidelines

### Good Frameworks Are:

**Practical:**
- Address real decisions practitioners face
- Include clear application steps
- Specify when to use and when not to use

**Evidence-Based:**
- Grounded in research from multiple sources
- Cite specific findings
- Acknowledge contradictions or limitations

**Clear:**
- Explained in accessible language
- Use concrete examples and stories
- Avoid unnecessary jargon

**Bounded:**
- Explicit about scope (when applies)
- Warning signs of misapplication
- Acknowledge what framework doesn't address

### Framework Types

**Decision Framework:**
- Helps choose between options
- Clear criteria for evaluation
- Step-by-step process

**Diagnostic Framework:**
- Helps identify problems or patterns
- Observable indicators
- Questions to ask

**Explanatory Model:**
- Helps understand why things happen
- Cause-and-effect relationships
- Mechanisms explained

**Process Framework:**
- Guides how to do something
- Sequential steps
- Checkpoints and validation

## Integration with Stories

**Every framework should have:**
- At least ONE high-vividness story (8+) as lead example
- Supporting stories showing different aspects
- Ideally one contrasting story (failure without framework)

**Stories make frameworks:**
- Memorable
- Emotionally resonant
- Concrete rather than abstract
- Easier to communicate

## Evidence Synthesis

**When extracting frameworks:**

**Converging evidence** (multiple sources agree):
- State finding confidently
- Cite multiple sources
- Note if consensus across disciplines

**Diverging evidence** (sources disagree):
- Acknowledge the contradiction
- Explain different perspectives
- Note boundary conditions where each applies

**Single source**:
- Note the limitation
- Explain why still including
- Mark as preliminary/needs validation

## File Locations

- Frameworks: `.researchkit/synthesis/frameworks/[framework-slug].md`
- Template: `templates/framework-template.md`
- Concepts: `.researchkit/streams/*/concepts.md`
- Stories: `.researchkit/stories/meta/*.md`

## Important Notes

**On framework development:**
- Start with one framework, not many
- Refine through iteration
- Test with real scenarios
- Get feedback from potential users

**On practitioner focus:**
- Always ask: "So what? How does this help someone make a decision?"
- Avoid academic frameworks that aren't actionable
- Include real-world constraints (time, resources, politics)

**On revision:**
- Frameworks evolve as understanding deepens
- Mark as "Draft" initially
- Update as you learn more or get feedback
- Track version/evolution in framework file
