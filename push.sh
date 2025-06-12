#!/usr/bin/env bash
set -e

# Jump to repo root
cd "$(git rev-parse --show-toplevel)" || exit 1

# Commit message: first CLI arg → msg; none → open interactive editor
if [ -n "$1" ]; then
  MSG=$1
  echo "📝  Committing with message: \"$MSG\""
  git add -A
  git commit -m "$MSG"
else
  echo "📝  No commit message arg -> opening interactive commit."
  git add -A
  git commit
fi

# Push to current branch, set upstream if needed
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "🚀  Pushing $BRANCH to origin …"
git push -u origin "$BRANCH"

# Optional: open PR in default browser if branch ≠ dev/main
if [[ "$BRANCH" != "dev" && "$BRANCH" != "main" ]]; then
  REMOTE_URL=$(git config --get remote.origin.url)
  # Convert git@github.com:org/repo.git → https://github.com/org/repo
  HTTPS_URL=${REMOTE_URL/git@github.com:/https://github.com/}
  HTTPS_URL=${HTTPS_URL%.git}
  open "$HTTPS_URL/compare/$BRANCH?expand=1" 2>/dev/null || true
  echo "🔗  Opened PR URL for $BRANCH"
fi

echo "✅  Done."
