# /rk.write - Integrated Writing with Stories and Frameworks

You are helping the user write compelling content that integrates rigorous frameworks with vivid narrative evidence.

## Prerequisites

Check if `.researchkit/` folder exists in current directory or parent directories.

**If NOT found:**
- Tell user: "No ResearchKit project found. Run `/rk.init` first."
- Exit

## Context

After conducting research, extracting frameworks, and capturing stories, users need to WRITE.

This command helps produce writing that combines:
- **Rigorous frameworks** (conceptual clarity)
- **Vivid stories** (emotional engagement)
- **Evidence** (proper citations)
- **Practitioner focus** (actionable insights)

## Your Task

### Step 1: Understand Writing Goal

Ask user:

```
What are you writing?

Options:
1. Framework explainer (teach a framework)
2. Research synthesis (overview of findings)
3. Practitioner guide (how-to application)
4. Analysis piece (apply frameworks to situation)
5. Essay/article (narrative with insights)
6. Other: [describe]
```

And:

```
Who's the audience?
- Academics
- Fortune 500 executives
- General educated readers
- Specific industry (which?)
- Other: [describe]

What's the goal?
- Inform (teach concepts)
- Persuade (change minds)
- Guide (enable action)
- Synthesize (integrate perspectives)
```

### Step 2: Identify Relevant Frameworks

Load available frameworks from `.researchkit/synthesis/frameworks/*.md`

**Ask:** "Which framework(s) should this writing address?"

Or: "Should I suggest frameworks based on your writing goal?"

If suggesting:
```
Based on your goal, these frameworks seem relevant:

1. **[Framework Name]**
   - What it addresses: [problem]
   - Audience fit: [why relevant to your audience]
   - Strength: [what makes it compelling]

2. **[Framework Name]**
   [Same structure]

Which framework(s) would you like to feature?
```

### Step 3: Query Story Library

For each framework selected, find best stories:

```bash
/rk.find-stories --concept [framework-concept] --vividness 8
```

Present story options:

```
Stories for [Framework Name]:

**Lead story candidates** (Vividness 8-10):
1. [[story-name]] (9/10) - [One-line summary]
   - Emotional tone: [Ironic / Hopeful / Tragic / etc.]
   - Best for: Opening hook
   - What it shows: [Aspect of framework]

2. [[story-name]] (8/10) - [One-line summary]
   - Emotional tone: [tone]
   - Best for: Supporting example
   - What it shows: [Aspect of framework]

**Contrasting story** (What happens without framework):
3. [[story-name]] (8/10) - [One-line summary]

Which story should we lead with?
```

### Step 4: Propose Structure

Based on writing type, audience, and selected framework/stories:

```markdown
## Proposed Structure for [Title]

### Hook (200 words)
**Lead with**: [[story-name]]
- Open with vivid moment from story
- Create curiosity or tension
- Connect to reader's experience

### Problem Statement (150 words)
**What**: The challenge practitioners face
**Why it matters**: Stakes and consequences
**Transition**: This is where [framework] helps

### Framework Explanation (500 words)
**Introduce**: [Framework Name]
- Core insight (what it reveals)
- Key components (2-4 elements)
- How components interact

**Use**: [[story-name]] to illustrate each component

### Application (400 words)
**How to use** this framework:
- Step-by-step process
- Diagnostic questions
- Decision criteria

**Example**: [[supporting-story]] showing framework in action

### Contrast (200 words)
**What happens without** this framework:
- [[contrasting-story]]
- Consequences of missing this insight
- Common mistakes

### Conclusion (150 words)
**Synthesis**: Key takeaways
**Action**: What reader should do next
**Memorable close**: Return to opening story or vivid image

---

**Total**: ~1,600 words

Does this structure work for you?
```

### Step 5: Generate Outline

Create detailed outline at `.researchkit/writing/outlines/[topic-slug].md`:

```markdown
# Outline: [Title]

**Audience**: [audience]
**Goal**: [goal]
**Tone**: [tone - e.g., authoritative, conversational, urgent]
**Length**: [target word count]

---

## I. Hook: [[story-name]]

**Opening line**: [Draft compelling first sentence]

**Story beats**:
- [Moment 1 - setup]
- [Moment 2 - tension]
- [Moment 3 - consequence]

**Transition**: [How to move from story to problem]

**Evidence**:
- Story details from: .researchkit/stories/meta/[story-name].md
- Quote: "[Specific quote if available]"

---

## II. Problem Statement

**The challenge**:
[What practitioners struggle with - in their language]

**Why traditional approaches fail**:
[What's missing without this framework]

**Stakes**:
[What's at risk - connect to audience's concerns]

**Evidence**:
- From [stream-name]: [finding] (Source: Author Year)
- From [stream-name]: [finding] (Source: Author Year)

---

## III. Framework: [Framework Name]

**Introduce**:
"[Working title/summary of framework in one sentence]"

**Component 1**: [Name]
- Definition: [what it is]
- Why matters: [significance]
- Illustrate with: [part of lead story or new example]
- Evidence: [cite research]

**Component 2**: [Name]
[Same structure]

**Component 3**: [Name]
[Same structure]

**How components interact**:
[Explain dynamics - tension? sequence? feedback loops?]

**Evidence base**:
- Framework source: .researchkit/synthesis/frameworks/[name].md
- Research citations: [list key sources]

---

## IV. Application

**For [specific audience segment]**:

Step 1: [First action]
- How: [specific guidance]
- Example: [[supporting-story]] or hypothetical scenario

Step 2: [Second action]
[Same structure]

Step 3: [Third action]
[Same structure]

**Diagnostic questions**:
- [Question 1]
- [Question 2]
- [Question 3]

---

## V. Contrast: [[contrasting-story]]

**What went wrong**:
[Story of failure to apply framework]

**Why it failed**:
[Connect failure to missing framework elements]

**Lesson**:
[What this reveals about framework's value]

---

## VI. Conclusion

**Synthesis**:
[Tie together: story → framework → application]

**Key takeaways** (3 bullets):
- [Takeaway 1]
- [Takeaway 2]
- [Takeaway 3]

**Call to action**:
[What should reader do next?]

**Memorable close**:
[Return to opening image or forward-looking statement]

---

## Research References

- Framework: .researchkit/synthesis/frameworks/[name].md
- Stories:
  - Lead: .researchkit/stories/meta/[name].md
  - Supporting: .researchkit/stories/meta/[name].md
  - Contrast: .researchkit/stories/meta/[name].md
- Concepts:
  - .researchkit/streams/[stream]/concepts.md
- Sources to cite: [list key papers/books]
```

### Step 6: Generate Draft (Optional)

If user wants draft generation:

Read:
- Outline created in Step 5
- Story files for full narrative details
- Framework file for precise definitions
- Concept files for evidence

Generate draft at `.researchkit/writing/drafts/[topic-slug].md`:

**Writing guidelines:**
- Lead with narrative (story first)
- Move to abstraction (framework second)
- Return to concrete (application third)
- Use accessible language (explain jargon)
- Cite sources (Author Year format)
- Maintain audience's perspective throughout

### Step 7: Verify Against Constitution

Check constitutional requirements (if they exist):

**Evidence-Based** (Article II typically):
- [ ] All claims cited
- [ ] Sources tracked
- [ ] Primary sources when possible

**Narrative Evidence** (Article VI typically):
- [ ] Framework paired with stories
- [ ] High-vividness stories used (8+)
- [ ] Story sources cited

**Practitioner Ready** (Article V typically):
- [ ] Actionable guidance
- [ ] Real-world constraints acknowledged
- [ ] Jargon explained or avoided

### Step 8: Suggest Next Steps

```
✅ Writing outline/draft created

Location: .researchkit/writing/[outlines or drafts]/[topic-slug].md

Next steps:
1. Review and refine the outline
2. Generate full draft (if haven't already)
3. Verify story details from story library
4. Check citations against research notes
5. Validate against constitution: /rk.validate
6. Revise and polish

Stories used:
- Lead: [[story-name]] (9/10 vividness)
- Supporting: [[story-name]] (8/10 vividness)

Framework:
- [[framework-name]] from .researchkit/synthesis/frameworks/
```

## Writing Types & Structures

### Framework Explainer
**Goal**: Teach the framework
**Structure**: Problem → Framework → Application → Contrast
**Story use**: Illustrate each component + show failure without it

### Research Synthesis
**Goal**: Overview of findings
**Structure**: Question → Methods → Findings → Implications
**Story use**: Make findings concrete and memorable

### Practitioner Guide
**Goal**: Enable action
**Structure**: Challenge → Framework → Step-by-step → Examples
**Story use**: Show application in real scenarios

### Analysis Piece
**Goal**: Apply framework to current situation
**Structure**: Situation → Framework → Analysis → Recommendations
**Story use**: Mix current events with historical parallels

### Essay/Article
**Goal**: Insight with narrative arc
**Structure**: Story → Insight → Broader implications → Conclusion
**Story use**: Central narrative with supporting examples

## Guidelines for Effective Integration

### Story-Framework Balance

**Too much story, not enough framework:**
- Engaging but not actionable
- Memorable but not useful
- Narrative without insight

**Too much framework, not enough story:**
- Informative but dry
- Abstract without concrete
- Forgettable

**Right balance:**
- Lead with story (hook)
- Explain framework (clarity)
- Illustrate with story (concrete)
- Apply framework (actionable)
- Contrast with story (memorable)

### Transitions

**From story to framework:**
- "This moment reveals a pattern that appears across..."
- "What made this possible was understanding..."
- "The framework that explains this is..."

**From framework to application:**
- "Here's how to use this in practice..."
- "For [audience], this means..."
- "The next time you face [situation]..."

**From framework to story:**
- "Consider how this played out when..."
- "This becomes clear in the case of..."
- "We see this pattern in..."

### Citation Style

**In text:**
- Conversational tone: "As researchers at Stanford found..."
- Formal tone: "Studies show... (Author, Year)"
- Mix both based on audience

**In writing file:**
- Include bibliography section at end
- Use consistent format (APA, Chicago, etc.)
- Link to source files in `.researchkit/documents/`

## File Locations

- Outlines: `.researchkit/writing/outlines/[topic-slug].md`
- Drafts: `.researchkit/writing/drafts/[topic-slug].md`
- Frameworks: `.researchkit/synthesis/frameworks/[name].md`
- Stories: `.researchkit/stories/meta/[name].md`

## Important Notes

**On audience:**
- Always keep audience in mind
- Use their language and concerns
- Avoid academic voice for practitioner audiences
- Avoid oversimplification for academic audiences

**On revision:**
- First draft focuses on structure and content
- Second draft refines transitions and flow
- Third draft polishes language and style
- Use /rk.validate between drafts

**On story details:**
- Always verify story details from story files
- Check vividness ratings before committing to a story
- Have backup stories in case one doesn't work
- Respect confidentiality notes in story files
