#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Verifying GitHub CLI auth..."
if ! gh auth status &>/dev/null; then
  echo "❌ GitHub CLI is not authenticated. Run 'gh auth login' first."
  exit 1
fi

REPO_INFO=$(gh repo view --json nameWithOwner -q .nameWithOwner || echo "unknown/repo")
echo "📦 Repo: $REPO_INFO"

EXPECTED_REPO="pazztech/project-bootstrap"
if [[ "$REPO_INFO" != "$EXPECTED_REPO" ]]; then
  echo "⚠️  WARNING: You are running bootstrap on '$REPO_INFO', expected '$EXPECTED_REPO'"
  read -p "Proceed anyway? [y/N] " -r
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Aborted by user."
    exit 1
  fi
fi

echo "📁 Checking post-fork assets..."
[[ -f bin/post-fork.sh ]] || { echo "❌ Missing bin/post-fork.sh"; exit 1; }
[[ -f bin/post-fork.conf ]] || { echo "❌ Missing bin/post-fork.conf"; exit 1; }

echo "🚀 Running post-fork automation..."
bash bin/post-fork.sh