# /rk.validate - Constitutional Compliance Checking

You are helping the user validate their research work against their constitutional principles.

## Prerequisites

Check if `.researchkit/` folder exists in current directory or parent directories.

**If NOT found:**
- Tell user: "No ResearchKit project found. Run `/rk.init` first."
- Exit

## Context

The research constitution defines immutable methodological principles. This command checks research artifacts (questions, research paths, streams, frameworks, writing) against those principles to ensure compliance.

Like Spec Kit's constitutional enforcement, this provides quality gates.

## Your Task

### Step 1: Load Constitution

Read `.researchkit/constitution.md`

**If constitution doesn't exist:**
```
❌ No constitution found.

Run /rk.constitution first to define your research principles.

Constitutional validation requires established principles to check against.
```

**If exists:**
Parse constitution to extract:
- Each Article (principle)
- Requirements (MUST/SHOULD statements)
- Enforcement criteria

### Step 2: Ask Validation Scope

```
What would you like to validate?

1. Everything (full project audit)
2. Specific artifact:
   - Question
   - Research paths
   - Research streams
   - Frameworks
   - Writing
3. Particular principle (check one Article)

Choose option:
```

### Step 3: Perform Validation Checks

Based on scope, validate against each constitutional article:

#### Validation: Questions

**Check**:
- `.researchkit/questions/02-selected-questions.md`

**Against** (example principles):

**Article I: Multi-Perspective Analysis**
- [ ] Question implies examining from at least 3 perspectives?
- [ ] Discipline-specific variants created?
- [ ] Each variant clearly distinct?

**Article II: Evidence-Based** Reasoning
- [ ] Question is answerable with evidence?
- [ ] Scope defined (not too broad)?

---

#### Validation: Research Paths

**Check**:
- `.researchkit/research-paths/paths/*.md`

**Against**:

**Article II: Evidence-Based Reasoning**
- [ ] Foundational texts identified (minimum required)?
- [ ] Recent reviews included?
- [ ] Sources cited properly?

**Article IV: Framework Extraction** (if applicable)
- [ ] Practical relevance assessed?
- [ ] Actionability considered?

---

#### Validation: Research Streams

**Check**:
- `.researchkit/streams/*/`

**Against**:

**Article I: Multi-Perspective Analysis**
- [ ] At least 3 streams exist (or justified why fewer)?
- [ ] Each stream has distinct disciplinary lens?
- [ ] Stream-specific questions refined?

**Article III: Contradiction Awareness** (if applicable)
- [ ] Cross-stream contradictions documented?
- [ ] Tensions acknowledged rather than hidden?

---

#### Validation: Stories

**Check**:
- `.researchkit/stories/meta/*.md`
- `.researchkit/stories/index.md`

**Against**:

**Article VI: Narrative Evidence Discipline** (if applicable)
- [ ] Each major concept has at least one story?
- [ ] Stories rated for vividness?
- [ ] Story sources tracked?
- [ ] Emotional tone tagged?

**Evidence-Based Reasoning**:
- [ ] Story sources cited with location?
- [ ] Provenance clear?

---

#### Validation: Frameworks

**Check**:
- `.researchkit/synthesis/frameworks/*.md`

**Against**:

**Article II: Evidence-Based Reasoning**:
- [ ] Framework claims cite sources?
- [ ] Evidence from multiple streams?
- [ ] Primary sources used when possible?

**Article IV: Framework Extraction** (if applicable):
- [ ] Boundary conditions specified (when to use/not use)?
- [ ] Application process included?
- [ ] Practical value clear?

**Article VI: Narrative Evidence**:
- [ ] Frameworks paired with illustrative stories?
- [ ] At least one high-vividness story (8+)?

**Article III: Contradiction Awareness**:
- [ ] Limitations acknowledged?
- [ ] Contradictions in evidence noted?

---

#### Validation: Writing

**Check**:
- `.researchkit/writing/drafts/*.md` or outlines

**Against**:

**Article II: Evidence-Based Reasoning**:
- [ ] Claims supported with citations?
- [ ] Sources trackable to research notes?

**Article V: Practitioner Readiness** (if applicable):
- [ ] Language accessible to target audience?
- [ ] Jargon explained?
- [ ] Actionable guidance included?
- [ ] Real-world constraints acknowledged?

**Article VI: Narrative Evidence**:
- [ ] Abstract concepts paired with stories?
- [ ] High-vividness stories used for key points?

---

### Step 4: Generate Validation Report

Create validation report at `.researchkit/validation-[date].md`:

```markdown
# Constitutional Validation Report

**Date**: [DATE]
**Scope**: [What was validated]
**Constitution Version**: [version from constitution.md]

---

## Overall Compliance

**Status**: [PASS / PASS WITH NOTES / FAIL]

**Summary**:
- Articles fully complied with: [X] of [Y]
- Articles with minor issues: [X]
- Articles with major violations: [X]

---

## Article-by-Article Analysis

### Article I: [Principle Name]

**Status**: ✅ COMPLIANT / ⚠️ MINOR ISSUES / ❌ VIOLATION

**Requirements checked**:
- [x] Requirement 1 - PASS
- [x] Requirement 2 - PASS
- [ ] Requirement 3 - FAIL

**Findings**:
[Detailed explanation of compliance or violations]

**Evidence**:
- File: .researchkit/[path]
- Specific issue: [What was found]

**Recommendations**:
- [Action to address issue]

---

### Article II: [Principle Name]

[Same structure]

---

## Critical Violations

[If any FAIL status articles]

**Article [X]: [Principle]**
- Violation: [What's wrong]
- Impact: [Why this matters]
- Required action: [What must be done]
- Severity: CRITICAL / HIGH / MEDIUM

---

## Minor Issues

[If any MINOR ISSUES]

**Article [X]: [Principle]**
- Issue: [What could be better]
- Recommendation: [Suggested improvement]
- Severity: LOW

---

## Strengths

[What's working well]

- [Strength 1] - [Evidence]
- [Strength 2] - [Evidence]

---

## Action Items

High priority:
- [ ] [Critical action 1]
- [ ] [Critical action 2]

Medium priority:
- [ ] [Action 1]
- [ ] [Action 2]

Low priority (nice to have):
- [ ] [Action 1]

---

## Next Validation

Recommended: [When to revalidate - e.g., after addressing critical items, before writing, etc.]
```

### Step 5: Present Summary to User

```
📋 Constitutional Validation Complete

Overall: [PASS / PASS WITH NOTES / FAIL]

Compliant: [X]/[Y] principles
Issues found: [X] critical, [X] minor

[If CRITICAL issues:]
⚠️ CRITICAL VIOLATIONS FOUND
These must be addressed before proceeding:
1. [Violation 1]
2. [Violation 2]

[If minor issues:]
Minor improvements recommended:
1. [Issue 1]
2. [Issue 2]

[If PASS:]
✅ All constitutional requirements met!

Full report: .researchkit/validation-[date].md

[Suggest next steps based on findings]
```

### Step 6: Suggest Remediation

For each violation or issue, suggest specific fixes:

```
Addressing Critical Issues:

Issue: Article I (Multi-Perspective) - Only 2 research streams exist

Remediation:
1. Create additional stream: /rk.create-stream [suggested discipline]
2. Or: Document justification in constitution for why 2 streams sufficient
3. Update Article I to reflect actual practice if methodology has changed

---

Issue: Article VI (Narrative Evidence) - Framework lacks illustrative story

Remediation:
1. Review story library: /rk.find-stories --concept [framework-concept]
2. If no stories exist, capture one: /rk.capture-story
3. Link story to framework in frameworks/[name].md
```

## Validation Scenarios

### Pre-Writing Validation
**When**: Before starting to write
**Check**: Research completeness, framework quality, story availability
**Goal**: Ensure sufficient research foundation

### Final Validation
**When**: Before publishing/presenting
**Check**: Everything - full project audit
**Goal**: Quality assurance, constitutional compliance

### Principle-Specific Validation
**When**: Focusing on one methodology aspect
**Check**: Single Article compliance across all artifacts
**Goal**: Targeted improvement

### Artifact-Specific Validation
**When**: After creating framework or finishing writing
**Check**: That specific artifact against all principles
**Goal**: Quality gate for specific output

## Severity Levels

### CRITICAL (Must Fix)
- Violates core "MUST" requirements
- Undermines research validity
- Compromises practitioner value
- Examples:
  - No evidence citations
  - Missing required perspectives
  - Framework without boundary conditions

### HIGH (Should Fix Soon)
- Violates "SHOULD" requirements
- Reduces research quality
- Limits usefulness
- Examples:
  - Some sources uncited
  - Contradictions not documented
  - Jargon unexplained

### MEDIUM (Good to Address)
- Best practice not followed
- Could be improved
- Not essential but valuable
- Examples:
  - Story vividness could be higher
  - Additional examples would help

### LOW (Nice to Have)
- Optimization opportunities
- Polish and refinement
- Examples:
  - More cross-references
  - Additional formatting

## Guidelines

### For Effective Validation

**Be specific:**
- Cite exact locations of issues
- Quote violating text
- Provide concrete examples

**Be constructive:**
- Focus on improvement, not criticism
- Suggest specific remediation
- Acknowledge what's working well

**Be realistic:**
- Perfect compliance is rare
- Minor issues are normal
- Focus on critical violations first

### Common Violations

**Evidence-Based Reasoning:**
- Claims without citations
- Unsourced stories
- "It is known that..." without source

**Multi-Perspective:**
- Only one discipline examined
- Surface-level engagement with other perspectives
- Missing stream-specific questions

**Narrative Evidence:**
- Frameworks without stories
- Stories without vividness ratings
- Concepts without concrete examples

**Practitioner Readiness:**
- Academic jargon unexplained
- No actionable guidance
- Real-world constraints ignored

## Constitutional Amendment

If validation reveals systematic issues:

```
⚠️ Pattern Detected

Multiple violations of Article [X]: [Principle]

This suggests either:
1. Research practice has evolved beyond constitution
2. Principle is unrealistic for this project
3. Need better understanding/training on this principle

Consider:
- Updating constitution (/rk.constitution --refine)
- Or: Addressing violations through remediation
```

## File Locations

- Validation reports: `.researchkit/validation-[date].md`
- Constitution: `.researchkit/constitution.md`
- Artifacts validated: Various `.researchkit/` subdirectories

## Important Notes

**On validation timing:**
- Early validation prevents later rework
- Regular validation maintains quality
- Final validation ensures completeness

**On constitutional evolution:**
- Constitutions can be amended
- If violations are systematic, constitution may need updating
- Document rationale for amendments

**On practicality:**
- Perfect compliance is ideal, not always realistic
- Focus on critical principles
- Some principles are aspirational
- Use judgment about severity
