#!/bin/bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

echo "🔧 Running post-fork setup..."

# Check remotes
origin_url=$(git remote get-url origin 2>/dev/null || echo "")
upstream_url=$(git remote get-url upstream 2>/dev/null || echo "")

if [[ -z "$upstream_url" ]]; then
  echo "⚠️  No upstream remote configured."
elif [[ "$origin_url" == "$upstream_url" ]]; then
  echo "⚠️  origin and upstream remotes point to the same URL."
fi

REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
echo "📁 Repo detected: $REPO_NAME"
if command -v gh &> /dev/null; then
  SLUG=$(gh repo view --json nameWithOwner -q .nameWithOwner)
else
  SLUG=$(git remote get-url origin | sed -E 's@.*github.com[/:]([^/]+/[^.]+)(\.git)?@\1@')
fi
sed -i.bak "s|<org>/<repo>|$SLUG|g" README.md && rm README.md.bak || echo "⚠️ Failed to update README.md"

echo "✅ Updated README repo slugs"

echo "🔐 Configuring GitHub Secrets..."
echo "🔐 Setting up secrets (requires gh auth)"
: "${DOCKER_USERNAME:?Set DOCKER_USERNAME environment variable}"
: "${DOCKER_TOKEN:?Set DOCKER_TOKEN environment variable}"
gh secret set docker_username --body "$DOCKER_USERNAME"
gh secret set docker_token --body "$DOCKER_TOKEN"

echo "📌 Enabling GitHub features"
gh repo edit --enable-issues=true --enable-projects=true --enable-discussions=true

if git rev-parse "v0.1.0-alpha" >/dev/null 2>&1; then
  echo "ℹ️ Tag v0.1.0-alpha already exists. Skipping tag creation."
else
  git tag v0.1.0-alpha
  git push origin v0.1.0-alpha
  echo "🏷️  Tagged initial version as v0.1.0-alpha"
fi

echo "Post-fork complete"

