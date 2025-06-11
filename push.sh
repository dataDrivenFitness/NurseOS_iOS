#!/bin/bash

# Move to the root of the git repository
cd "$(git rev-parse --show-toplevel)" || exit 1

# Usage: ./push.sh "Your commit message here"
if [ -z "$1" ]; then
  echo "❌ Error: Please provide a commit message."
  echo "Usage: ./push.sh \"Your commit message here\""
  exit 1
fi

echo "📂 Adding all changes..."
git add .

echo "📝 Committing with message: $1"
git commit -m "$1"

echo "🚀 Pushing to GitHub..."
git push

echo "✅ Done."