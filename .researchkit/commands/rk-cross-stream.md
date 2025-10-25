# /rk.cross-stream - Cross-Stream Synthesis

You are helping the user find connections, patterns, and contradictions across their multi-disciplinary research streams.

## Prerequisites

Check if `.researchkit/` folder exists in current directory or parent directories.

**If NOT found:**
- Tell user: "No ResearchKit project found. Run `/rk.init` first."
- Exit

## Context

After conducting research in multiple disciplinary streams, users need to synthesize across streams to:
- Find common concepts appearing in different disciplines
- Identify contradictions or tensions
- Discover integration opportunities
- Generate cross-disciplinary insights

## Your Task

### Step 1: Identify Active Streams

Load all research streams from `.researchkit/streams/*/`

List streams found:
```
Found [X] research streams:
1. [stream-1] - [discipline]
2. [stream-2] - [discipline]
3. [stream-3] - [discipline]

Ready to analyze cross-stream connections.
```

If fewer than 2 streams, note:
```
Only 1 stream found. Cross-stream analysis works best with 2+ streams.
Create additional streams with /rk.create-stream
```

### Step 2: Analyze Concept Overlap

Read concepts from each stream's `concepts.md` file.

Identify:

#### A. Shared Concepts (Same concept, different perspectives)
```
## Concepts Appearing in Multiple Streams

### [CONCEPT_NAME]
**Appears in**: [stream-1], [stream-2]

**How [stream-1] understands it**:
[Definition/perspective from this stream]

**How [stream-2] understands it**:
[Definition/perspective from this stream]

**Synthesis**:
- What we gain from both perspectives: [insight]
- Key insight from integration: [insight]
- Implications: [what this means]
```

#### B. Related But Different Concepts
```
### [CONCEPT_1] (from [stream-1]) ↔ [CONCEPT-2] (from [stream-2])

**How they relate**:
[Explanation of relationship - complementary? subset? cause-effect?]

**Integration opportunity**:
[How combining these concepts creates new insight]
```

#### C. Unique to One Stream
```
### [CONCEPT] (only in [stream-name])

**Why this matters**:
[What this disciplinary perspective uniquely contributes]

**Potential connections**:
[Concepts from other streams this might relate to]
```

### Step 3: Identify Contradictions

Look for places where streams disagree:

```markdown
## Contradictions & Tensions

### Contradiction 1: [What the disagreement is about]

**[Stream-1] perspective**:
[What this stream says]
- Evidence: [Sources]
- Rationale: [Why this view]

**[Stream-2] perspective**:
[What this stream says]
- Evidence: [Sources]
- Rationale: [Why this view]

**Why both might be right**:
[How to reconcile - boundary conditions? different contexts?]

**Practical implication**:
[Does this contradiction matter for practitioners? Or just academic?]
```

### Step 4: Map Integration Opportunities

Identify where combining stream insights creates value:

```markdown
## Integration Opportunities

### Integration 1: [Integration Name]

**Combines**:
- [Concept from stream-1]
- [Concept from stream-2]
- [Concept from stream-3]

**New insight created**:
[What you understand by combining these that you wouldn't from one stream alone]

**Potential framework**:
[If this could become a framework, what would it address?]

**Next steps**:
- [ ] Develop this into framework with /rk.frameworks
- [ ] Find stories that illustrate this integration
- [ ] Test application scenarios
```

### Step 5: Create Synthesis Document

Create or update `.researchkit/synthesis/cross-stream-analysis.md`:

```markdown
# Cross-Stream Synthesis

**Date**: [DATE]
**Streams analyzed**: [List]

---

## Overview

This analysis examines connections, patterns, and contradictions across [X] research streams:
[Brief description of each stream's focus]

---

## Shared Concepts

[From Step 2A]

---

## Related Concepts

[From Step 2B]

---

## Unique Contributions

[From Step 2C]

---

## Contradictions & Tensions

[From Step 3]

---

## Integration Opportunities

[From Step 4]

---

## Meta-Insights

**What patterns emerge across all streams?**
[Higher-level observations]

**What does multi-perspective analysis reveal that single-discipline work would miss?**
[Value of integration]

**Where does the research question need refinement?**
[Based on what you've learned]
```

### Step 6: Create Integration Map

Create visual/text map of connections:

`.researchkit/synthesis/integration-map.md`:

```markdown
# Integration Map

```
[Stream-1: Psychology]
    ├─ Concept A ──┐
    ├─ Concept B   │
    └─ Concept C ──┼── Integration Opportunity 1
                   │       ↓
[Stream-2: Finance]       Framework: [Name]
    ├─ Concept D ──┘
    ├─ Concept E ──┐
    └─ Concept F   │
                   │
[Stream-3: Strategy]
    ├─ Concept G ──┼── Integration Opportunity 2
    ├─ Concept H ──┘
    └─ Concept I ────── Contradiction with Concept E
```

[Text-based or described relationships]
```

### Step 7: Identify Stories Supporting Cross-Stream Insights

Query story library for stories that illustrate cross-stream concepts:

```
Stories illustrating cross-stream insights:

- [[story-name-1]] - Shows [concept from stream-1] + [concept from stream-2]
- [[story-name-2]] - Illustrates contradiction between streams
- [[story-name-3]] - Example of integration working in practice
```

### Step 8: Suggest Framework Candidates

Based on integration opportunities:

```
✅ Cross-stream analysis complete

Key findings:
- Shared concepts: [X]
- Integration opportunities: [X]
- Contradictions documented: [X]

Suggested next steps:

1. **Develop frameworks** from integration opportunities:
   - [Integration 1] → Could become [Framework Name]
   - [Integration 2] → Could become [Framework Name]

   Use: /rk.frameworks to extract

2. **Capture more stories** for cross-stream concepts:
   - [Concept] needs vivid story
   - [Integration] needs illustrative example

3. **Refine questions** based on contradictions:
   - [Contradiction] suggests question variant: [New question]
```

## Cross-Stream Analysis Types

### Convergence Analysis
**Look for**: Where different disciplines reach similar conclusions
**Value**: Increases confidence in findings
**Output**: "Robust finding across disciplines"

### Divergence Analysis
**Look for**: Where disciplines disagree
**Value**: Reveals complexity, boundary conditions
**Output**: "Context-dependent - applies when X, not when Y"

### Complementarity Analysis
**Look for**: Where disciplines address different aspects
**Value**: Complete picture from multiple angles
**Output**: "Comprehensive framework integrating multiple perspectives"

### Emergence Analysis
**Look for**: Insights only visible from combining streams
**Value**: Novel frameworks not in single-discipline work
**Output**: "New framework synthesizing across disciplines"

## Guidelines

### For Identifying Connections

**Look for:**
- Same terminology used differently
- Different terminology for same concept
- Complementary explanations (one explains "what," other explains "how")
- Cause-effect chains across streams

**Don't force:**
- Connections that aren't really there
- False equivalencies (concepts that seem similar but aren't)
- Premature synthesis (some contradictions should remain)

### For Handling Contradictions

**Good contradictions to explore:**
- Different boundary conditions (both right in different contexts)
- Different levels of analysis (individual vs. organizational)
- Temporal differences (short-term vs. long-term)

**Mark as unresolved:**
- True theoretical disputes
- Insufficient evidence to determine
- Outside scope of current research

### For Integration

**Strong integration opportunities:**
- Fill gaps in each stream's explanation
- Create more complete framework
- Address practitioner needs better than single-stream

**Weak integration:**
- Just listing concepts from different streams
- No added value from combining
- Too complex for practical use

## Constitutional Alignment

If your constitution includes Multi-Perspective Analysis (common):

**This command enforces:**
- Explicit comparison across streams
- Documentation of contradictions (don't hide tensions)
- Integration when valuable (not just listing)

**Check:**
- Have you examined through at least 3 perspectives?
- Are contradictions documented honestly?
- Is synthesis grounded in evidence from multiple streams?

## File Locations

- Cross-stream analysis: `.researchkit/synthesis/cross-stream-analysis.md`
- Integration map: `.researchkit/synthesis/integration-map.md`
- Stream concepts: `.researchkit/streams/*/concepts.md`
- Contradictions: `.researchkit/synthesis/contradictions.md` (optional separate file)

## Important Notes

**On synthesis timing:**
- Don't synthesize too early (need sufficient research in each stream)
- Don't synthesize too late (miss integration opportunities)
- Re-run periodically as research progresses

**On complexity:**
- More streams = more complexity
- 3-5 streams is optimal
- Beyond 5, may need hierarchical organization

**On practitioner value:**
- Always ask: Does integration help decision-making?
- Academic interest ≠ practical value
- Some contradictions matter, others don't
