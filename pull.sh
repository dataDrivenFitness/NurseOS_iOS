#!/usr/bin/env bash
set -e

# Jump to repo root
cd "$(git rev-parse --show-toplevel)" || exit 1

BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "📥  Pulling latest changes on $BRANCH …"
git pull --rebase --autostash
echo "✅  Pull complete."
