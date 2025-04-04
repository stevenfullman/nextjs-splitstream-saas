#!/bin/bash
set -euo pipefail

# SplitStream Project Initializer
# This script initializes a new project with Git, creates a .gitignore file,
# makes an initial commit, and sets up remote repository connection.

echo "========================================================================"
echo "SplitStream Project Initializer"
echo "========================================================================"

# Set GitHub username - HARDCODED
GITHUB_USER="stevenfullman"

# Get the parent directory path
PARENT_DIR="/Users/stevenfullman/Documents/nextjs/nextjs-splitstream-saas"

# Get parent folder name for repository name
PROJECT_NAME=$(basename "$PARENT_DIR")
echo "Parent folder name detected as: $PROJECT_NAME"

# Check if git is already initialized in parent directory
if [ -d "$PARENT_DIR/.git" ]; then
  echo "Git repository already initialized in parent directory."
  read -p "Reinitialize? This will delete existing Git history. (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing existing Git repository..."
    rm -rf "$PARENT_DIR/.git"
  else
    echo "Keeping existing Git repository."
  fi
fi

# Initialize Git if needed in parent directory
if [ ! -d "$PARENT_DIR/.git" ]; then
  echo "Initializing Git repository in parent directory..."
  # Change to parent directory to initialize Git
  cd "$PARENT_DIR"
  git init
  echo "Git repository initialized in parent directory."
else
  # Make sure we're working from the parent directory for subsequent git operations
  cd "$PARENT_DIR"
fi

# Generate comprehensive .gitignore for Node.js/Next.js projects
echo "Generating .gitignore file..."

cat > .gitignore << 'EOF'
# Dependencies
/node_modules
/.pnp
.pnp.js
yarn.lock
package-lock.json

# Testing
/coverage

# Next.js
/.next/
/out/
/build
next-env.d.ts

# Production
/build
/dist

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.pnpm-debug.log*

# Local env files
.env*.local
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Vercel
.vercel

# IDEs and editors
/.idea
.project
.classpath
.c9/
*.launch
.settings/
*.sublime-workspace
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json

# Misc
.DS_Store
*.pem
.env.local
.env.development.local
.env.test.local
.env.production.local
thumbs.db

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.pnpm-debug.log*

# TypeScript
*.tsbuildinfo

# Project documentation backups
*.bak
*.tmp
EOF

echo ".gitignore file created."

# Create README.md if it doesn't exist
if [ ! -f "README.md" ]; then
  echo "Creating README.md..."
  
  # Create a basic README.md
  cat > README.md << EOF
# $PROJECT_NAME

This is the repository for the $PROJECT_NAME project, part of the SplitStream SaaS platform.

## Overview

SplitStream is a testing platform using a multi-armed bandit algorithm to automate and optimize landing page conversion rates.

## Getting Started

Instructions for setting up the development environment will go here.

## Project Structure

Details about the project structure will go here.
EOF

  echo "README.md created."
else
  echo "README.md already exists, skipping creation."
fi

# Perform initial commit
echo "Making initial commit..."
git add .
git commit -m "Initial commit for $PROJECT_NAME project"
echo "Initial commit completed."

# Check if GitHub CLI is installed
if command -v gh &> /dev/null; then
  # Use GitHub CLI to create repo first without trying to add remote
  echo "Checking if repository exists on GitHub..."
  if ! gh repo view "$GITHUB_USER/$PROJECT_NAME" &>/dev/null; then
    echo "Creating new repository on GitHub using GitHub CLI..."
    gh repo create "$PROJECT_NAME" --public --source=. --remote=false
    echo "Repository created at https://github.com/$GITHUB_USER/$PROJECT_NAME"
  else
    echo "Repository already exists on GitHub."
  fi
else
  # Manual method
  echo "GitHub CLI not found. Please create the repository manually on GitHub."
  echo "Repository URL will be: https://github.com/$GITHUB_USER/$PROJECT_NAME"
  read -p "Press Enter when the repository is ready on GitHub..."
fi

# Now manually handle the remote setup
echo "Setting up remote connection..."
REMOTE_URL="https://github.com/$GITHUB_USER/$PROJECT_NAME.git"

# Check if remote is already set up and remove it if needed
if git remote | grep -q "origin"; then
  echo "Remote 'origin' already exists. Removing it to avoid conflicts..."
  git remote remove origin
fi

# Add the remote
echo "Adding remote origin as $REMOTE_URL"
git remote add origin "$REMOTE_URL"

# Make sure we're on main branch
git branch -M main

# Push to remote
echo "Pushing to GitHub..."
git push -u origin main || {
  echo "Push failed. This might be because the repository already exists with content."
  echo "Trying to pull first and then push..."
  git pull --rebase origin main || {
    echo "Pull failed. You may need to resolve conflicts manually."
    echo "Trying force push as last resort..."
    read -p "Force push to remote? This will overwrite any existing content! (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      git push -f -u origin main
    else
      echo "Push aborted. You'll need to resolve this manually."
    fi
  }
  git push -u origin main
}

echo "========================================================================"
echo "✅ PROJECT INITIALIZATION COMPLETED SUCCESSFULLY!"
echo "========================================================================"
echo ""
echo "Next steps:"
echo "1. Review the generated .gitignore and make any necessary changes"
echo "2. Use start-task.sh to begin implementing your first task"
echo "   ./developer-admin/start-task.sh <task-id>"
echo ""
echo "Happy coding!"