#!/bin/bash
set -euo pipefail

echo "🔧 Running post-fork setup..."

REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
sed -i '' "s|<org>/<repo>|npazzaglia/${REPO_NAME}|g" README.md || true

echo "✅ Updated README repo slugs"

echo "🔐 Setting up secrets (requires gh auth)"
gh secret set docker_username --body "REPLACE_ME"
gh secret set docker_token --body "REPLACE_ME"

echo "📌 Enabling GitHub features"
gh repo edit --enable-issues=true --enable-projects=true --enable-discussions=true

echo "🏷️  Tagging initial version"
git tag v0.1.0-alpha
git push origin v0.1.0-alpha

echo "✅ Post-fork setup complete."
