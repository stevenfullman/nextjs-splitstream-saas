#!/bin/bash
set -euo pipefail

# Improved complete-task.sh script for SplitStream project
# Usage: ./complete-task.sh <task-id> [no_commit]

# --- Input Validation ---
if [ -z "${1:-}" ]; then
  echo "Error: Task ID is required"
  echo "Usage: ./complete-task.sh <task-id> [no_commit]"
  exit 1
fi

TASK_ID=$1
NO_COMMIT_FLAG="${2:-}"
TASK_ALREADY_COMPLETE=false

# --- Extract Task Info ---
PHASE=$(echo "$TASK_ID" | cut -d'.' -f1)
SUBPHASE="${PHASE}.$(echo "$TASK_ID" | cut -d'.' -f2)"

# If NO_COMMIT_FLAG is not set, check the branch
if [ "$NO_COMMIT_FLAG" != "no_commit" ]; then
  # --- Check Current Branch ---
  CURRENT_BRANCH=$(git branch --show-current)
  if [[ $CURRENT_BRANCH != task-${TASK_ID}* ]]; then
    echo "Warning: You don't appear to be on a branch for task $TASK_ID"
    echo "Current branch: $CURRENT_BRANCH"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      exit 1
    fi
  fi
fi

# --- Get Implementation Progress File ---
PROGRESS_FILE="project-documentation/implementation-progress.md"

# --- Find the correct task description using a more robust method ---
find_task_description() {
  local unchecked_line completed_line flexible_line
  
  # Try an exact match first with checkbox unchecked
  unchecked_line=$(grep -n "^\s*-\s*\[\s*\]\s*\*\*${TASK_ID}\.\*\*" "$PROGRESS_FILE" 2>/dev/null | head -1 | cut -d: -f1 || echo "")
  
  if [ -n "$unchecked_line" ]; then
    # Extract task description using sed
    TASK_LINE="$unchecked_line"
    TASK_DESCRIPTION=$(sed -n "${TASK_LINE}p" "$PROGRESS_FILE" | sed -E "s/.*\*\*${TASK_ID}\.\*\*\s*(.*)/\1/")
    
    # If extraction failed, try a more lenient approach
    if [ -z "$TASK_DESCRIPTION" ]; then
      TASK_DESCRIPTION=$(sed -n "${TASK_LINE}p" "$PROGRESS_FILE" | grep -o "\*\*${TASK_ID}\.\*\*.*$" | sed -E "s/\*\*${TASK_ID}\.\*\*\s*(.*)/\1/")
    fi
    
    return 0
  fi
  
  # If not found, try with checkbox already checked
  completed_line=$(grep -n "^\s*-\s*\[\s*x\s*\]\s*\*\*${TASK_ID}\.\*\*" "$PROGRESS_FILE" 2>/dev/null | head -1 | cut -d: -f1 || echo "")
  
  if [ -n "$completed_line" ]; then
    # Extract task description from an already completed task
    TASK_LINE="$completed_line"
    TASK_DESCRIPTION=$(sed -n "${TASK_LINE}p" "$PROGRESS_FILE" | sed -E "s/.*\*\*${TASK_ID}\.\*\*\s*(.*)/\1/")
    echo "Note: Task $TASK_ID appears to be already marked as complete."
    TASK_ALREADY_COMPLETE=true
    
    return 0
  fi
  
  # If still not found, try a more flexible search
  flexible_line=$(grep -n "\*\*${TASK_ID}\." "$PROGRESS_FILE" 2>/dev/null | head -1 | cut -d: -f1 || echo "")
  
  if [ -n "$flexible_line" ]; then
    TASK_LINE="$flexible_line"
    TASK_DESCRIPTION=$(sed -n "${TASK_LINE}p" "$PROGRESS_FILE" | sed -E "s/.*\*\*${TASK_ID}\.\*\*\s*(.*)/\1/")
    return 0
  fi
  
  # If all attempts fail
  echo "Warning: Could not find task description automatically."
  read -p "Please enter task description: " TASK_DESCRIPTION
  if [ -z "$TASK_DESCRIPTION" ]; then
    TASK_DESCRIPTION="Task $TASK_ID implementation"
  fi
  
  return 0
}

# Call the function to find task description
find_task_description

echo "Task Description: $TASK_DESCRIPTION"

# Create commit message based on task description
COMMIT_MESSAGE="Task $TASK_ID: $TASK_DESCRIPTION"

# --- Update Progress Tracker with improved robustness ---
update_progress_tracker() {
  # If task is already complete, skip the update
  if [ "$TASK_ALREADY_COMPLETE" = true ]; then
    echo "Task is already marked as complete in progress tracker. Skipping update."
    return 0
  fi

  echo "Updating progress tracker..."
  
  # Create backup
  cp "$PROGRESS_FILE" "${PROGRESS_FILE}.bak"
  
  # Determine the exact pattern based on the TASK_ID
  SEARCH_PATTERN="-   \[ \] \*\*${TASK_ID}\.\*\*"
  REPLACE_PATTERN="-   [x] **${TASK_ID}.**"
  
  # Debugging output
  echo "Searching for: '$SEARCH_PATTERN'"
  echo "Replacing with: '$REPLACE_PATTERN'"
  
  # Perform the replacement - first attempt with exact pattern
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS version (BSD sed)
    sed -i '' "s/$SEARCH_PATTERN/$REPLACE_PATTERN/g" "$PROGRESS_FILE"
  else
    # Linux version (GNU sed)
    sed -i "s/$SEARCH_PATTERN/$REPLACE_PATTERN/g" "$PROGRESS_FILE"
  fi
  
  # Check if the file was modified with first attempt
  if cmp -s "$PROGRESS_FILE" "${PROGRESS_FILE}.bak"; then
    echo "First attempt failed, trying a more flexible pattern..."
    
    # Restore original file
    cp "${PROGRESS_FILE}.bak" "$PROGRESS_FILE"
    
    # More flexible pattern that handles varying whitespace
    if [[ "$OSTYPE" == "darwin"* ]]; then
      # macOS version - use perl for more complex regex
      perl -i -pe 's/^(\s*-\s*\[)\s*(\]\s*\*\*'"${TASK_ID}"'\.\*\*)/\1x\2/g' "$PROGRESS_FILE"
    else
      # Linux version
      perl -i -pe 's/^(\s*-\s*\[)\s*(\]\s*\*\*'"${TASK_ID}"'\.\*\*)/\1x\2/g' "$PROGRESS_FILE"
    fi
  fi
  
  # Check if the file was modified with second attempt
  if cmp -s "$PROGRESS_FILE" "${PROGRESS_FILE}.bak"; then
    echo "WARNING: Failed to update progress tracker automatically."
    echo "This could be because the task might already be completed or the pattern doesn't match."
    
    # Show the line containing the task for debugging
    echo "Current line in progress tracker:"
    grep -n "${TASK_ID}" "$PROGRESS_FILE" || echo "Task ID not found in file!"
    
    # Ask user if they want to manually edit the file
    read -p "Do you want to manually mark this task as complete? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      # Open the file in the default editor if available
      if [ -n "${EDITOR:-}" ]; then
        $EDITOR "$PROGRESS_FILE"
      elif command -v nano > /dev/null; then
        nano "$PROGRESS_FILE"
      elif command -v vim > /dev/null; then
        vim "$PROGRESS_FILE"
      else
        echo "No editor found. Please manually edit $PROGRESS_FILE to mark task $TASK_ID as complete."
      fi
    fi
  else
    echo "Progress tracker updated successfully."
  fi
  
  # Clean up - only remove if it exists
  if [ -f "${PROGRESS_FILE}.bak" ]; then
    rm -f "${PROGRESS_FILE}.bak"
  fi
}

# Execute progress tracker update
update_progress_tracker

# If NO_COMMIT_FLAG is set, exit here after updating the progress tracker
if [ "$NO_COMMIT_FLAG" = "no_commit" ]; then
  echo "========================================================================"
  echo "✅ TASK $TASK_ID MARKED AS COMPLETE (NO COMMIT MODE)"
  echo "========================================================================"
  echo ""
  echo "Progress tracker has been updated to mark task $TASK_ID as complete."
  echo "No git operations were performed as requested."
  exit 0
fi

# --- Check for uncommitted changes before starting the process ---
echo "Checking for uncommitted changes..."
UNCOMMITTED_CHANGES=$(git status --porcelain || echo "")

if [ -n "$UNCOMMITTED_CHANGES" ]; then
  echo "Found uncommitted changes. Automatically adding and committing them."
  echo "Changes to be committed:"
  echo "$UNCOMMITTED_CHANGES"

  git add .
  git commit -m "feat: $COMMIT_MESSAGE"
  echo "Changes committed successfully."
  
else
  if [ "$TASK_ALREADY_COMPLETE" = true ]; then
    echo "No uncommitted changes found, but proceeding with merge since task was already complete."
  else
    echo "No uncommitted changes found. Proceeding with task completion."
  fi
fi

# Now that we've handled any uncommitted changes, gather the files changed in this branch
echo "Getting changed files..."
FILES_CHANGED=$(git diff --name-only origin/main...HEAD | grep -v "project-documentation/\|scripts/" | tr '\n' ' ' || echo "No non-documentation files changed")

# --- Commit Progress Tracker Changes ---
if [ "$TASK_ALREADY_COMPLETE" = false ]; then
  echo "Committing documentation updates..."
  git add project-documentation/ || echo "No documentation changes to add"
  git commit -m "docs: Update task progress for task ${TASK_ID}" || echo "No documentation changes to commit"
fi

# --- Push and Merge ---
echo "Pushing changes to remote..."
git push -u origin "$CURRENT_BRANCH" || echo "Note: Remote branch may not exist yet. You may need to push manually."

echo "========================================================================"
echo "MERGING CHANGES TO MAIN BRANCH"
echo "========================================================================"
echo "Checking out and updating main branch..."
git checkout main
git pull origin main

echo "Merging task branch into main..."
git merge --no-ff "$CURRENT_BRANCH" -m "merge: $COMMIT_MESSAGE"

echo "Pushing updated main branch..."
git push origin main

echo "========================================================================"
if [ "$TASK_ALREADY_COMPLETE" = true ]; then
  echo "✅ TASK $TASK_ID MERGED (WAS ALREADY MARKED COMPLETE)"
else
  echo "✅ TASK $TASK_ID COMPLETED SUCCESSFULLY!"
fi
echo "========================================================================"
echo ""
if [ "$TASK_ALREADY_COMPLETE" = false ]; then
  echo "Project documentation has been updated:"
  echo "- Progress tracker: Task $TASK_ID marked as complete"
  echo ""
fi
echo "All changes have been merged to main branch."
echo "The project is ready for the next task."

# Return to main branch
git checkout main