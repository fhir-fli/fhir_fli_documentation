#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define directories
BUILD_DIR="build"
DOCS_DIR="docs"

# Ensure dependencies are installed
if [ ! -d "node_modules" ] || [ ! -f "node_modules/.bin/docusaurus" ]; then
  echo "Installing dependencies..."
  npm install
fi

npm run build

echo "Build complete! If you want to deploy manually, run:"
echo "  git checkout gh-pages"
echo "  cp -R build/* ."
echo "  git add . && git commit -m 'Deploy' && git push"
echo ""
echo "Or just push to main and GitHub Actions will auto-deploy to gh-pages"

echo "Deployment complete"

