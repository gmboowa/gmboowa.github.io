#!/bin/bash

# Remove all .webp images from the specified directory
rm -rf /Users/gerald/gmboowa.github.io/_site/assets/img/*.webp

# Copy the _site directory to a temporary location
cp -r _site /tmp/

# Create and switch to a new branch named "gh-pages"
git branch -D gh-pages

git checkout -b gh-pages

# Remove all files in the current directory
rm -rf *

# Copy the contents from the temporary _site directory to the current directory
cp -r /tmp/_site/* ./

# Add all changes to the staging area
git add .

# Configure Git to always rebase during pull
git config pull.rebase true

# Commit the changes with a commit message
git commit -m "your commit message"

# Force push the changes to the gh-pages branch
git push origin gh-pages --force
