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
sed -i '' "s|<org>/<repo>|npazzaglia/${REPO_NAME}|g" README.md || echo "⚠️ Failed to update README.md"

echo "✅ Updated README repo slugs"

echo "🔐 Configuring GitHub Secrets..."
echo "🔐 Setting up secrets (requires gh auth)"
gh secret set docker_username --body "REPLACE_ME"
gh secret set docker_token --body "REPLACE_ME"

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
