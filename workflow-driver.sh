#!/bin/bash
# ResearchKit Workflow Driver
# Automated step-by-step guidance through the research methodology
# No need to remember prompts - just run this and follow along

set -e

# Configuration
WORKFLOW_DIR="${WORKFLOW_DIR:-.}"
STATE_FILE="$WORKFLOW_DIR/.workflow-state.json"

# Colors for better UX
BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Initialize state if doesn't exist
init_state() {
    if [ ! -f "$STATE_FILE" ]; then
        cat > "$STATE_FILE" <<EOF
{
  "current_step": 1,
  "completed_steps": [],
  "workflow_name": "ResearchKit Standard Research",
  "started": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "last_updated": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
    fi
}

# Helper functions
get_current_step() {
    grep '"current_step"' "$STATE_FILE" | sed 's/.*: \([0-9]*\).*/\1/'
}

mark_step_complete() {
    local step=$1
    # Append to completed_steps array
    local completed=$(grep '"completed_steps"' "$STATE_FILE" | sed 's/.*\[\(.*\)\].*/\1/')
    if [ -z "$completed" ]; then
        sed -i '' 's/"completed_steps": \[\]/"completed_steps": ['"$step"']/' "$STATE_FILE"
    else
        sed -i '' 's/"completed_steps": \[/"completed_steps": ['"$step"', /' "$STATE_FILE"
    fi

    # Update current_step to next
    local next_step=$((step + 1))
    sed -i '' 's/"current_step": [0-9]*/"current_step": '"$next_step"'/' "$STATE_FILE"

    # Update timestamp
    sed -i '' 's/"last_updated": ".*"/"last_updated": "'"$(date -u +%Y-%m-%dT%H:%M:%SZ)"'"/' "$STATE_FILE"
}

# Display header
show_header() {
    cat <<'EOF'
╔═══════════════════════════════════════════════════════════════╗
║                  RESEARCHKIT WORKFLOW DRIVER                   ║
║         Step-by-Step Guidance Through Research Process         ║
╚═══════════════════════════════════════════════════════════════╝

EOF
}

# Display workflow overview
show_workflow() {
    cat <<'EOF'
STANDARD RESEARCH WORKFLOW:

 1. 🎯 Define Research Question     (/rk-question)
 2. 🔍 Develop Search Strategy      (/rk-search-strategy)
 3. 🌐 Execute Initial Searches     (/rk-search)
 4. 📖 Deep Read Key Sources        (/rk-read)
 5. 🎨 Capture Vivid Stories        (/rk-story)
 6. 🔗 Synthesize Findings          (/rk-synthesize)
 7. 📊 Build Framework              (/rk-framework)
 8. 🔬 Test Framework               (/rk-test)
 9. ✨ Identify Gaps                (/rk-gaps)
10. 📝 Create Final Deliverable     (/rk-deliver)

EOF
}

# Generate prompt for each step
generate_prompt() {
    local step=$1

    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${RESET}"

    case $step in
        1)
            cat <<'EOF'
STEP 1: DEFINE RESEARCH QUESTION
═══════════════════════════════════════════════════════════════

Turn your vague question into a clear, answerable research question.

COMMAND TO RUN:
    /rk-question

This will guide you through:
- Clarifying what you really want to know
- Identifying the disciplines involved
- Setting boundaries for your research
- Defining what "done" looks like

WHAT HAPPENS NEXT:
You'll get a refined research question document that serves as your
north star for the rest of the research process.

EOF
            ;;
        2)
            cat <<'EOF'
STEP 2: DEVELOP SEARCH STRATEGY
═══════════════════════════════════════════════════════════════

Plan WHERE to look and WHAT to search for across multiple disciplines.

COMMAND TO RUN:
    /rk-search-strategy

This will help you:
- Identify relevant academic disciplines
- Generate search keywords for each discipline
- Prioritize sources (academic papers, industry reports, etc.)
- Create a systematic search plan

WHAT HAPPENS NEXT:
You'll have a multi-disciplinary search strategy that ensures you
don't miss important perspectives.

EOF
            ;;
        3)
            cat <<'EOF'
STEP 3: EXECUTE INITIAL SEARCHES
═══════════════════════════════════════════════════════════════

Run systematic searches across your planned sources.

COMMAND TO RUN:
    /rk-search

This will:
- Search academic databases for papers
- Find relevant industry reports
- Identify key practitioners and case studies
- Organize results by discipline and relevance

TIP: You may need to run /rk-search multiple times for different
disciplines or source types.

WHAT HAPPENS NEXT:
You'll have a curated set of sources ready for deep reading.

EOF
            ;;
        4)
            cat <<'EOF'
STEP 4: DEEP READ KEY SOURCES
═══════════════════════════════════════════════════════════════

Read your most important sources carefully and extract insights.

COMMAND TO RUN:
    /rk-read

For each key source, this will help you:
- Summarize main arguments
- Extract quotable insights
- Identify conflicting viewpoints
- Note methodological approaches
- Connect to your research question

TIP: Focus on your top 5-10 sources first. You can always add more.

WHAT HAPPENS NEXT:
You'll have detailed notes organized by themes and disciplines.

EOF
            ;;
        5)
            cat <<'EOF'
STEP 5: CAPTURE VIVID STORIES
═══════════════════════════════════════════════════════════════

Find concrete examples and case studies that bring your research to life.

COMMAND TO RUN:
    /rk-story

This will help you:
- Identify compelling case studies
- Extract vivid details and quotes
- Document real-world applications
- Find "villain" and "hero" narratives
- Capture before/after transformations

WHY THIS MATTERS:
Stories make abstract findings concrete and memorable. They're
essential for communicating your research effectively.

WHAT HAPPENS NEXT:
You'll have a library of stories organized by theme.

EOF
            ;;
        6)
            cat <<'EOF'
STEP 6: SYNTHESIZE FINDINGS
═══════════════════════════════════════════════════════════════

Connect insights across disciplines and identify patterns.

COMMAND TO RUN:
    /rk-synthesize

This will guide you through:
- Identifying common themes across sources
- Resolving contradictions between disciplines
- Spotting novel connections
- Building toward your framework
- Highlighting surprising findings

WHAT HAPPENS NEXT:
You'll have a synthesis document that shows the "big picture"
emerging from your research.

EOF
            ;;
        7)
            cat <<'EOF'
STEP 7: BUILD FRAMEWORK
═══════════════════════════════════════════════════════════════

Create an actionable framework based on your synthesis.

COMMAND TO RUN:
    /rk-framework

This will help you:
- Distill insights into principles or guidelines
- Organize framework into clear steps/components
- Make it actionable (not just descriptive)
- Add decision criteria or diagnostic questions
- Ensure it's memorable and practical

WHAT HAPPENS NEXT:
You'll have a draft framework ready for testing.

EOF
            ;;
        8)
            cat <<'EOF'
STEP 8: TEST FRAMEWORK
═══════════════════════════════════════════════════════════════

Validate your framework against real cases and edge cases.

COMMAND TO RUN:
    /rk-test

This will guide you through:
- Applying framework to known cases
- Testing against edge cases
- Identifying where it works/breaks
- Refining based on testing
- Documenting limitations

WHAT HAPPENS NEXT:
You'll have a tested, refined framework with known boundaries.

EOF
            ;;
        9)
            cat <<'EOF'
STEP 9: IDENTIFY GAPS
═══════════════════════════════════════════════════════════════

Find what you still don't know and what needs more research.

COMMAND TO RUN:
    /rk-gaps

This will help you:
- Identify unanswered questions
- Spot contradictions that need resolution
- Find areas needing more evidence
- Suggest follow-up research directions
- Acknowledge limitations

WHY THIS MATTERS:
Good research knows its boundaries. Gaps often point to the most
interesting next questions.

WHAT HAPPENS NEXT:
You'll have a clear map of what you've learned and what remains
unknown.

EOF
            ;;
        10)
            cat <<'EOF'
STEP 10: CREATE FINAL DELIVERABLE
═══════════════════════════════════════════════════════════════

Package your research into a polished, actionable deliverable.

COMMAND TO RUN:
    /rk-deliver

This will help you:
- Choose the right format (report, presentation, guide, etc.)
- Structure your findings for your audience
- Lead with insights, not process
- Include vivid stories and evidence
- Make clear recommendations
- Point to gaps and next steps

WHAT HAPPENS NEXT:
You'll have a complete research deliverable ready to share!

EOF
            ;;
        *)
            echo "Unknown step: $step"
            exit 1
            ;;
    esac

    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${RESET}"
    echo ""
}

# Main workflow
main() {
    init_state
    show_header
    show_workflow

    current_step=$(get_current_step)

    if [ "$current_step" -gt 10 ]; then
        cat <<EOF

${GREEN}╔═══════════════════════════════════════════════════════════════╗
║                   RESEARCH COMPLETED! ✅                       ║
╚═══════════════════════════════════════════════════════════════╝${RESET}

Congratulations! You've completed all 10 steps of the research workflow.

WHAT YOU'VE CREATED:
✅ Clear research question
✅ Multi-disciplinary search strategy
✅ Curated source library
✅ Deep reading notes
✅ Vivid story library
✅ Cross-disciplinary synthesis
✅ Actionable framework
✅ Tested against edge cases
✅ Gap analysis
✅ Final deliverable

TO REVIEW YOUR WORK:
Check your project directory for all the research artifacts created.

TO START A NEW RESEARCH PROJECT:
Remove the state file and run again:
    rm .workflow-state.json
    ./workflow-driver.sh

EOF
        exit 0
    fi

    echo ""
    echo -e "${YELLOW}Current Progress: Step $current_step of 10${RESET}"
    echo ""

    generate_prompt "$current_step"

    echo ""
    echo -e "${BOLD}Follow the instructions above, then press ENTER when complete.${RESET}"
    echo ""
    echo -e "To skip this step: Ctrl+C, then manually edit .workflow-state.json"
    echo ""

    # Wait for user to press ENTER
    read -r

    # Mark step complete and move to next
    mark_step_complete "$current_step"

    echo ""
    echo -e "${GREEN}✅ Step $current_step marked complete!${RESET}"
    echo ""
    echo -e "${BOLD}Run ./workflow-driver.sh again to continue to Step $((current_step + 1)).${RESET}"
    echo ""
}

main
