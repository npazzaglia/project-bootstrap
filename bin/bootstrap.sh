#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Verifying GitHub CLI auth..."
if ! gh auth status &>/dev/null; then
  echo "❌ GitHub CLI is not authenticated. Run 'gh auth login' first."
  exit 1
fi

REPO_INFO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || echo "unknown/repo")
echo "📦 Repo: $REPO_INFO"

EXPECTED_REPO="${EXPECTED_REPO:-$REPO_INFO}"
if [[ "$REPO_INFO" != "$EXPECTED_REPO" ]]; then
  echo "⚠️  WARNING: You are running bootstrap on '$REPO_INFO', expected '$EXPECTED_REPO'" >&2
  read -p "Proceed anyway? [y/N] " -r
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Aborted by user." >&2
    exit 1
  fi
fi

echo "📁 Checking post-fork assets..."
[[ -f bin/post-fork.sh ]] || { echo "❌ Missing bin/post-fork.sh"; exit 1; }
[[ -f bin/post-fork.conf ]] || { echo "❌ Missing bin/post-fork.conf"; exit 1; }

echo "🚀 Running post-fork automation..."
echo "🛠 Rewriting README badge placeholders..."
if command -v gh &> /dev/null; then
  SLUG=$(gh repo view --json nameWithOwner -q .nameWithOwner)
else
  SLUG=$(git remote get-url origin | sed -E 's/.*github.com[/:]([^/]+\/[^.]+)(\.git)?/\1/')
fi

if [[ -n "$SLUG" && "$SLUG" != "unknown/repo" ]]; then
  sed -i.bak "s|<org>/<repo>|$SLUG|g" README.md && rm README.md.bak
  echo "✅ Rewrote badges to use: $SLUG"
else
  echo "⚠️  Could not detect repo slug. Leaving README badge links unchanged."
fi
echo "📜 post-fork.conf contents:"
cat bin/post-fork.conf
echo ""
bash bin/post-fork.sh
