# /rk.collect-documents - Collect Research Documents

You are helping the user collect and organize source documents for their research.

## Prerequisites

Check if `.researchkit/` folder exists in current directory or parent directories (up to 3 levels).

**If NOT found:**
- Tell user: "No ResearchKit project found. Run `/rk.init` first."
- Exit

## Context

After identifying research paths with `/rk.identify-paths`, users need to actually collect the documents (PDFs, papers, books) they'll read.

This command:
1. Reviews the research paths
2. Attempts to find downloadable versions
3. Creates a prioritized download queue
4. Tracks what's been collected

## Your Task

### Step 1: Read Research Paths

Load research path files from `.researchkit/research-paths/paths/*.md`

Extract all identified sources:
- Foundational texts
- Recent literature reviews
- High-impact recent work
- Emerging concepts references

### Step 2: For Each Source, Attempt to Find

**Use your knowledge to suggest where to find each source:**

For each document:
- **Check if likely open access** (e.g., arXiv, SSRN, ResearchGate, author websites)
- **Identify the journal/publisher**
- **Note if likely paywalled** (e.g., Elsevier, Springer behind paywall)
- **Suggest alternatives** if original is inaccessible (working papers, preprints)

**DO NOT actually download** - just identify and categorize.

### Step 3: Update Download Queue

Update `.researchkit/documents/download-queue.md`:

Organize by priority and access:

```markdown
## HIGH Priority - Open Access (Download Now)

- [ ] **Author (Year)** - "Title"
  - Source: arXiv / SSRN / Open Journal
  - URL: [Direct link if known]
  - Save to: documents/foundational/author-year-shortname.pdf
  - Status: Ready to download

## HIGH Priority - Requires Library/Purchase Access

- [ ] **Author (Year)** - "Title"
  - Source: Journal of XYZ (paywall)
  - Access method: [University library / Purchase / Request from author]
  - Save to: documents/foundational/author-year-shortname.pdf
  - Status: Pending manual download

## MEDIUM Priority - Recent Reviews

...

## LOW Priority - Supplementary

...
```

### Step 4: Provide Download Instructions

Tell the user:

**For Open Access sources:**
```
These are available to download now:
1. [List sources with URLs]

You can download manually, or I can help you find them.
```

**For Paywalled sources:**
```
These require library access or purchase:
1. [List sources]

Options:
- Access through your institutional library
- Request from authors via ResearchGate
- Check for preprint versions (arXiv, SSRN, author websites)
```

**For Each Downloaded Document:**
```
Save to:
- Foundational texts → .researchkit/documents/foundational/
- Recent reviews → .researchkit/documents/recent-reviews/
- Other sources → .researchkit/documents/supplementary/

Naming convention: author-year-shortname.pdf
Example: oreilly-1996-ambidextrous.pdf
```

### Step 5: Track Collection Status

Create or update `.researchkit/documents/collected.md`:

```markdown
# Document Collection Status

**Last updated**: [DATE]

## Statistics
- Total documents identified: [X]
- Downloaded: [X]
- In queue (pending): [X]
- Unable to access: [X]

## By Research Path

### Organizational Ambidexterity
- ✅ O'Reilly & Tushman (1996) - Downloaded
- ⏳ Birkinshaw et al. (2023) - In queue
- ❌ Smith (2020) - Unavailable (behind paywall, no preprint)

### [Other paths]
...

## Recent Downloads
- [DATE] - Author (Year) "Title" → foundational/
- [DATE] - Author (Year) "Title" → recent-reviews/
```

### Step 6: Suggest Next Steps

```
✅ Download queue updated

Documents ready to download: [X]
Documents needing manual access: [X]

Next steps:
1. Download open access documents
2. Check institutional library for paywalled sources
3. As you collect documents, mark them complete in download-queue.md
4. Once you have key documents, run /rk.create-stream to begin research
```

## Guidelines

### Prioritization

**HIGH Priority:**
- Foundational texts essential to understanding the topic
- Recent comprehensive reviews (last 3-5 years)
- Sources that appear in multiple research paths

**MEDIUM Priority:**
- High-impact recent work
- Influential papers cited by many sources
- Emerging concepts papers

**LOW Priority:**
- Supplementary readings
- Tangential sources
- Sources for specific details only

### Access Strategies

**For paywalled academic papers:**
1. Check institutional library access
2. Look for preprints (arXiv, SSRN, author websites)
3. Request from authors via ResearchGate or email
4. Check if available through Open Access deals

**For books:**
1. University library (physical or digital)
2. Google Books (partial preview)
3. Purchase if essential
4. Interlibrary loan

**For industry reports/white papers:**
1. Company websites (often free)
2. Industry association websites
3. Consulting firm publications

### Document Naming

Use consistent naming: `author-year-shortname.pdf`

Examples:
- `oreilly-1996-ambidextrous.pdf`
- `march-1991-exploration-exploitation.pdf`
- `birkinshaw-2023-review.pdf`

### Tracking Downloaded Files

As users download files, they should:
1. Save to appropriate folder (foundational/recent-reviews/supplementary)
2. Check off in download-queue.md
3. Update collected.md status

## Important Notes

**On copyright:**
- Remind users to respect copyright and licensing
- Only download what they have legal access to
- Institutional access, purchase, or author permission required for paywalled content

**On organization:**
- Good file naming makes later citation easier
- Consistent folder structure helps find sources
- Track download dates in collected.md

**On selective downloading:**
- Don't need EVERY source immediately
- Start with foundational texts + recent reviews
- Add supplementary sources as needed during research

## File Locations

- Download queue: `.researchkit/documents/download-queue.md`
- Collection status: `.researchkit/documents/collected.md`
- Foundational texts: `.researchkit/documents/foundational/`
- Recent reviews: `.researchkit/documents/recent-reviews/`
- Supplementary: `.researchkit/documents/supplementary/`
