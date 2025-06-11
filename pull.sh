#!/bin/bash

# Move to the root of the git repository
cd "$(git rev-parse --show-toplevel)" || exit 1

echo "📥 Pulling latest changes from GitHub..."
git pull --rebase

echo "✅ Pull complete."