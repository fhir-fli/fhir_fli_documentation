#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define directories
BUILD_DIR="build"
DOCS_DIR="docs"

npm run build

# Deploy to gh-pages branch (keeps main branch clean of build artifacts)
CURRENT_BRANCH=$(git branch --show-current)
if git show-ref --verify --quiet refs/heads/gh-pages; then
  git checkout gh-pages
else
  git checkout --orphan gh-pages
  git rm -rf . 2>/dev/null || true
fi

# Copy build output to gh-pages
echo "Copying build output to gh-pages branch..."
cp -R "$BUILD_DIR"/* .

# Commit and push
git add .
git commit -m "Deploy Docusaurus site to gh-pages" || true
git push origin gh-pages --force

# Return to original branch
git checkout "$CURRENT_BRANCH"

echo "Deployment complete"

