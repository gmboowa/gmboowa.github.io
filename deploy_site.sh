#!/bin/bash
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_SITE="/tmp/gmboowa_site_deploy"

cd "$REPO"

echo "Switching to master source branch..."
git switch master

echo "Pulling latest source changes..."
git pull --rebase origin master

echo "Cleaning and rebuilding Jekyll site..."
bundle exec jekyll clean
bundle exec jekyll build

echo "Removing old temporary deployment folder..."
rm -rf "$TMP_SITE"

echo "Copying rebuilt _site to temporary location..."
cp -R _site "$TMP_SITE"

echo "Switching to gh-pages deployment branch..."
git fetch origin
git switch gh-pages

echo "Resetting gh-pages to remote version..."
git reset --hard origin/gh-pages

echo "Cleaning gh-pages branch while preserving .git..."
find . -mindepth 1 ! -name ".git" ! -path "./.git/*" -exec rm -rf {} +

echo "Copying rebuilt site into gh-pages branch..."
cp -R "$TMP_SITE"/* ./

echo "Adding .nojekyll..."
touch .nojekyll

echo "Committing deployment..."
git add .

if git diff --cached --quiet; then
  echo "No changes detected in built site. Nothing to deploy."
else
  git commit -m "Update personal website"
  git push origin gh-pages --force-with-lease
fi

echo "Returning to master branch..."
git switch master

echo "Deployment complete."