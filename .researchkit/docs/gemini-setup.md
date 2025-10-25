# Gemini Setup Guide

How to add Gemini for handling large documents in ResearchKit.

---

## Why Use Gemini with ResearchKit?

**The Problem:** When researching, you'll often encounter documents that are too large for Claude's context window - like 100+ page PDFs, long research papers, or entire books.

**The Solution:** Google's Gemini has a much larger context window (up to 1 million tokens for Gemini 2.0 Pro) and can handle these large documents. You can use Gemini alongside Claude in your ResearchKit workflow.

**How it works:** You install a "bridge" (called an MCP server) that lets Claude call on Gemini when needed. Claude can send large documents to Gemini for analysis, then use those insights in your research.

**Example workflow:**
1. You're researching organizational psychology
2. You find a 200-page foundational text (too large for Claude)
3. You ask Claude to analyze it
4. Claude uses the Gemini MCP server to send the document to Gemini
5. Gemini analyzes it and returns key insights
6. Claude helps you integrate those insights into your research

---

## Prerequisites

Before starting, you need:

1. **Claude Code installed** - See the main [README](../../README.md)
2. **A Google account** - Free (Gmail account works)
3. **10 minutes** - Setup takes about 10 minutes

**No credit card required!** Google provides a free tier for Gemini.

---

## Part 1: Get Your Gemini API Key (5 minutes)

An "API key" is like a password that lets Claude Code connect to Gemini on your behalf.

### Step 1: Go to Google AI Studio

**In your web browser, visit:**
```
https://ai.google.dev/
```

**What you'll see:** The Google AI for Developers homepage.

### Step 2: Sign In with Your Google Account

**Click "Get started" or "Sign in"** in the top right.

**Use any Google account:**
- Your Gmail account
- A Google Workspace account
- Any account you use for Google services

**What you'll see:** Google's sign-in page.

### Step 3: Accept Terms of Service

**If this is your first time:**
- A pop-up will appear asking you to accept Terms of Service
- Read the terms
- Click **"Accept"** or **"Continue"**

**What you'll see:** The Google AI Studio dashboard.

### Step 4: Get Your API Key

**In the left sidebar, click "Get API key"** (it looks like a key icon 🔑)

**What you'll see:** The API key management page.

### Step 5: Create a New API Key

**Click the blue "Create API Key" button.**

**You'll see two options:**
- **"Create API key in new project"** ← Choose this if it's your first time
- "Create API key in existing project" ← Only if you already have a Google Cloud project

**Click "Create API key in new project"**

**What happens:** Google instantly generates a key that looks like this:
```
AIzaSyDxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### Step 6: Copy and Save Your Key

**CRITICAL: Copy this key immediately!**

**Click the "Copy" button** next to your API key.

**Save it somewhere safe:**
- Open TextEdit (Mac) or Notepad (Windows)
- Paste your key
- Save the file as `gemini-api-key.txt` on your Desktop

**Why this matters:** You'll need this key in Part 2. While you can view it again later in Google AI Studio, it's best practice to save it now.

**⚠️ Keep it private!** This key is like a password. Don't share it publicly or commit it to GitHub.

---

## Part 2: Install the Gemini MCP Server (5 minutes)

Now we'll install the "bridge" that lets Claude Code talk to Gemini.

### What You're Installing

**MCP Server** = Model Context Protocol Server = A bridge between Claude Code and Gemini

**Think of it like this:** Claude Code is in one room, Gemini is in another room. The MCP server is a messenger that runs between them carrying messages.

### Step 1: Find Your Claude Code Configuration File

Claude Code stores its settings in a configuration file. We need to edit this file.

**The file location depends on your operating system:**

**On Mac:**
```bash
~/Library/Application Support/Claude/claude_desktop_config.json
```

**On Windows:**
```bash
%APPDATA%\Claude\claude_desktop_config.json
```

**On Linux:**
```bash
~/.config/Claude/claude_desktop_config.json
```

### Step 2: Open the Configuration File

**On Mac:**

1. Open **Finder**
2. Press `Command + Shift + G` (this opens "Go to Folder")
3. Type: `~/Library/Application Support/Claude/`
4. Press `Enter`
5. Find the file `claude_desktop_config.json`
6. Right-click it and choose **"Open With" → "TextEdit"**

**On Windows:**

1. Press `Windows + R`
2. Type: `%APPDATA%\Claude`
3. Press `Enter`
4. Find the file `claude_desktop_config.json`
5. Right-click it and choose **"Open With" → "Notepad"**

**On Linux:**

```bash
nano ~/.config/Claude/claude_desktop_config.json
```

**What you'll see:** A file with JSON text (looks like structured code with curly braces `{}`).

**If the file doesn't exist:** Create a new file with this content:
```json
{
  "mcpServers": {}
}
```

### Step 3: Add Gemini MCP Server Configuration

**Look at the file content.** You should see something like this:

```json
{
  "mcpServers": {}
}
```

Or if you already have other MCP servers:

```json
{
  "mcpServers": {
    "some-other-server": {
      ...
    }
  }
}
```

**We're going to add the Gemini configuration.**

**Replace the entire file content** with this (make sure to replace `YOUR_API_KEY_HERE` with your actual key from Part 1):

```json
{
  "mcpServers": {
    "gemini": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-gemini"],
      "env": {
        "GEMINI_API_KEY": "YOUR_API_KEY_HERE"
      }
    }
  }
}
```

**⚠️ IMPORTANT: Replace `YOUR_API_KEY_HERE`** with your actual Gemini API key that you copied in Part 1!

**Example with a real key:**
```json
{
  "mcpServers": {
    "gemini": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-gemini"],
      "env": {
        "GEMINI_API_KEY": "AIzaSyDxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      }
    }
  }
}
```

**If you already have other MCP servers configured,** add the `"gemini"` section inside the `"mcpServers"` object, separated by a comma:

```json
{
  "mcpServers": {
    "some-other-server": {
      "command": "something",
      "args": ["..."]
    },
    "gemini": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-gemini"],
      "env": {
        "GEMINI_API_KEY": "YOUR_API_KEY_HERE"
      }
    }
  }
}
```

### Step 4: Save the File

**On Mac/Windows:**
- Press `Command + S` (Mac) or `Ctrl + S` (Windows)
- Close the text editor

**On Linux:**
- Press `Ctrl + X`
- Press `Y` to confirm
- Press `Enter`

### Step 5: Restart Claude Code

**Close Claude Code completely:**

**In your terminal where Claude Code is running:**
- Press `Ctrl + C` to stop Claude Code
- Or type `/exit`

**Restart Claude Code:**
```bash
claude
```

**What happens:** Claude Code reads the new configuration and connects to the Gemini MCP server.

---

## Part 3: Verify It's Working (1 minute)

Let's make sure Claude Code can talk to Gemini.

### Test the Connection

**In Claude Code, type:**
```
Can you list the available MCP tools?
```

**What you should see:** Claude will list the available tools, and you should see Gemini-related tools like:
- `gemini-query` or `gemini_query`
- `gemini-analyze` or similar

**If you see Gemini tools:** ✅ Success! It's working!

**If you don't see Gemini tools:** See [Troubleshooting](#troubleshooting) below.

### Test with a Simple Query

**Try asking Claude to use Gemini:**
```
Use Gemini to tell me a short joke about AI research.
```

**What should happen:** Claude will use the Gemini MCP server to query Gemini, and you'll see a response.

---

## How to Use Gemini in Your ResearchKit Workflow

Now that Gemini is installed, here's how to use it during research.

### Scenario 1: Analyzing Large Documents

**You found a 200-page foundational text that's too large for Claude's context.**

**In Claude Code, ask:**
```
I have a 200-page PDF about organizational psychology theories. Can you use Gemini to analyze it and extract:
1. The 5 main theoretical frameworks
2. Key scholars and their contributions
3. Recent debates or contradictions in the field

Then help me use /rk-collect-documents to organize this information.
```

**What happens:**
1. Claude uses the Gemini MCP server to send the PDF to Gemini
2. Gemini analyzes the 200-page document (no problem with its large context window)
3. Gemini returns the key information
4. Claude helps you organize it into your ResearchKit structure

### Scenario 2: Comparing Multiple Long Papers

**You have 5 long papers (50+ pages each) and want to find commonalities.**

**In Claude Code, ask:**
```
I have 5 long research papers on AI adoption. Can you use Gemini to:
1. Read all 5 papers
2. Identify where they agree (convergence)
3. Identify where they contradict (divergence)
4. Note any blind spots

Then help me capture this in /rk-cross-stream synthesis.
```

### Scenario 3: Extracting Stories from Books

**You're reading a 400-page book with great examples.**

**In Claude Code, ask:**
```
I'm reading "The Innovator's Dilemma" (400 pages). Can you use Gemini to:
1. Find all vivid stories with specific people, dates, and quotes
2. Rate them for vividness (1-10)
3. Identify what concepts each illustrates

Then help me use /rk-capture-story to save the best ones.
```

### When to Use Gemini vs. Claude

**Use Claude (default) for:**
- Research questions and refinement (`/rk-question`)
- Framework extraction (`/rk-frameworks`)
- Writing (`/rk-write`)
- Conversational guidance through the workflow
- Documents under ~100 pages

**Use Gemini (via Claude) for:**
- Very large documents (100+ pages)
- Multiple long documents at once
- Extracting information from entire books
- Initial analysis of massive corpora
- Any task hitting Claude's context limit

**The pattern:** Gemini does the heavy lifting on large documents, Claude helps you integrate those insights into your ResearchKit workflow.

---

## Troubleshooting

### "I don't see Gemini tools when I ask Claude to list them"

**Possible causes:**
1. Configuration file has a typo
2. API key is incorrect
3. Claude Code wasn't restarted

**Solution:**

**1. Check the configuration file:**
```bash
# On Mac:
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json

# On Windows (in PowerShell):
cat $env:APPDATA\Claude\claude_desktop_config.json

# On Linux:
cat ~/.config/Claude/claude_desktop_config.json
```

**Make sure:**
- The JSON syntax is correct (matching braces, commas in right places)
- Your API key is in quotes: `"GEMINI_API_KEY": "AIza..."`
- No extra commas or missing braces

**2. Verify your API key:**
- Go back to Google AI Studio: https://ai.google.dev/
- Click "Get API key" in the left sidebar
- Verify your key matches what's in the config file

**3. Fully restart Claude Code:**
```bash
# Make sure Claude Code is completely stopped
# Then restart:
claude
```

### "I get an error: 'Invalid API key'"

**Cause:** Your API key is wrong or expired.

**Solution:**

**1. Get a fresh API key:**
- Go to Google AI Studio: https://ai.google.dev/
- Click "Get API key"
- Create a new API key
- Copy it

**2. Update your config file:**
- Open `claude_desktop_config.json` again
- Replace the old key with the new key
- Save
- Restart Claude Code

### "Gemini tools appear but give errors when used"

**Possible causes:**
1. Hit the free tier rate limit (15 requests per minute)
2. API key doesn't have required permissions

**Solution:**

**If rate limited:**
- Wait a minute and try again
- The free tier allows 15 requests per minute
- For heavy usage, consider upgrading (still no credit card required for higher tiers)

**If permission error:**
- Go to Google AI Studio
- Make sure you accepted the Terms of Service
- Try creating a new API key

### "The file claude_desktop_config.json doesn't exist"

**Cause:** You haven't run Claude Code yet, or it's installed in a different location.

**Solution:**

**1. Run Claude Code at least once:**
```bash
claude
```

Then exit and try again.

**2. Create the file manually:**

**On Mac:**
```bash
mkdir -p ~/Library/Application\ Support/Claude
touch ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

Then edit it with TextEdit and add the configuration.

**On Windows (PowerShell):**
```powershell
New-Item -ItemType Directory -Force -Path "$env:APPDATA\Claude"
New-Item -ItemType File -Force -Path "$env:APPDATA\Claude\claude_desktop_config.json"
```

Then edit with Notepad and add the configuration.

**On Linux:**
```bash
mkdir -p ~/.config/Claude
touch ~/.config/Claude/claude_desktop_config.json
```

Then edit with `nano` and add the configuration.

---

## Understanding the Free Tier Limits

**Good news:** Google's free tier is generous for research use.

**Free tier limits:**
- **15 requests per minute**
- **1,500 requests per day**
- **1 million tokens per request** (that's huge - about 750,000 words!)

**What this means for ResearchKit:**
- You can analyze dozens of long documents per day
- Each document can be up to ~750,000 words
- Perfect for academic research workflows

**If you need more:**
- Google offers paid tiers with higher limits
- Still no credit card required for some higher tiers
- See https://ai.google.dev/pricing for current pricing

---

## Privacy and Security

### Your Data

**What gets sent to Gemini:**
- Only the documents/text you explicitly ask Claude to send to Gemini
- Your queries/prompts

**What does NOT get sent to Gemini:**
- Your entire ResearchKit project structure
- Files you haven't explicitly asked Claude to analyze
- Your API key (it stays on your computer)

### Best Practices

**1. Don't commit your API key to Git:**

Add this to your `.gitignore`:
```
claude_desktop_config.json
```

**2. Don't share your API key:**
- It's like a password
- Anyone with your key can use your Gemini quota
- If accidentally exposed, create a new key immediately

**3. Review Google's data policies:**
- Free tier: Your data may be used to improve models
- Paid tier: You can opt out of data usage
- See https://ai.google.dev/gemini-api/terms

---

## Next Steps

Now that Gemini is set up:

1. **Continue with your ResearchKit workflow** - Use the main [Getting Started guide](getting-started.md)
2. **Use Gemini for large documents** - When you hit Claude's context limit, ask Claude to use Gemini
3. **Experiment** - Try analyzing a long PDF to see how it works

**Example to try:**
```
I have a 150-page research paper. Can you use Gemini to:
1. Summarize the main argument
2. List all the key evidence
3. Note any methodological limitations

Then help me add it to my ResearchKit project with /rk-collect-documents.
```

---

## Additional Resources

- **Google AI Studio:** https://ai.google.dev/
- **Gemini API Documentation:** https://ai.google.dev/gemini-api/docs
- **MCP Server GitHub:** https://github.com/modelcontextprotocol
- **ResearchKit Commands Reference:** [commands-reference.md](commands-reference.md)

---

## Getting Help

**Having issues?**

1. **Check the troubleshooting section above**
2. **Verify your setup:**
   ```
   Can you list available MCP tools?
   ```
   (Ask this in Claude Code - you should see Gemini tools)
3. **Check Google AI Studio:**
   - Visit https://ai.google.dev/
   - Make sure your API key is valid
   - Check your usage quota
4. **Ask for help:**
   - [ResearchKit GitHub Issues](https://github.com/yourusername/research-kit/issues)
   - [ResearchKit Discussions](https://github.com/yourusername/research-kit/discussions)

---

**You're all set!** Gemini is now available as a tool for handling large documents in your ResearchKit workflow. 🚀
