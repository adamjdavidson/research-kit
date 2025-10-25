# /rk.init - Initialize ResearchKit in Current Directory

You are helping the user initialize ResearchKit in their current directory.

## Context

ResearchKit is a research workflow tool. Users clone the ResearchKit repository once, then can use `/rk.*` commands in ANY directory on their computer.

This command creates a `.researchkit/` folder in the current directory, establishing it as a ResearchKit research project.

## Your Task

### Step 1: Check if Already Initialized

Check if `.researchkit/` folder exists in current directory.

**If it exists:**
- Tell user: "This directory is already initialized as a ResearchKit project."
- Ask: "Would you like to reinitialize (this will preserve existing data but update structure)?"
- If no, exit

### Step 2: Get Project Information

Ask the user:
1. **"What's the name of this research project?"**
   - This becomes the project title
   - Example: "Corporate AI Transformation", "Organizational Culture Change"

2. **"Brief description (optional):"**
   - One-line summary of what this research is about

### Step 3: Create Directory Structure

Create `.researchkit/` folder with this structure:

```
.researchkit/
├── constitution.md          # Research principles (created by /rk.constitution)
├── questions/               # Question evolution
├── research-paths/          # Research traditions
│   └── paths/
├── documents/               # Collected sources
│   ├── foundational/
│   ├── recent-reviews/
│   └── supplementary/
├── stories/                 # Story library
│   ├── meta/
│   └── by-concept/
├── streams/                 # Research streams
├── synthesis/               # Frameworks
└── writing/                 # Drafts
    └── drafts/
```

### Step 4: Create Initial Files

**Create `.researchkit/README.md`:**

```markdown
# [PROJECT_NAME]

**Initialized**: [DATE]
**Status**: Setup

---

## About This Project

[DESCRIPTION or "Add project description here"]

---

## ResearchKit Structure

This directory is a ResearchKit research project. The `.researchkit/` folder contains:

- `constitution.md` - Research methodology principles
- `questions/` - Research question evolution
- `research-paths/` - Literature and traditions
- `documents/` - Collected PDFs and sources
- `stories/` - Narrative evidence library
- `streams/` - Multi-disciplinary research
- `synthesis/` - Extracted frameworks
- `writing/` - Drafts and outputs

---

## Getting Started

1. **Define research principles**: `/rk.constitution`
2. **Articulate your question**: `/rk.question`
3. **Identify research paths**: `/rk.identify-paths`
4. **Create research streams**: `/rk.create-stream [discipline]`
5. **Capture stories**: `/rk.capture-story`
6. **Find stories**: `/rk.find-stories --concept [name]`

---

## Status Checklist

- [ ] Constitution created
- [ ] Research question defined
- [ ] Research paths identified
- [ ] Research streams active
- [ ] Stories captured
- [ ] Frameworks extracted
- [ ] Writing begun
```

**Create `.researchkit/stories/index.md`:**

```markdown
# Story Library Index

**Project**: [PROJECT_NAME]
**Created**: [DATE]

---

## By Vividness Rating

### Highly Vivid (8-10) - Lead story candidates
[Stories will appear here as you capture them with /rk.capture-story]

### Moderately Vivid (5-7) - Supporting examples
[Stories will appear here]

### Lower Vividness (1-4) - Background/reference
[Stories will appear here]

---

## By Concept/Framework

[Concepts will appear here as you extract them]

---

## By Emotional Tone

### Tragic/Cautionary
[Stories will appear here]

### Hopeful/Transformative
[Stories will appear here]

### Ironic/Surprising
[Stories will appear here]

### Inspiring/Aspirational
[Stories will appear here]

---

## Quick Stats

- **Total stories**: 0
- **High vividness (8+)**: 0

---

## Usage

- Capture stories: `/rk.capture-story`
- Find stories: `/rk.find-stories --concept [name]`
```

**Create `.researchkit/documents/download-queue.md`:**

```markdown
# Document Download Queue

**Project**: [PROJECT_NAME]

---

## Documents Needing Manual Download

[Items will appear here when /rk.identify-paths finds sources]

Format:
- [ ] **Author (Year)** - "Title"
  - Source: [Journal/Publisher]
  - Reason: [Behind paywall / Library access needed / etc.]
  - Priority: [High / Medium / Low]
  - Save to: [foundational / recent-reviews / supplementary]

---

## Downloaded Documents

[Move items here once downloaded]

---

## Unable to Obtain

[Items that cannot be accessed]
```

**Create `.gitignore` in project root (if doesn't exist):**

```
# ResearchKit - Downloaded documents
.researchkit/documents/foundational/*.pdf
.researchkit/documents/recent-reviews/*.pdf
.researchkit/documents/supplementary/*.pdf

# But keep the structure and markdown files
!.researchkit/documents/download-queue.md
!.researchkit/documents/**/.gitkeep

# Allow text exports
!.researchkit/documents/**/*.md
!.researchkit/documents/**/*.txt

# Standard ignores
.DS_Store
*.log
.env
```

### Step 5: Create .gitkeep Files

Create empty `.gitkeep` files in empty directories:
- `.researchkit/questions/.gitkeep`
- `.researchkit/research-paths/paths/.gitkeep`
- `.researchkit/documents/foundational/.gitkeep`
- `.researchkit/documents/recent-reviews/.gitkeep`
- `.researchkit/documents/supplementary/.gitkeep`
- `.researchkit/stories/meta/.gitkeep`
- `.researchkit/stories/by-concept/.gitkeep`
- `.researchkit/streams/.gitkeep`
- `.researchkit/synthesis/.gitkeep`
- `.researchkit/writing/drafts/.gitkeep`

### Step 6: Confirm Initialization

Tell the user:

```
✅ ResearchKit initialized in this directory!

Created: .researchkit/ folder with complete structure

Next steps:
1. Define your research principles: /rk.constitution
2. Define your research question: /rk.question

Documentation: .researchkit/README.md
```

## Important Guidelines

### Working Directory Context

ALL ResearchKit commands look for `.researchkit/` in:
1. Current directory
2. Parent directories (up to 3 levels)

This allows you to run commands from subdirectories.

### If User Has Git

If the current directory is a git repository, remind user:
"Note: .researchkit/ is a local folder. Add it to git to version control your research, or add to .gitignore to keep it private."

### Multiple Projects

Users can have multiple independent ResearchKit projects:
```
~/Corporate-Structure/.researchkit/
~/AI-Culture/.researchkit/
~/Org-Change/.researchkit/
```

Each is completely separate.

## File Locations

All files created in: `.researchkit/` in current directory
