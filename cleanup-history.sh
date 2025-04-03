#!/bin/bash

# Create backup of current repository
echo "Creating backup of repository..."
git clone --mirror . backup/repo.git

echo "Cleaning repository history..."

# Remove large files from history
git filter-repo --path-glob '**/*.zip' --invert-paths --force
git filter-repo --path-glob '**/*.crx' --invert-paths --force
git filter-repo --path-glob '**/*.xpi' --invert-paths --force
git filter-repo --path-glob '**/*.txt' --invert-paths --force
git filter-repo --path-glob '**/*.webm' --invert-paths --force
git filter-repo --path-glob '**/*.mp4' --invert-paths --force

echo "Cleaning up unnecessary files..."
# Remove files from working directory that are now ignored
git rm -r --cached dist/*.zip 2>/dev/null || true
git rm -r --cached dist/*.crx 2>/dev/null || true
git rm -r --cached dist/*.xpi 2>/dev/null || true
git rm -r --cached assets/thirdparties/*.txt 2>/dev/null || true
git rm -r --cached doc/media/*.webm 2>/dev/null || true
git rm -r --cached doc/media/*.mp4 2>/dev/null || true

echo "Committing changes..."
git commit -m "Clean up repository: remove large files from history"

echo "Repository cleanup complete!"
echo "A backup has been created in the 'backup' directory."
echo "You can now force push the changes to the remote repository."
