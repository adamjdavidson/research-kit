# Exa Setup Guide

How to add Exa for searching academic papers and current research in ResearchKit.

---

## Why Use Exa with ResearchKit?

**The Problem:** When researching, Claude's knowledge has a cutoff date (January 2025). You need access to:
- Recent academic papers (2024-2025)
- Current literature reviews
- Latest research findings
- Real-time information about scholars and their work

**The Solution:** Exa is a search engine specifically designed for AI, with a specialized `research_paper_search` tool that finds academic papers, research content, and scholarly work.

**How it works:** You install an "MCP server" (a bridge) that lets Claude search the web via Exa. Claude can then find current papers, recent reviews, and up-to-date research to inform your ResearchKit projects.

**Example workflow:**
1. You're researching organizational psychology
2. You use `/rk-identify-paths` to find research traditions
3. Claude uses Exa to search for recent literature reviews (2024-2025)
4. Claude finds the latest scholars and their recent work
5. You get current, not outdated, information

---

## Prerequisites

Before starting, you need:

1. **Claude Code installed** - See the main [README](../../README.md)
2. **An Exa API key** - Free tier available (1000 searches/month)
3. **5 minutes** - Setup takes about 5 minutes

**Free tier is generous for research use!** 1000 searches per month is plenty for most research projects.

---

## Part 1: Get Your Exa API Key (3 minutes)

An "API key" is like a password that lets Claude Code connect to Exa on your behalf.

### Step 1: Go to Exa Dashboard

**In your web browser, visit:**
```
https://dashboard.exa.ai/
```

**What you'll see:** The Exa sign-in page.

### Step 2: Sign Up or Sign In

**Click "Sign Up" or "Sign In"**

**You can sign in with:**
- Google account (easiest)
- GitHub account
- Email

**What you'll see:** The Exa dashboard.

### Step 3: Get Your API Key

**In the left sidebar, click "API Keys"** or visit:
```
https://dashboard.exa.ai/api-keys
```

**Click "Create new API key"**

**Give it a name:**
- Type something like "ResearchKit" or "Claude Code"
- Click "Create"

**What happens:** Exa generates a key that looks like this:
```
exa_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### Step 4: Copy and Save Your Key

**CRITICAL: Copy this key immediately!**

**Click the "Copy" button** next to your API key.

**Save it somewhere safe:**
- Open TextEdit (Mac) or Notepad (Windows)
- Paste your key
- Save the file as `exa-api-key.txt` on your Desktop

**Why this matters:** You'll need this key in Part 2. You can view it again later in the Exa dashboard, but it's best practice to save it now.

**⚠️ Keep it private!** This key is like a password. Don't share it publicly or commit it to GitHub.

---

## Part 2: Install the Exa MCP Server (2 minutes)

Now we'll install the "bridge" that lets Claude Code talk to Exa.

### Option 1: Quick Install (Recommended)

**In your terminal, run this command** (replace `YOUR_API_KEY` with your actual key from Part 1):

```bash
claude mcp add exa -e EXA_API_KEY=YOUR_API_KEY -- npx -y exa-mcp-server
```

**Example with a real key:**
```bash
claude mcp add exa -e EXA_API_KEY=exa_abc123xyz789 -- npx -y exa-mcp-server
```

**What this does:**
- Downloads and installs the Exa MCP server
- Configures it with your API key
- Adds it to Claude Code automatically

**What you'll see:** Installation progress, then success message.

### Option 2: Manual Configuration

If the quick install doesn't work, you can configure manually:

**Step 1: Find Your Claude Code Configuration File**

The file location depends on your operating system:

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

**Step 2: Open the Configuration File**

**On Mac:**
1. Open **Finder**
2. Press `Command + Shift + G`
3. Type: `~/Library/Application Support/Claude/`
4. Press `Enter`
5. Find `claude_desktop_config.json`
6. Right-click and choose **"Open With" → "TextEdit"**

**On Windows:**
1. Press `Windows + R`
2. Type: `%APPDATA%\Claude`
3. Press `Enter`
4. Find `claude_desktop_config.json`
5. Right-click and choose **"Open With" → "Notepad"**

**Step 3: Add Exa Configuration**

**If you already have other MCP servers** (like Gemini), add the Exa section:

```json
{
  "mcpServers": {
    "gemini": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-gemini"],
      "env": {
        "GEMINI_API_KEY": "your-gemini-key"
      }
    },
    "exa": {
      "command": "npx",
      "args": ["-y", "exa-mcp-server"],
      "env": {
        "EXA_API_KEY": "YOUR_EXA_API_KEY_HERE"
      }
    }
  }
}
```

**If this is your first MCP server:**

```json
{
  "mcpServers": {
    "exa": {
      "command": "npx",
      "args": ["-y", "exa-mcp-server"],
      "env": {
        "EXA_API_KEY": "YOUR_EXA_API_KEY_HERE"
      }
    }
  }
}
```

**⚠️ IMPORTANT: Replace `YOUR_EXA_API_KEY_HERE`** with your actual Exa API key!

**Step 4: Save and Restart**

- Save the file (`Command + S` on Mac, `Ctrl + S` on Windows)
- Close Claude Code completely
- Restart Claude Code: `claude`

---

## Part 3: Verify It's Working (1 minute)

Let's make sure Claude Code can talk to Exa.

### Test the Connection

**In Claude Code, type:**
```
Can you list the available MCP tools?
```

**What you should see:** Claude will list tools including Exa-related ones like:
- `exa_search` or `search_exa`
- `research_paper_search`
- `find_similar`

**If you see Exa tools:** ✅ Success! It's working!

**If you don't see Exa tools:** See [Troubleshooting](#troubleshooting) below.

### Test with a Simple Search

**Try asking Claude to search:**
```
Use Exa to search for recent academic papers (2024-2025) about organizational change and AI adoption.
```

**What should happen:** Claude uses Exa to search and returns recent papers with titles, authors, and publication dates.

---

## How to Use Exa in Your ResearchKit Workflow

Now that Exa is installed, here's how to use it during research.

### Scenario 1: Identify Research Paths with Current Literature

**When:** During `/rk-identify-paths`

**Problem:** You need to find which research traditions are currently studying your question.

**In Claude Code, ask:**
```
I'm researching "How do leaders balance AI efficiency with human meaning?"

Can you:
1. Use Exa to search for recent literature reviews (2024-2025) on this topic
2. Identify which research traditions/perspectives are actively studying this
3. Find the key scholars publishing in each tradition recently
4. Then help me use /rk-identify-paths to document these perspectives
```

**What happens:**
1. Claude uses Exa's `research_paper_search` to find recent reviews
2. Claude identifies current research traditions from the papers
3. Claude notes who's publishing recently
4. You get up-to-date perspectives, not outdated ones

### Scenario 2: Find Current Papers for Each Stream

**When:** During `/rk-create-stream`

**Problem:** You're researching organizational psychology but don't know what papers to read.

**In Claude Code, ask:**
```
I'm creating a stream for organizational psychology perspective on AI adoption.

Can you:
1. Use Exa to find the 5-10 most relevant recent papers (2024-2025)
2. For each paper, tell me: author, title, year, key contribution
3. Help me use /rk-collect-documents to organize these papers
```

### Scenario 3: Find Recent Reviews

**When:** At the start of research, after refining your question

**Problem:** You need comprehensive overview of the field.

**In Claude Code, ask:**
```
Can you use Exa to search for recent literature reviews (2023-2025) on:
- Organizational change during technological disruption
- AI adoption in enterprises
- Culture change and technology

Then help me prioritize which ones to read first.
```

### Scenario 4: Find Specific Scholars' Recent Work

**When:** During `/rk-create-stream` when you've identified key scholars

**Problem:** You know Karl Weick is important for sensemaking, but what's recent?

**In Claude Code, ask:**
```
Can you use Exa to find Karl Weick's most recent publications (2020-2025) related to organizational sensemaking and technology?
```

### Scenario 5: Validate Claims with Current Research

**When:** During `/rk-cross-stream` synthesis

**Problem:** You want to verify a claim against current evidence.

**In Claude Code, ask:**
```
I found a claim that "culture eats strategy for breakfast" in AI adoption.

Can you:
1. Use Exa to find recent papers (2024-2025) that either support or contradict this
2. Summarize what current research says
```

---

## When to Use Exa vs. Claude's Knowledge

**Use Claude's built-in knowledge for:**
- Foundational concepts (e.g., "What is organizational identity?")
- Classic theories and frameworks
- Well-established research traditions
- Historical context

**Use Exa for:**
- Recent papers (2024-2025)
- Current scholars' latest work
- Literature reviews published recently
- Emerging concepts and debates
- Verifying if something is still current

**The pattern:** Claude provides foundational understanding, Exa provides current research.

---

## Understanding the Free Tier

**Free tier limits:**
- **1,000 searches per month**
- No credit card required
- Includes access to research_paper_search tool

**What this means for ResearchKit:**
- ~33 searches per day
- Plenty for most research projects
- Each `/rk-identify-paths` might use 3-5 searches
- Each `/rk-create-stream` might use 5-10 searches
- You can do 3-5 complete research projects per month

**If you need more:**
- Paid plans available with more searches
- See https://exa.ai/pricing

---

## Troubleshooting

### "I don't see Exa tools when I ask Claude to list them"

**Possible causes:**
1. Configuration file has a typo
2. API key is incorrect
3. Claude Code wasn't restarted

**Solution:**

**1. Check the configuration file:**
```bash
# On Mac:
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json

# On Windows (PowerShell):
cat $env:APPDATA\Claude\claude_desktop_config.json

# On Linux:
cat ~/.config/Claude/claude_desktop_config.json
```

**Make sure:**
- JSON syntax is correct (matching braces, commas)
- Your API key is in quotes: `"EXA_API_KEY": "exa_..."`
- No extra commas or missing braces

**2. Verify your API key:**
- Go to https://dashboard.exa.ai/api-keys
- Check your key is active
- Copy it again and update the config file

**3. Fully restart Claude Code:**
```bash
# Make sure Claude Code is completely stopped
# Then restart:
claude
```

### "I get an error: 'Invalid API key'"

**Cause:** Your API key is wrong or expired.

**Solution:**

1. Go to https://dashboard.exa.ai/api-keys
2. Create a new API key
3. Update your config file with the new key
4. Restart Claude Code

### "Searches work but return no results"

**Possible causes:**
1. Query is too specific
2. No recent papers match your search
3. Rate limit reached

**Solutions:**

**If query too specific:**
- Try broader search terms
- Remove date restrictions (don't limit to 2025 only)
- Try searching for key concepts separately

**If no recent papers:**
- Expand date range to 2020-2025
- Try related keywords
- Check if papers exist on Google Scholar first

**If rate limited:**
- Wait a few minutes
- Check your usage at https://dashboard.exa.ai/
- Free tier: 1000 searches/month

### "Error: EXA_API_KEY not found"

**Cause:** Environment variable not set correctly in config.

**Solution:**

Check your config file has this structure exactly:
```json
{
  "mcpServers": {
    "exa": {
      "command": "npx",
      "args": ["-y", "exa-mcp-server"],
      "env": {
        "EXA_API_KEY": "your-key-here"
      }
    }
  }
}
```

Note the `"env"` section with `"EXA_API_KEY"` inside it.

---

## Privacy and Security

### Your Data

**What gets sent to Exa:**
- Your search queries
- Filters and parameters

**What does NOT get sent to Exa:**
- Your ResearchKit project files
- Your research notes
- Your API key (stays on your computer)

### Best Practices

**1. Don't commit your API key to Git:**

Add to your `.gitignore`:
```
claude_desktop_config.json
```

**2. Don't share your API key:**
- It's like a password
- Anyone with your key can use your quota
- If exposed, create a new key immediately

**3. Review Exa's data policies:**
- See https://exa.ai/privacy

---

## Comparison: Exa vs. Gemini vs. Built-in WebSearch

ResearchKit works with multiple search options:

### Exa (This Guide)
**Best for:** Academic papers, research content, scholarly work
**Strengths:**
- Specialized `research_paper_search` tool
- AI-optimized search engine
- Finds academic sources reliably
**Free tier:** 1000 searches/month

### Gemini ([Setup Guide](gemini-setup.md))
**Best for:** Reading large documents (100+ pages)
**Strengths:**
- Huge context window (1 million tokens)
- Can analyze entire books
- Good for processing documents you already have
**Free tier:** 15 requests/min, 1500/day

### Built-in WebSearch
**Best for:** General web searches, recent news
**Strengths:**
- Already available in Claude Code
- No setup required
- Good for general information
**Limitations:** Not optimized for academic papers

**Recommendation:** Use all three!
- **Exa** for finding academic papers
- **Gemini** for analyzing large documents
- **Built-in WebSearch** for general context

---

## Next Steps

Now that Exa is set up:

1. **Continue with your ResearchKit workflow** - Use the main [Getting Started guide](getting-started.md)
2. **Use Exa for current research** - When identifying paths or collecting documents, ask Claude to use Exa
3. **Experiment** - Try searching for recent papers on your topic

**Example to try:**
```
I'm researching how companies adopt AI. Can you:

1. Use Exa to find 3-5 recent literature reviews (2024-2025) on AI adoption in organizations
2. For each review, tell me:
   - Authors and publication
   - Key research traditions covered
   - Main findings
3. Then help me use /rk-identify-paths to organize these perspectives
```

---

## Additional Resources

- **Exa Dashboard:** https://dashboard.exa.ai/
- **Exa Documentation:** https://docs.exa.ai/
- **Exa MCP GitHub:** https://github.com/exa-labs/exa-mcp-server
- **ResearchKit Commands Reference:** [commands-reference.md](commands-reference.md)
- **Gemini Setup (for large documents):** [gemini-setup.md](gemini-setup.md)

---

## Getting Help

**Having issues?**

1. **Check the troubleshooting section above**
2. **Verify your setup:**
   ```
   Can you list available MCP tools?
   ```
   (Ask this in Claude Code - you should see Exa tools)
3. **Check Exa Dashboard:**
   - Visit https://dashboard.exa.ai/
   - Make sure your API key is valid
   - Check your usage quota
4. **Ask for help:**
   - [ResearchKit GitHub Issues](https://github.com/adamjdavidson/research-kit/issues)
   - [ResearchKit Discussions](https://github.com/adamjdavidson/research-kit/discussions)

---

**You're all set!** Exa is now available for finding current academic papers in your ResearchKit workflow. 🔍
