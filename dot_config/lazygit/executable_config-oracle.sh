#!/bin/bash

# Extract MC task ID from the current branch name
branch_name=$(git rev-parse --abbrev-ref HEAD)
task_id=$(echo "$branch_name" | grep -oE 'MC-[0-9]+')

if [ -z "$task_id" ]; then
  echo "❌ Could not extract MC task ID from branch name: '$branch_name'"
  exit 1
fi

# Generate commit suggestions using aichat
commit_suggestions=$(aichat "Please suggest 5 commit messages, given the following diff:

\`\`\`diff
$(git --no-pager diff --no-color --no-ext-diff --cached)
\`\`\`

**Criteria:**

1. Format: Each commit message must follow this custom format:
- FEATURE $task_id <description>
- BUGFIX $task_id <description>

2. Avoid mentioning a module name unless directly relevant.
3. Clearly and concisely convey the change.
4. Suggest 5 messages with various angles, capturing potential bugs, features, or improvements.
5. Optionally include a multi-line message if the context warrants.

**Recent Commits:**

\`\`\`
$(git log -n 10 --pretty=format:'%h %s')
\`\`\`

**Output Format:**
Only output raw commit messages in the format:

FEATURE MC-1234 implement endpoint
---
BUGFIX MC-1234 fix validation logic
---
FEATURE MC-1234 add support for new filter

Only output raw messages, no intro or explanations." |
  sed "s/MC-[0-9]\+/MC-$task_id/g"
)

# Safely split suggestions using `awk` fallback if needed
echo "$commit_suggestions" | awk 'BEGIN {RS="---"; ORS="\0"} {gsub(/^\s+|\s+$/, "", $0); if (length($0) > 0) print}' |
fzf --height 20 --border --ansi --read0 --no-sort --preview 'echo {} | sed "s/\x0/\n---\n/g"' --with-nth=1 --delimiter='\n' --preview-window=up:wrap |
xargs -0 -I {} bash -c '
  COMMIT_MSG_FILE=$(mktemp)
  printf "%s" "$1" > "$COMMIT_MSG_FILE"
  MOD_TIME_BEFORE=$(stat -c %Y "$COMMIT_MSG_FILE")
  ${EDITOR:-vim} "$COMMIT_MSG_FILE"
  MOD_TIME_AFTER=$(stat -c %Y "$COMMIT_MSG_FILE")
  if [ "$MOD_TIME_BEFORE" -ne "$MOD_TIME_AFTER" ]; then
      git commit -F "$COMMIT_MSG_FILE"
  else
      echo "✋ Commit message was not saved, commit aborted."
  fi
  rm -f "$COMMIT_MSG_FILE"
' _ {}

