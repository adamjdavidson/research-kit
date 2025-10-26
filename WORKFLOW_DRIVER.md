# Workflow Driver Documentation

## What is the Workflow Driver?

The Workflow Driver is an automated guide that walks you through ResearchKit's 10-step research methodology. Instead of trying to remember which command to use next or what step you're on, just run `./workflow-driver.sh` and it tells you exactly what to do.

**Key benefits:**
- ✅ No need to memorize the workflow steps
- ✅ Never lose your place in the research process
- ✅ Built-in progress tracking
- ✅ Clear guidance on what each step accomplishes
- ✅ Can stop and resume anytime

---

## Quick Start

```bash
# In any research project directory:
./workflow-driver.sh
```

That's it! The driver will:
1. Show you which step you're on (1-10)
2. Display clear instructions for that step
3. Tell you which ResearchKit command to run
4. Wait for you to complete the step
5. Mark it complete when you press ENTER
6. Tell you to run the driver again for the next step

---

## The 10-Step Workflow

1. **Define Research Question** (`/rk-question`)
   - Turn vague ideas into clear, answerable questions

2. **Develop Search Strategy** (`/rk-search-strategy`)
   - Plan where to look and what to search for

3. **Execute Initial Searches** (`/rk-search`)
   - Run systematic searches across sources

4. **Deep Read Key Sources** (`/rk-read`)
   - Extract insights from top sources

5. **Capture Vivid Stories** (`/rk-story`)
   - Find concrete examples and case studies

6. **Synthesize Findings** (`/rk-synthesize`)
   - Connect insights across disciplines

7. **Build Framework** (`/rk-framework`)
   - Create actionable principles/guidelines

8. **Test Framework** (`/rk-test`)
   - Validate against real and edge cases

9. **Identify Gaps** (`/rk-gaps`)
   - Find what still needs research

10. **Create Final Deliverable** (`/rk-deliver`)
    - Package findings for your audience

---

## How Progress Tracking Works

The driver creates a hidden file `.workflow-state.json` that tracks:
- Which step you're currently on
- Which steps you've completed
- When you started the research
- When you last updated progress

**This means:**
- You can close your terminal and come back later
- Progress persists across sessions
- You can see your completion history

---

## Usage Examples

### Starting a New Research Project

```bash
cd ~/my-research-project
./workflow-driver.sh
```

Output:
```
╔═══════════════════════════════════════════════════════════════╗
║                  RESEARCHKIT WORKFLOW DRIVER                   ║
║         Step-by-Step Guidance Through Research Process         ║
╚═══════════════════════════════════════════════════════════════╝

STANDARD RESEARCH WORKFLOW:
 1. 🎯 Define Research Question     (/rk-question)
 2. 🔍 Develop Search Strategy      (/rk-search-strategy)
 ...

Current Progress: Step 1 of 10

═══════════════════════════════════════════════════════════════
STEP 1: DEFINE RESEARCH QUESTION
═══════════════════════════════════════════════════════════════

COMMAND TO RUN:
    /rk-question

...

Follow the instructions above, then press ENTER when complete.
```

### Resuming After a Break

Just run the driver again:
```bash
./workflow-driver.sh
```

It automatically picks up where you left off:
```
Current Progress: Step 4 of 10

═══════════════════════════════════════════════════════════════
STEP 4: DEEP READ KEY SOURCES
...
```

### Checking Your Progress

```bash
cat .workflow-state.json
```

Output:
```json
{
  "current_step": 4,
  "completed_steps": [1, 2, 3],
  "workflow_name": "ResearchKit Standard Research",
  "started": "2025-10-25T15:30:00Z",
  "last_updated": "2025-10-25T17:45:00Z"
}
```

### Starting Over

```bash
rm .workflow-state.json
./workflow-driver.sh
```

This resets to Step 1.

---

## Advanced Usage

### Skipping Steps

If you need to skip a step (not recommended but sometimes necessary):

1. Press `Ctrl+C` when the driver is waiting
2. Manually edit `.workflow-state.json`:
   ```json
   {
     "current_step": 5,  // Change this number
     "completed_steps": [1, 2, 3, 4],  // Add the skipped step
     ...
   }
   ```
3. Run `./workflow-driver.sh` again

### Custom Workflows

You can customize the workflow steps by editing `workflow-driver.sh`. Look for the `generate_prompt()` function and modify the instructions for each step.

### Running in Different Directories

By default, the driver looks for `.workflow-state.json` in the current directory. To use a different location:

```bash
export WORKFLOW_DIR=/path/to/research/project
./workflow-driver.sh
```

---

## Installation

### Method 1: Included with ResearchKit

If you installed ResearchKit using `install.sh`, the workflow driver is already available. Just copy it to your research project:

```bash
cp /path/to/research-kit/workflow-driver.sh ~/my-research-project/
cd ~/my-research-project
./workflow-driver.sh
```

### Method 2: Standalone Installation

Download just the workflow driver:

```bash
curl -O https://raw.githubusercontent.com/adamjdavidson/research-kit/main/workflow-driver.sh
chmod +x workflow-driver.sh
./workflow-driver.sh
```

---

## Troubleshooting

### "Permission denied" error

Make the script executable:
```bash
chmod +x workflow-driver.sh
```

### State file is corrupted

Reset it:
```bash
rm .workflow-state.json
```

### I want to go back to a previous step

Edit `.workflow-state.json` and change `"current_step"` to the step number you want.

### The driver shows "Step 11 of 10"

You've completed all steps! Either:
- Start a new project: `rm .workflow-state.json && ./workflow-driver.sh`
- Review your completed work in the project directory

---

## Design Philosophy

The Workflow Driver is designed around three principles:

1. **Lower cognitive load**: Don't make researchers remember process steps while doing deep thinking
2. **Gentle guidance**: Show what to do next without being prescriptive about how
3. **Transparent tracking**: Make progress visible without being intrusive

It's meant to feel like a helpful research assistant who keeps you organized without getting in the way.

---

## Contributing

Found a bug or have a suggestion? Please open an issue or PR at:
https://github.com/adamjdavidson/research-kit

Ideas for improvement:
- Custom workflow templates for different research types
- Integration with project management tools
- Automatic generation of progress reports
- Branching workflows (e.g., "if qualitative, go to step X")

---

## License

Same as ResearchKit - see LICENSE file.
