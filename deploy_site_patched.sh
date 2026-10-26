#!/bin/bash
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_SITE="$(mktemp -d "${TMPDIR:-/tmp}/gmboowa_site_deploy.XXXXXXXX")"
DEPLOY_STARTED=0

cleanup() {
  code=$?
  trap - EXIT
  if [[ "$DEPLOY_STARTED" -eq 1 ]]; then
    cd "$REPO"
    if [[ "$(git branch --show-current)" == "gh-pages" ]]; then
      if ! git switch master; then
        echo "WARNING: Could not switch to master automatically. Check 'git status'." >&2
      fi
    fi
  fi
  rm -rf -- "$TMP_SITE"
  exit "$code"
}
trap cleanup EXIT

cd "$REPO"

echo "Switching to master source branch..."
git switch master

echo "Checking source working tree before pull..."
if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
  echo "ERROR: Tracked source files have uncommitted changes. Commit or stash them before deploying." >&2
  exit 1
fi

echo "Pulling latest source changes..."
git pull --rebase origin master

echo "Cleaning and rebuilding Jekyll site..."
bundle exec jekyll clean
bundle exec jekyll build

echo "Copying rebuilt _site to temporary location..."
cp -R _site/. "$TMP_SITE/"

echo "Switching to gh-pages deployment branch..."
git fetch origin
git switch gh-pages
DEPLOY_STARTED=1

echo "Resetting gh-pages to remote version..."
git reset --hard origin/gh-pages

echo "Cleaning gh-pages top-level entries while preserving .git..."
# Only visit top-level entries; recursive find + rm can delete directories
# while find is still traversing them, causing 'No such file' errors.
find . -mindepth 1 -maxdepth 1 ! -name '.git' -exec rm -rf -- {} +

echo "Copying rebuilt site into gh-pages branch (including dotfiles)..."
cp -R "$TMP_SITE"/. ./

echo "Adding .nojekyll..."
touch .nojekyll

echo "Committing deployment..."
git add -A

if git diff --cached --quiet; then
  echo "No changes detected in built site. Nothing to deploy."
else
  git commit -m "Update personal website"
  git push origin gh-pages
fi

echo "Deployment complete. Returning to master branch..."
