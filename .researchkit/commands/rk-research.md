# /rk.research - Guided Research Workflow

You are helping the user conduct systematic research within a research stream.

## Prerequisites

Check if `.researchkit/` folder exists in current directory or parent directories.

**If NOT found:**
- Tell user: "No ResearchKit project found. Run `/rk.init` first."
- Exit

## Context

After creating research streams with `/rk.create-stream`, users need to actually READ sources and take notes.

This command provides guided research workflow with prompts for:
- Reading and note-taking
- Concept extraction
- Story capture
- Source tracking

## Your Task

### Step 1: Identify Active Stream

**Ask:** "Which research stream are you working in?"

List available streams from `.researchkit/streams/*/`

If user specifies `--stream [name]` parameter, use that stream.

### Step 2: Check Stream Context

Load for the selected stream:
- `question.md` - Stream-specific research question
- `relevant-docs.md` - Documents to read
- `notes.md` - Existing research notes
- `concepts.md` - Extracted concepts

### Step 3: Suggest Reading Priority

Based on `relevant-docs.md`, suggest what to read next:

```
📚 Suggested Reading Order:

FOUNDATIONAL (Read first):
1. [ ] Author (Year) - "Title"
   - Why start here: [Foundational concept]
   - Location: documents/foundational/file.pdf

2. [ ] Author (Year) - "Title"
   - Why next: [Builds on #1]

RECENT WORK (After foundations):
3. [ ] Author (Year) - "Review Title"
   - Why: Synthesizes recent developments

Which would you like to read now?
```

### Step 4: Guided Reading Session

Once user selects a source:

**Prompt them with structured questions:**

```
📖 Reading: [Author (Year) - Title]

As you read, I'll help you capture:
1. Key takeaways
2. Concepts and frameworks
3. Vivid stories/examples
4. Questions raised
5. Connections to other streams

Let's start. What are your initial impressions or key takeaways from this reading?
```

**Then guide through sections:**

#### A. Key Takeaways
```
What are the 3-5 most important ideas from this reading?

1. [User responds]
2. [User responds]
...
```

#### B. Concepts Identified
```
What concepts, frameworks, or theoretical ideas did this introduce or discuss?

For each concept:
- What is it called?
- How is it defined?
- Why does it matter for your research question?
```

#### C. Stories/Examples
```
Did this reading include any vivid stories, case studies, or examples?

If yes, let's capture them with /rk.capture-story

If they're mentioned but not detailed, note them for follow-up.
```

#### D. Questions Raised
```
What questions did this reading raise?
What do you still need to understand?
What should you explore next?
```

#### E. Connections
```
How does this relate to:
- Your research question?
- Other readings in this stream?
- Concepts from other research streams?
```

### Step 5: Update Research Notes

Add to `.researchkit/streams/[stream]/notes.md`:

```markdown
### [DATE] - [Author (Year)]

**Source**: [Full citation]
**Location**: documents/[folder]/[filename].pdf
**Relevance**: [HIGH / MEDIUM / LOW]

#### Key Takeaways
- [Takeaway 1]
- [Takeaway 2]
- [Takeaway 3]

#### Concepts Identified
- [[concept-name-1]] - [Brief description]
- [[concept-name-2]] - [Brief description]

#### Stories/Examples
- [Brief note] → Captured with /rk.capture-story as [[story-name]]
- [Brief note] → Not detailed enough, note for later

#### Questions Raised
- [Question 1]
- [Question 2]

#### Connections to Other Streams
- Relates to [[concept-from-other-stream]] in [other-stream]
- Contradicts findings in [other reading]

#### Follow-Up
- [ ] Read [related paper cited in this one]
- [ ] Investigate [concept] further
```

### Step 6: Update Concept Registry

For each new concept identified, add or update `.researchkit/streams/[stream]/concepts.md`:

```markdown
## [CONCEPT_NAME]

**Definition**: [Clear definition]

**Foundational Source(s)**:
- [Author (Year)] - [How it was defined/introduced]

**Why It Matters**: [Relevance to research question]

**Related Concepts**:
- [[other-concept]] - [How they relate]

**Illustrative Stories**:
- [[story-name]] (Vividness: X/10) - [How story illustrates]
- [Note if no stories yet captured]

**Contradictions / Complications**:
- [Any debates or different interpretations]

**Practical Application**:
- [How a practitioner would use this]
```

### Step 7: Mark Reading Complete

Update `.researchkit/streams/[stream]/relevant-docs.md`:

```markdown
## Documents Read (Checklist)

- [x] Author (Year) - "Title" - Read [DATE]
- [ ] Author (Year) - "Title" - Not yet read
```

### Step 8: Suggest Next Steps

```
✅ Research notes updated

You've now read: [X] of [Y] documents in this stream
Concepts extracted: [X]
Stories captured: [X]

Next steps:
- Continue reading: Next suggested document is [title]
- Switch streams: /rk.research --stream [other-stream]
- Review progress: Check streams/[stream]/notes.md
- Find patterns: /rk.cross-stream to identify connections
```

## Research Session Types

### Deep Reading Session
Full engagement with one source:
- Read completely
- Detailed notes
- Concept extraction
- Story capture

### Skimming Session
Quick review of multiple sources:
- Read abstract + key sections
- Capture main ideas only
- Flag for deeper reading later

### Citation Chasing
Following references from one paper:
- Note which papers are frequently cited
- Add important citations to reading list
- Track influence networks

### Synthesis Session
Reviewing multiple sources together:
- Identify common themes
- Note contradictions
- Extract patterns
- Update concepts with cross-source insights

## Guidelines

### For Effective Note-Taking

**Be specific:**
- Quote directly when possible
- Note page numbers
- Capture exact definitions

**Be reflective:**
- How does this connect to your question?
- What surprises you?
- What contradicts other readings?

**Be selective:**
- Focus on insights relevant to your question
- Don't try to capture everything
- Prioritize novel ideas and key concepts

### For Concept Extraction

**Good concepts are:**
- Clearly defined
- Relevant to research question
- Appear across multiple sources (or are uniquely important)
- Have practical application

**Track evolution:**
- How have concepts changed over time?
- Do recent papers refine older concepts?
- Are there competing definitions?

### For Story Capture

**During research, flag stories for later capture:**
- "Vivid example in Author (Year), p. 45 - CEO's transformation moment"
- Then use `/rk.capture-story` to record full details

**Look for stories that:**
- Have specific people, dates, places
- Include quotes or dialogue
- Show consequences (what happened)
- Illustrate abstract concepts concretely

## Important Notes

**On reading pace:**
- Deep reading takes time - it's okay to spend hours on one paper
- Foundation texts deserve most attention
- Later sources can be skimmed for specific points

**On iteration:**
- You'll often need to re-read sources after learning more
- Early notes may be revised as understanding deepens
- That's normal and good

**On switching streams:**
- Research multiple streams in parallel
- Switching between disciplines can spark insights
- Note cross-stream connections as they emerge

## File Locations

- Stream notes: `.researchkit/streams/[stream]/notes.md`
- Concepts: `.researchkit/streams/[stream]/concepts.md`
- Relevant docs: `.researchkit/streams/[stream]/relevant-docs.md`
- Story library: `.researchkit/stories/meta/[story-name].md`
