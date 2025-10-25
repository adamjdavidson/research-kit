# Getting Started with ResearchKit

Complete guide to your first research project with ResearchKit.

---

## What is ResearchKit?

ResearchKit is a systematic framework for conducting rigorous, multi-disciplinary research. It helps you:

- **Refine vague questions** into precise, answerable research questions
- **Research multiple perspectives** by examining topics through 3+ disciplinary lenses
- **Capture vivid stories** that make abstract concepts memorable
- **Extract actionable frameworks** that practitioners can actually use
- **Write compellingly** by integrating evidence and narrative

**Perfect for**: Researchers, consultants, writers, students doing serious research.

---

## Prerequisites

Before starting, you need:

1. **ResearchKit installed** - See the [Installation Guide](installation-guide.md)
2. **Claude Code running** - Type `claude` in your terminal to start it
3. **A research topic in mind** - Even a vague one is fine!

**Don't have these?** Go back to the main [README](../../README.md) for installation instructions.

---

## Your First Research Project

This guide walks you through a complete research project from start to finish.

**Time investment**: 10-20 hours (spread over days or weeks)

**What you'll create**:
- Refined research question
- Multi-perspective research with evidence
- Library of vivid stories
- 1-3 actionable frameworks
- Professional written output

---

## Step 1: Create a Project Folder

**What's a project folder?** A directory on your computer where all your research will live.

**In your terminal, type these commands** (press `Enter` after each):

```bash
mkdir my-research-project
cd my-research-project
claude
```

**What this does:**
- `mkdir my-research-project` creates a new folder called "my-research-project"
- `cd my-research-project` moves you into that folder
- `claude` starts Claude Code in this folder

**What you'll see:** Claude Code starts and you can now chat and use commands.

---

## Step 2: Initialize ResearchKit (DO THIS FIRST!)

**In Claude Code, type:**

```
/rk-init
```

**What this does:** Sets up ResearchKit in your current folder, creating a `.researchkit/` directory with this structure:

```
my-research-project/
└── .researchkit/
    ├── constitution.md         (Your research principles - created next)
    ├── questions/              (Question refinements)
    ├── research-paths/         (Research perspectives)
    ├── documents/              (Your sources)
    ├── stories/                (Vivid examples)
    ├── streams/                (Research from each perspective)
    ├── synthesis/              (Combined insights)
    └── writing/                (Your drafts)
```

**What I'll ask you:**
- "What's the name of this research project?" (Type something like "Understanding AI adoption")
- "Brief description (optional):" (Type a one-sentence description, or press Enter to skip)

**That's it!** Your research workspace is ready.

---

## Step 3: Define Your Constitution (CRITICAL - DO THIS BEFORE ANYTHING ELSE!)

**Type this command:**

```
/rk-constitution
```

**What this does:** Creates your research "constitution" - the fundamental principles that guide all your research.

**Why this is critical:** Your constitution is like the rules of the game. It defines things like:
- "I will examine every question from at least 3 different perspectives"
- "I will cite evidence for every claim I make"
- "I will document contradictions instead of hiding them"

Every other ResearchKit command will check your work against these principles.

**What I'll do:**
1. Explain what a research constitution is
2. Show you examples of good principles
3. Help you define 5-7 principles for your research
4. Save them to `constitution.md`

**Example principles you might define:**
- **Multi-Perspective Analysis** - Examine through 3+ disciplinary lenses
- **Evidence-Based Reasoning** - All claims must be cited
- **Contradiction Awareness** - Document tensions, don't hide them
- **Framework Extraction** - Produce actionable insights
- **Practitioner Readiness** - Accessible to non-experts
- **Narrative Evidence** - Pair concepts with vivid stories

**Output:** `.researchkit/constitution.md` with your principles

**DO THIS BEFORE STEP 4!** Your constitution must exist before you refine your question.

---

## Step 4: Refine Your Research Question

**Type this command:**

```
/rk-question
```

**Why do this after the constitution?** Because I'll use your constitutional principles to help refine your question. For example, if your constitution says "examine from 3+ perspectives," I'll make sure your refined questions engage multiple disciplines.

**What this does:** Transforms your vague question into precise, answerable questions.

**What I'll ask you:** "What's your broad research question?"

**You might say:** "How do companies adopt AI?"

**I'll generate 3-5 refined versions** like:
- **Q1**: "What organizational structures enable rapid AI adoption?" (focuses on design)
- **Q2**: "How do employee mindsets shape AI adoption success?" (focuses on psychology)
- **Q3**: "What economic conditions predict AI investment?" (focuses on economics)

**You'll pick the one** that matches what you care about most.

**What I'll show you** for each refined question:
- What it emphasizes (the focus)
- What it takes for granted (hidden assumptions)
- What disciplines study this (who to read)

**Output:** `.researchkit/questions/question-001.md` with your refined question

**Why this matters:** A well-refined question shapes everything that follows - what to research, what sources to read, what frameworks to extract.

---

## Step 5: Identify Research Perspectives

**Type this command:**

```
/rk-identify-paths
```

**Why do this after refining your question?** Because now we know what you're asking, so we can identify which research traditions (psychology, economics, sociology, etc.) study this topic.

**What this does:** Identifies 3-5 research perspectives (also called "traditions" or "streams") for your question.

**For each perspective, I'll tell you:**
- Core concepts they use
- Key scholars to read
- Typical methods they use
- What this perspective sees (their insights)
- What this perspective misses (their blind spots)

**Example for "How do companies adopt AI?":**

**Perspective 1: Organizational Psychology**
- Core concepts: Identity, sensemaking, motivation
- Key scholars: Weick, Dutton, Pratt
- Sees: How people experience AI changes
- Misses: Economic and structural factors

**Perspective 2: Strategic Management**
- Core concepts: Resources, capabilities, competitive advantage
- Key scholars: Teece, Barney, Porter
- Sees: How AI creates competitive advantage
- Misses: Individual psychological factors

**Perspective 3: Innovation Studies**
- Core concepts: Diffusion, adoption, disruption
- Key scholars: Rogers, Christensen
- Sees: How AI spreads through industries
- Misses: Organizational culture factors

**Output:** `.researchkit/research-paths/paths/path-[name].md` for each perspective

**Why this matters:** Multi-disciplinary research prevents single-perspective bias. You'll see your topic from multiple angles.

---

## Step 6: Research Each Perspective (DO ONE AT A TIME)

**Type this command:**

```
/rk-create-stream
```

**Why do this after identifying perspectives?** Because now you know which perspectives to research - do one deep dive per perspective.

**What this does:** Guides you through researching one tradition thoroughly.

**I'll ask you:**
- "Which research path are you investigating?" (Pick from the ones you identified)
- "What are the 3-5 key concepts?" (From your reading)
- "What evidence did you find?" (Document findings)
- "What contradictions emerged?" (Note tensions)

**How to research a perspective:**
1. Read the key scholars identified in Step 5
2. Take notes on key concepts
3. Capture evidence (data, findings, arguments)
4. Note contradictions (where scholars disagree)
5. **Capture stories** as you find them (see Step 7)

**Output:** `.researchkit/streams/stream-[name].md` with your research

**Do this for each perspective** - Repeat `/rk-create-stream` for each of your 3-5 perspectives.

**Why this matters:** Deep research within each tradition ensures you understand that perspective fully before synthesizing.

---

## Step 7: Capture Stories (DO THIS THROUGHOUT RESEARCH!)

**Type this command whenever you find a compelling story:**

```
/rk-capture-story
```

**When to use this:** During research (Step 6), whenever you encounter a vivid, compelling story.

**What's a "story" in ResearchKit?** A story is a specific example with:
- **Names** - "Steve Sasson, age 24"
- **Dates** - "In 1975..."
- **Quotes** - "That's cute—but don't tell anyone about it"
- **Specific moments** - "When he showed executives the digital camera prototype..."
- **Consequences** - "Kodak missed the digital revolution"

**Why capture stories during research?** It's much easier to capture vivid details NOW (when you're reading about them) than later (when you're writing and trying to remember).

**What I'll guide you through:**
1. One-sentence summary
2. Full narrative with vivid detail
3. Key characters (names, roles)
4. Specific moments (dates, places, quotes)
5. Emotional tone
6. What concepts this illustrates
7. Source citation
8. Vividness rating (1-10)

**Output:**
- `.researchkit/stories/meta/[story-name].md` - Full story with metadata
- Updated `.researchkit/stories/index.md` - Searchable index

**Why this matters:** Stories make frameworks memorable. Good stories have high vividness (8+) and illustrate key concepts.

---

## Step 8: Collect Documents (DO THIS THROUGHOUT)

**Type this command as you find sources:**

```
/rk-collect-documents
```

**When to use this:** Throughout research as you find papers, books, reports worth tracking.

**What this does:** Organizes and tags your source documents.

**I'll ask you about:**
- Title, authors, year
- Document type (book, article, report)
- Category (foundational, recent-review, supplementary)
- Research path(s) it relates to
- Key concepts
- Summary

**Document categories:**
- **Foundational** - Seminal works, classic texts (e.g., Weick 1995)
- **Recent Reviews** - State-of-the-art summaries (e.g., 2023 meta-analysis)
- **Supplementary** - Supporting evidence (e.g., case studies)

**Output:**
- `.researchkit/documents/[category]/[author-year-title].md`
- Updated `.researchkit/documents/index.md`

**Why this matters:** Systematic document organization ensures you can find sources when writing.

---

## Step 9: Synthesize Across Perspectives (AFTER RESEARCHING ALL PERSPECTIVES)

**Type this command:**

```
/rk-cross-stream
```

**Why do this after research streams?** Because now you've researched 3+ perspectives and can see where they agree, contradict, and complement each other.

**What this does:** Combines insights from all your research perspectives.

**I'll identify:**
- **Convergence** - Where traditions agree (these insights are robust!)
- **Divergence** - Where they contradict (interesting tensions to explore)
- **Complementarity** - How they fill each other's gaps (synthesis opportunities)
- **Blind Spots** - What all traditions miss (research frontiers)
- **Emerging Insights** - New understanding from seeing patterns across perspectives

**Example synthesis:**
- **Convergence**: All three traditions agree AI adoption requires cultural change
- **Divergence**: Psychology emphasizes individual resistance, strategy emphasizes competitive advantage
- **Complementarity**: Psychology explains WHY resistance happens, strategy explains WHEN it's worth pushing through
- **Emerging Insight**: Successful AI adoption requires timing competitive moves (strategy) with cultural readiness (psychology)

**Output:** `.researchkit/synthesis/cross-stream-synthesis.md`

**Why this matters:** Multi-disciplinary synthesis produces insights no single tradition offers.

---

## Step 10: Extract Actionable Frameworks (AFTER SYNTHESIS)

**Type this command:**

```
/rk-frameworks
```

**Why do this after synthesis?** Because frameworks come from seeing patterns across multiple perspectives - not from a single viewpoint.

**What this does:** Creates actionable tools from your research.

**For each framework, I'll help you define:**
- **Core Insight** - What's the "aha moment"?
- **Problem** - What challenge does this address?
- **Components** - Key elements and how they interact
- **Boundary Conditions** - When to use / not use this
- **Application** - How to use it step-by-step
- **Stories** - Vivid illustrations (from your story library)
- **Evidence** - Supporting research (from your documents)

**Example framework: "Culture-Tech Fit Model"**
- **Core Insight**: AI adoption fails when there's a mismatch between AI capabilities and organizational culture
- **Problem**: Companies adopt AI without assessing cultural readiness
- **Components**: (1) Current culture profile, (2) AI capability requirements, (3) Gap assessment
- **When to use**: Before major AI adoption initiatives
- **When NOT to use**: When culture is already innovation-focused
- **Application**: 1) Assess current culture, 2) Map AI requirements, 3) Identify gaps, 4) Sequence adoption to match culture evolution
- **Stories**: Kodak (mismatch), Microsoft (successful realignment)
- **Evidence**: Organizational psychology literature, strategy case studies

**Output:** `.researchkit/synthesis/frameworks/framework-[name].md`

**Why this matters:** Frameworks transform research into practitioner-ready tools.

---

## Step 11: Write (DO THIS LAST)

**Type this command:**

```
/rk-write
```

**Why do this last?** Because now you have refined questions, multi-perspective research, vivid stories, and actionable frameworks - everything you need to write compellingly.

**What this does:** Generates professional writing that integrates your research.

**I'll help you choose:**
- **Writing format** - Essay, report, guide, white paper
- **Target audience** - Academics, practitioners, general public
- **Tone** - Formal, conversational, narrative

**I'll then:**
1. Identify relevant frameworks (from your frameworks)
2. Find vivid stories (high-vividness 8+ from your story library)
3. Propose narrative structure
4. Generate outline
5. Draft sections with evidence, stories, and frameworks integrated

**Example structure for practitioner essay:**
1. **Hook**: Lead with Kodak story (grab attention with irony)
2. **Framework**: Explain Culture-Tech Fit Model
3. **Contrast**: Microsoft transformation (shows alternative)
4. **Application**: How practitioners can use this framework
5. **Conclusion**: Actionable takeaways

**Output:** `.researchkit/writing/draft-[title].md`

**Why this matters:** Writing is where rigorous research becomes compelling communication.

---

## The Complete Workflow (Summary)

If you follow this guide, you'll do these steps **in this order**:

1. **Create project folder** and run `/rk-init`
2. **Define your constitution** with `/rk-constitution` ← **DO FIRST!**
3. **Refine your question** with `/rk-question` ← **DO SECOND!**
4. **Identify perspectives** with `/rk-identify-paths` ← **DO THIRD!**
5. **Research each perspective** with `/rk-create-stream` (repeat for each) ← **DO FOURTH!**
6. **Capture stories** with `/rk-capture-story` (throughout research) ← **DO DURING STEP 5!**
7. **Collect documents** with `/rk-collect-documents` (throughout research) ← **DO DURING STEP 5!**
8. **Synthesize** with `/rk-cross-stream` ← **AFTER ALL PERSPECTIVES RESEARCHED!**
9. **Extract frameworks** with `/rk-frameworks` ← **AFTER SYNTHESIS!**
10. **Write** with `/rk-write` ← **DO LAST!**

**Why this order matters:** Each step builds on the previous. Your constitution guides question refinement. Your question guides perspective identification. Perspectives guide research. Research enables synthesis. Synthesis enables frameworks. Frameworks enable writing.

---

## Alternative: Use the Complete Workflow Command

**Don't want to remember all these steps?** Use the complete workflow command:

```
/rk-research
```

**What it does:** Walks you through ALL the steps above, from constitution to writing, with guidance at each stage.

**When to use `/rk-research`:**
- **First time using ResearchKit** (learn the workflow)
- **Want structured guidance** (don't want to remember steps)
- **Complex multi-disciplinary research** (benefit from structure)

**When to use individual commands:**
- **Already familiar with workflow** (faster)
- **Just need specific steps** (e.g., just refine a question)
- **Iterating on existing research** (e.g., adding another perspective)

**Recommendation for beginners:** Start with `/rk-research` for your first project. After you understand the flow, use individual commands.

---

## Tips for Success

### For Question Refinement
- Start broad ("How do companies change?")
- Refine iteratively (use `/rk-question` multiple times)
- Consider your audience (practitioners need different questions than academics)
- Test against "so what?" (why does this matter?)

### For Story Capture
- **Capture immediately** - Don't wait until writing
- **Names, dates, quotes** - These make stories vivid
- **Rate honestly** - 8+ vividness stories are lead candidates
- **Tag liberally** - A story can illustrate multiple concepts

### For Multi-Perspective Research
- **One perspective at a time** - Deep beats shallow
- **Document contradictions** - Note where perspectives disagree
- **Look for patterns** - What concepts appear across perspectives?
- **Synthesize AFTER, not during** - Finish streams before synthesizing

### For Framework Extraction
- **Boundary conditions are critical** - Always specify when NOT to use
- **Pair abstract with concrete** - Every concept needs a story
- **Include diagnostics** - Give practitioners questions to ask
- **Test usability** - Can someone actually use this?

### For Writing
- **Query story library first** - Find 8+ vividness stories
- **Lead with narrative when possible** - Stories engage readers
- **Explain before applying** - Introduce framework before using it
- **End with action** - What should readers do?

---

## Common Questions

### "Can I skip the constitution?"

**No.** The constitution is the foundation. Every other command validates against it. Skipping it means you have no quality standards.

### "Can I refine my question before creating a constitution?"

**No.** Your constitution guides question refinement. If your constitution says "multi-perspective," I'll make sure your question engages multiple disciplines.

### "How many perspectives do I need?"

**At least 3.** Complex topics require multiple disciplinary lenses. Single-perspective research misses important insights.

### "When should I capture stories?"

**During research, not during writing.** It's much easier to capture vivid details when you're reading about them than trying to reconstruct later.

### "Can I skip synthesis and go straight to frameworks?"

**No.** Frameworks come from synthesis. You need to see patterns across perspectives before extracting tools.

### "How long does a research project take?"

**10-20 hours** for a complete project (spread over days or weeks). Quick projects might be 5 hours. Deep projects might be 40+ hours.

### "What if I have documents that are too large for Claude?"

**Use Gemini!** Google's Gemini has a much larger context window (up to 1 million tokens) and can handle 100+ page documents, entire books, etc.

**You can add Gemini to ResearchKit** (takes 10 minutes, completely free) so Claude can send large documents to Gemini for analysis.

**See the [Gemini Setup Guide](gemini-setup.md)** for step-by-step instructions.

---

## Troubleshooting

### "Commands aren't working"

Run the validator:
```
/rk-validate
```

This checks if ResearchKit is healthy and auto-fixes most issues.

### "I'm lost in the workflow"

Use the complete workflow command:
```
/rk-research
```

This guides you step-by-step through the entire process.

### "I need more help"

- **[Commands Reference](commands-reference.md)** - Detailed command documentation
- **[Templates Reference](templates-reference.md)** - What each template does
- **[Troubleshooting](troubleshooting.md)** - Common problems and solutions

---

## Next Steps

1. **Create your project folder** - `mkdir my-research-project && cd my-research-project`
2. **Start Claude Code** - `claude`
3. **Initialize ResearchKit** - `/rk-init`
4. **Define your constitution** - `/rk-constitution`
5. **Start researching** - `/rk-question`

**Or use the complete workflow:**
```
/rk-research
```

---

**Happy researching!** 🔬

For more details:
- **[Commands Reference](commands-reference.md)** - All 13 commands explained
- **[Templates Reference](templates-reference.md)** - All 6 templates explained
- **[Architecture](architecture.md)** - How ResearchKit works
- **[Troubleshooting](troubleshooting.md)** - Common issues and solutions
