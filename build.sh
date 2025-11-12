#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define directories
BUILD_DIR="build"
DOCS_DIR="docs"

npm run build

# Copy the contents of the build directory to the docs directory
echo "Copying contents of $BUILD_DIR to $DOCS_DIR..."
cp -R "$BUILD_DIR"/* "$DOCS_DIR"

git add .
git commit -m "Deploy Docusaurus site to docs folder"

# Push to main branch
git push origin main

# Also push the built files to gh-pages branch for GitHub Pages
CURRENT_BRANCH=$(git branch --show-current)
if git show-ref --verify --quiet refs/heads/gh-pages; then
  git checkout gh-pages
else
  git checkout --orphan gh-pages
fi
git rm -rf . 2>/dev/null || true
cp -R "$BUILD_DIR"/* .
git add .
git commit -m "Deploy Docusaurus site to gh-pages" || true
git push origin gh-pages --force
git checkout "$CURRENT_BRANCH"

echo "Deployment complete"

