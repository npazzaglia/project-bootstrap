#!/bin/bash

# Ensure GitHub CLI is installed and authenticated
if ! command -v gh &> /dev/null; then
  echo "GitHub CLI (gh) is not installed. Please install it first."
  exit 1
fi

TEMPLATE_REPO="npazzaglia/repo-template"
TEMPLATE_REMOTE="upstream"
LOCAL_TMP_DIR="./.tmp-template-sync"

# Create temp workspace
mkdir -p "$LOCAL_TMP_DIR"
cd "$LOCAL_TMP_DIR" || exit 1

# Get list of forks from your personal account
gh repo list npazzaglia --fork --json nameWithOwner -q '.[].nameWithOwner' | while read -r fork; do
  echo "Syncing template into $fork..."

  git clone "git@github.com:$fork.git" "$fork-dir"
  cd "$fork-dir" || continue

  if ! git remote | grep -q "$TEMPLATE_REMOTE"; then
    git remote add "$TEMPLATE_REMOTE" "git@github.com:$TEMPLATE_REPO.git"
  fi

  git fetch "$TEMPLATE_REMOTE"
  git merge "$TEMPLATE_REMOTE/main" --allow-unrelated-histories --no-edit || echo "Merge conflict in $fork – manual fix needed."
  git push origin main

  cd ..
  rm -rf "$fork-dir"
done

# Clean up
cd ../..
rm -rf "$LOCAL_TMP_DIR"

echo "✅ Sync complete."
