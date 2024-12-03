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
git push origin main

echo "Deployment complete"

