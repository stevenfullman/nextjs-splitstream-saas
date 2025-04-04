#!/bin/bash
# Usage: ./start-task.sh <task-id>
# Example: ./start-task.sh 1.1.1

# Check if task ID is provided
if [ -z "$1" ]; then
  echo "Error: Task ID is required"
  echo "Usage: ./start-task.sh <task-id>"
  echo "Example: ./start-task.sh 1.1.1"
  exit 1
fi

TASK_ID=$1

# Create branch name
BRANCH_NAME="task-${TASK_ID}"

# Make sure we're on main branch first and up to date
echo "Checking out main branch..."
git checkout main
git pull

# Check if branch exists and checkout or create it
echo "Checking branch: $BRANCH_NAME"
if git show-ref --verify --quiet "refs/heads/$BRANCH_NAME"; then
  echo "Branch $BRANCH_NAME already exists, checking it out..."
  git checkout "$BRANCH_NAME"
  # Pull latest changes if branch exists remotely
  if git ls-remote --exit-code origin "$BRANCH_NAME" >/dev/null 2>&1; then
    git pull origin "$BRANCH_NAME"
  fi
else
  echo "Creating and checking out branch: $BRANCH_NAME"
  git checkout -b "$BRANCH_NAME"
  # Push the new branch to remote
  git push -u origin "$BRANCH_NAME"
fi

echo "✅ Task $TASK_ID branch ready!"
echo "You are now ready to start working on task $TASK_ID"
echo "When finished, run ./complete-task.sh $TASK_ID"