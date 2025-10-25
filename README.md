# ResearchKit 🔬

> Systematic framework for rigorous, multi-disciplinary research with Claude Code

ResearchKit helps you conduct deep, structured research. It guides you step-by-step through refining vague questions, organizing research across multiple disciplines, capturing vivid stories, and creating actionable frameworks.

**Perfect for**: Researchers, consultants, writers, students - anyone doing serious research, even if you've never used a command line before.

---

## Before You Start

### What You Need

1. **Claude Code** - You need Claude Code installed on your computer
   - Don't have it? Visit [claude.com](https://claude.com) to get Claude Code
   - Claude Code is where you'll do all your research

2. **10 minutes** - Installation takes about 5 minutes, plus 5 minutes to try your first command

3. **Any computer** - Works on Mac, Windows (with WSL), or Linux

### What is This?

ResearchKit adds 13 new commands to Claude Code that guide you through research. Instead of trying to remember how to do rigorous research, you just type a command like `/rk-question` and Claude guides you through refining your research question step-by-step.

**No programming knowledge required.** Just follow the instructions below, copy and paste the commands, and you're set.

---

## Installation (Step-by-Step)

### Step 1: Open Your Terminal

**What's a terminal?** It's a program that lets you type commands to your computer. Don't worry - we'll tell you exactly what to type.

**How to open it:**

**On Mac:**
1. Press `Command + Space` (this opens Spotlight search)
2. Type `terminal`
3. Press `Enter`
4. A window with black or white background will open - that's your terminal!

**On Windows:**
1. Press `Windows key + R`
2. Type `cmd`
3. Press `Enter`
4. A black window will open - that's your terminal!

**On Linux:**
1. Press `Ctrl + Alt + T`
2. A terminal window will open

### Step 2: Download ResearchKit

**Copy and paste this command into your terminal**, then press `Enter`:

```bash
git clone https://github.com/yourusername/research-kit.git
```

**What this does:** Downloads ResearchKit to your computer.

**What you'll see:** Text scrolling by showing files being downloaded. After a few seconds, you'll see your cursor again (a blinking line or prompt). That means it's done!

**Troubleshooting:**
- **"git: command not found"**: You need to install Git first. On Mac, a window will pop up asking if you want to install developer tools - click "Install" and wait a few minutes. On Windows, visit [git-scm.com](https://git-scm.com) to download Git. Then try the command again.

### Step 3: Navigate to the ResearchKit Folder

**Copy and paste this command**, then press `Enter`:

```bash
cd research-kit
```

**What this does:** Moves you into the ResearchKit folder you just downloaded. (Think of it like double-clicking a folder to open it, but in the terminal.)

**What you'll see:** Your prompt might change to show "research-kit" - that's good! It means you're in the right place.

### Step 4: Run the Installer

**Copy and paste this command**, then press `Enter`:

```bash
./install.sh
```

**What this does:** Installs ResearchKit on your computer. This copies all the research commands and templates to the right place so Claude Code can use them.

**What you'll see:** Friendly messages like:
```
==> Welcome to ResearchKit! 🔬

I'll set up ResearchKit on your computer - this takes about 1 minute.

I see you're on macOS - perfect!
```

The installer will:
- Set up your research workspace
- Install 6 professional templates
- Install 13 research commands
- Connect everything to Claude Code

After about 1 minute, you'll see:
```
==> All done! 🎉
```

**That's it! ResearchKit is installed.**

**Troubleshooting:**
- **"Permission denied"**: Run `chmod +x install.sh` first, then try `./install.sh` again
- **"Claude Code not found"**: The installer will still work! It installs ResearchKit but warns you to install Claude Code later. Just install Claude Code, then run `./install.sh` again.

---

## Your First Research Session

Now let's try using ResearchKit! Keep your terminal open from the installation steps above.

### Step 1: Create a Folder for Your Research

**In your terminal, type these commands** (press `Enter` after each one):

```bash
mkdir my-research-project
cd my-research-project
```

**What this does:**
- `mkdir my-research-project` creates a new folder called "my-research-project"
- `cd my-research-project` moves you into that folder

**What you'll see:** Your terminal prompt might change to show "my-research-project" - that means you're in your research folder.

### Step 2: Start Claude Code

**In your terminal, type:**

```bash
claude
```

**What this does:** Starts Claude Code in your current folder (my-research-project).

**What you'll see:** Claude Code will start up and you'll see a message like "Claude Code is ready" or similar. You can now chat with Claude and use special commands.

### Step 3: Initialize ResearchKit

**Now type this command to Claude:**

```
/rk-init
```

**What this does:** Sets up ResearchKit in your current folder, creating a place to store all your research.

**What happens:** I (Claude) will ask you:
- "What's the name of this research project?" (Type something like "Understanding AI adoption" or whatever you're researching)
- "Brief description (optional):" (Type a one-sentence description, or just press Enter to skip)

I then create a complete research folder structure for you in `.researchkit/`.

### Step 4: Define Your Research Constitution (IMPORTANT - Do This First!)

**Type this command:**

```
/rk-constitution
```

**What this does:** Creates your research "constitution" - the fundamental principles that will guide all your research.

**Why this matters:** Think of this like setting up the rules of the game before you play. Your constitution defines things like:
- "I will examine every question from at least 3 different perspectives"
- "I will cite evidence for every claim I make"
- "I will document contradictions instead of hiding them"

These principles ensure your research is rigorous. Every other ResearchKit command will check your work against these principles.

**What happens:** I will:
1. Explain what a research constitution is
2. Show you examples of good principles
3. Help you define 5-7 principles for your research
4. Save them to `constitution.md`

**Do this before anything else!** Your constitution is your research quality standard.

### Step 5: Refine Your Research Question

**Now type this command:**

```
/rk-question
```

**What this does:** Helps you refine a vague research question into something precise and answerable.

**Why do this after the constitution?** Because I'll use your constitutional principles to help refine your question. For example, if your constitution says "examine from 3+ perspectives," I'll make sure your refined questions engage multiple disciplines.

**What happens:** I will:
1. Ask you for your broad research question (like "What do we know about organizational change?")
2. Generate 3-5 refined versions of your question
3. Show you what each version emphasizes and what it takes for granted
4. Help you pick the best one
5. Check it against your constitutional principles
6. Save it to `questions/question-001.md`

**That's it!** You just did rigorous research question refinement - the foundation of good research.

### Step 6: When You're Done

To exit Claude Code, type:
```
/exit
```

or press `Ctrl+C` (works on Mac, Windows, and Linux).

---

## Optional: Setup Gemini for Large Documents

**Do you work with very large documents?** (100+ page PDFs, entire books, multiple long papers)

Claude has a context window limit - it can't handle documents that are too large. **Google's Gemini has a much larger context window** (up to 1 million tokens) and can handle these massive documents.

**You can add Gemini to ResearchKit** so Claude can send large documents to Gemini for analysis, then integrate those insights into your research.

**Example use case:**
- You find a 200-page foundational text
- You ask Claude to analyze it
- Claude uses Gemini to read and summarize the 200 pages
- You use those insights in your ResearchKit project

**Setup takes 10 minutes and is completely free** (no credit card required).

**➡️ See the [Gemini Setup Guide](.researchkit/docs/gemini-setup.md) for step-by-step instructions.**

**Skip this if:**
- You're just starting with ResearchKit (come back to this later)
- You don't work with very large documents
- You want to learn the basic workflow first

---

## What You Can Do Now

You now have 13 research commands available. **Here's what to do next:**

### If This Is Your First Time: Use the Complete Workflow

**Type this command:**
```
/rk-research
```

**What it does:** Walks you through the ENTIRE research process from start to finish - constitution, question, research, synthesis, frameworks, writing. **Use this if you're new to ResearchKit or want step-by-step guidance.**

This is the easiest way to learn ResearchKit because I guide you through every single step.

### If You Already Know ResearchKit: Use Individual Commands

Once you're comfortable with the workflow, you can use commands individually. **Use them in this order:**

**1. Every New Project - Do These First (In Order):**
- `/rk-init` - Set up research folder (do once per project)
- `/rk-constitution` - Define your principles (do once per project)
- `/rk-question` - Refine your question (do once, or iterate as needed)

**2. Research Phase - Do These Next (In Order):**
- `/rk-identify-paths` - Find 3-5 research perspectives (do once)
- `/rk-create-stream` - Research one perspective deeply (repeat for each perspective)
- `/rk-collect-documents` - Organize sources (do throughout research)
- `/rk-capture-story` - Save vivid stories (do whenever you find one)

**3. Synthesis Phase - Do These After Research (In Order):**
- `/rk-cross-stream` - Combine insights from all perspectives (do once)
- `/rk-frameworks` - Extract actionable tools (do once, creates 1-3 frameworks)
- `/rk-write` - Generate final output (do once or iterate)

**4. Utility Commands - Use Anytime:**
- `/rk-validate` - Check if ResearchKit is healthy (if something breaks)
- `/rk-find-stories` - Search your story library (when writing)

**Bottom line:** Start with `/rk-research` for your first project. After you understand the flow, use individual commands.

---

## How ResearchKit Works

### The Research Workflow (Follow This Order!)

ResearchKit guides you through research like an expert methodology coach. **Do the steps in this order** - each one builds on the previous:

**1. Define your principles** (`/rk-constitution`) - **START HERE**

**Why first?** Your constitution sets the quality standards for everything else. It's like setting the rules before playing a game.

**What it does:** You define 5-7 principles like "examine from 3+ perspectives" or "cite all claims." Every other command checks your work against these.

---

**2. Refine your question** (`/rk-question`) - **DO THIS SECOND**

**Why after constitution?** Because I use your principles to refine your question. If your constitution says "multi-perspective," I'll make sure your question engages multiple fields.

**What it does:** Turns "How do companies adopt AI?" into precise questions like "What organizational structures enable rapid AI adoption?" or "How do employee mindsets shape AI adoption success?"

---

**3. Identify perspectives** (`/rk-identify-paths`) - **DO THIS THIRD**

**Why after question?** Because now we know what you're asking, so we can identify which research traditions (psychology, economics, sociology, etc.) study this topic.

**What it does:** Lists 3-5 research perspectives that study your question, with their core concepts, key scholars, and what each perspective sees (and misses).

---

**4. Research each perspective** (`/rk-create-stream`) - **REPEAT FOR EACH PERSPECTIVE**

**Why after identifying paths?** Because now you know which perspectives to research - do one deep dive per perspective.

**What it does:** Guides you through researching one tradition thoroughly: reading key works, documenting evidence, noting contradictions.

---

**5. Capture stories** (`/rk-capture-story`) - **DO THIS THROUGHOUT**

**Why during research?** When you find a compelling story (like "Kodak invented the digital camera in 1975 but buried it"), capture it immediately with full vivid details. It's much harder to reconstruct later.

**What it does:** Saves stories with names, dates, quotes, and emotional tone. These make your frameworks memorable when you write.

---

**6. Synthesize** (`/rk-cross-stream`) - **AFTER RESEARCHING ALL PERSPECTIVES**

**Why after streams?** Because now you've researched 3+ perspectives and can see where they agree, contradict, and complement each other.

**What it does:** Identifies convergence (where traditions agree), divergence (contradictions), and complementarity (how they fill each other's gaps).

---

**7. Extract frameworks** (`/rk-frameworks`) - **AFTER SYNTHESIS**

**Why after synthesis?** Because frameworks come from seeing patterns across multiple perspectives - not from a single viewpoint.

**What it does:** Creates actionable tools from your research, with clear components, boundary conditions, and application steps.

---

**8. Write** (`/rk-write`) - **DO THIS LAST**

**Why last?** Because now you have refined questions, multi-perspective research, vivid stories, and actionable frameworks - everything you need to write compellingly.

**What it does:** Generates essays, reports, or guides that integrate your evidence, stories, and frameworks.

---

**Each command asks you questions and guides you through filling out professional templates.** Just answer the questions - ResearchKit handles the methodology.

### What Gets Created

When you use ResearchKit, it creates files in your project folder:

```
Your Research Folder/
└── .researchkit/              (Your research workspace)
    ├── constitution.md         (Your research principles)
    ├── questions/              (Question refinements)
    ├── research-paths/         (Research perspectives)
    ├── documents/              (Your sources, organized)
    ├── stories/                (Vivid examples and cases)
    ├── streams/                (Research from each perspective)
    ├── synthesis/              (Combined insights)
    └── writing/                (Your drafts and final pieces)
```

**All your research in one organized place.**

---

## Examples: What This Actually Looks Like

### Example 1: Your First Research Project (RECOMMENDED)

**This is what most people should do first.** It teaches you the complete ResearchKit workflow.

**You type:**
```
/rk-research
```

**What happens:** I (Claude) guide you through 9 steps:

1. **Naming your project** - I ask what you're researching
2. **Defining research principles** - I help you create 5-7 quality standards
3. **Refining your question** - I turn "How do companies adopt AI?" into precise questions like:
   - "What organizational structures enable rapid AI adoption?"
   - "How do employee mindsets shape AI adoption success?"
   - "What economic conditions predict AI investment?"
4. **Identifying perspectives** - I list 3-5 research traditions (psychology, economics, sociology, etc.)
5. **Researching each perspective** - I guide you through reading and documenting evidence (repeat for each)
6. **Capturing stories** - I help you save vivid examples with names, dates, quotes
7. **Synthesizing insights** - I show where perspectives agree, contradict, and complement each other
8. **Creating frameworks** - I help you extract 1-3 actionable tools
9. **Writing your findings** - I generate professional essays, reports, or guides

**Time investment:** 10-20 hours for a complete research project (spread over days/weeks).

**Output:** Complete research with refined questions, multi-perspective evidence, vivid stories, actionable frameworks, and professional writing.

**When to use this:** Your first time, or any time you want complete guidance.

### Example 2: Just Refining a Question (For Advanced Users)

**Only do this if you already know ResearchKit** and just need to refine a question quickly.

**You type:**
```
/rk-question
```

**What happens:**

I ask: "What's your broad research question?"

You answer: "How do companies adopt AI?"

I generate 3-5 refined versions:
- Q1: "What organizational structures enable rapid AI adoption?" (focuses on design)
- Q2: "How do employee mindsets shape AI adoption success?" (focuses on psychology)
- Q3: "What economic conditions predict AI investment?" (focuses on economics)

You pick the one that matches what you care about.

I save it to `questions/question-001.md`.

**Time investment:** 5-10 minutes.

**When to use this:** When you already have a constitution and just need question refinement.

**Start with Example 1 (/rk-research) for your first project!** It teaches you the whole methodology.

---

## Getting Help

### Something Not Working?

1. **First, try this command:**
   ```
   /rk-validate
   ```
   This checks if ResearchKit is healthy and auto-fixes most issues.

2. **Check our guides:**
   - **[Installation Guide](.researchkit/docs/installation-guide.md)** - Detailed install help
   - **[Troubleshooting Guide](.researchkit/docs/troubleshooting.md)** - Common problems and solutions

3. **Still stuck?**
   - [Report an issue](https://github.com/yourusername/research-kit/issues)
   - [Ask in Discussions](https://github.com/yourusername/research-kit/discussions)

### Want to Learn More?

- **[Complete Research Workflow Guide](.researchkit/docs/getting-started.md)** - Understand the full research process
- **[Commands Reference](.researchkit/docs/commands-reference.md)** - All 13 commands explained in detail
- **[Templates Reference](.researchkit/docs/templates-reference.md)** - What each template does
- **[Gemini Setup Guide](.researchkit/docs/gemini-setup.md)** - Add Gemini for large documents (advanced/optional)

### For Technical Users

- **[Architecture Guide](.researchkit/docs/architecture.md)** - How ResearchKit works under the hood
- **[Contributing Guide](.researchkit/docs/contributing.md)** - Extend or customize ResearchKit

---

## Why ResearchKit?

### For Researchers

- **Systematic methodology** - Never wonder "what do I do next?"
- **Multi-disciplinary by default** - See your topic from 3+ perspectives
- **Story-driven** - Pair abstract concepts with vivid examples
- **Evidence-based** - Track all sources automatically

### For Practitioners

- **Actionable frameworks** - Not just theory, practical tools
- **Accessible outputs** - Write for your audience, not academics
- **Vivid communication** - Stories make concepts memorable

### For Beginners

- **Guided every step** - Claude asks questions, you answer
- **Professional templates** - See what good research looks like
- **No prior experience needed** - Learn rigorous methods as you work
- **Built-in quality checks** - Validate against your principles

---

## Core Principles

ResearchKit is built on these research principles:

1. **Questions First** - Start by refining what you're actually asking
2. **Multi-Perspective** - Examine through 3+ disciplinary lenses
3. **Story + Concept** - Pair abstract ideas with vivid narratives
4. **Contradiction Awareness** - Document tensions, don't hide them
5. **Practitioner Ready** - Extract actionable frameworks
6. **Evidence-Based** - All claims cited and traceable

These aren't just ideals - every ResearchKit command enforces them.

---

## Updates

Keep ResearchKit up to date:

**Option 1: Quick Update (Recommended)**

Open your terminal and type:
```bash
cd research-kit
git pull
./install.sh
```

**Option 2: Using the Built-in Updater**

In Claude Code, type:
```
/rk-validate
```

This checks for issues and can guide you to update.

---

## Next Steps

1. **Try it right now**: Open Claude Code, type `/rk-init`, and start your first research project
2. **Read the workflow guide**: [Getting Started Guide](.researchkit/docs/getting-started.md) shows you the complete research process
3. **Explore commands**: Try `/rk-question` to refine a research question
4. **Join the community**: [GitHub Discussions](https://github.com/yourusername/research-kit/discussions) to share your research

---

## License

[Your license here]

---

**Questions? Stuck? Excited?** We'd love to hear from you in [Discussions](https://github.com/yourusername/research-kit/discussions)!
