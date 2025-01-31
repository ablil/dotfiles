#!/bin/bash

#!/bin/bash

set -e

# Extract added and removed TODO lines from git diff
ADDED_TODOS=$(git diff $left_ref $right_ref | egrep -i "^\+.*(//|#)\s*todo" | sed 's/.*todo.*://gi')
REMOVED_TODOS=$(git diff $left_ref $right_ref | egrep -i "^-.*(//|#)\s*todo" | sed 's/.*todo.*://gi')

# Function to create an issue for a TODO
create_issue() {
  local TODO="$1"
  echo "Creating issue for TODO: $TODO"
  gh issue create --title "$TODO" --body "This issue was automatically created from a TODO in the code."
}

# Function to delete an issue for a TODO
delete_issue() {
  local TODO="$1"
  echo "Deleting issue for TODO: $TODO"
  ISSUE_ID=$(gh issue list --search "in:title $TODO" --json number --jq '.[].number')
  if [ -n "$ISSUE_ID" ]; then
    gh issue close "$ISSUE_ID"
    echo "Issue #$ISSUE_ID closed for TODO: $TODO"
  else
    echo "No issue found for TODO: $TODO"
  fi
}

# Process added TODOs
if [ -n "$ADDED_TODOS" ]; then
  echo "$ADDED_TODOS" | while IFS= read -r TODO; do
    TODO=$(echo "$TODO" | xargs) # Trim whitespace
    EXISTING_ISSUE=$(gh issue list --search "in:title $TODO" --json title --jq '.[].title')
    if [ -z "$EXISTING_ISSUE" ]; then
      create_issue "$TODO"
    else
      echo "Issue already exists for TODO: $TODO"
    fi
  done
else
  echo "No new TODOs found in git diff."
fi

# Process removed TODOs
if [ -n "$REMOVED_TODOS" ]; then
  echo "$REMOVED_TODOS" | while IFS= read -r TODO; do
    TODO=$(echo "$TODO" | xargs) # Trim whitespace
    delete_issue "$TODO"
  done
else
  echo "No removed TODOs found in git diff."
fi

echo "Script completed."
