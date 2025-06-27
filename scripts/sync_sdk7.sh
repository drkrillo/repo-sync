#!/bin/bash
set -e

REPO_DEST="drkrillo/dcl-sdk7-docs"
SOURCE_REPO="https://github.com/decentraland/documentation.git"
SUBFOLDER="content/creators/sdk7"
TARGET_BRANCH="main"

echo "▶ Cloning source repo..."
git clone --no-single-branch --depth=1 "$SOURCE_REPO" source-repo
ls -R source-repo/content/creators
cd source-repo

echo "▶ Creating subtree branch for $SUBFOLDER"
git subtree split --prefix=$SUBFOLDER -b sdk7-only

echo "▶ Pushing to $REPO_DEST"
git config --global user.name "github-actions[bot]"
git config --global user.email "github-actions[bot]@users.noreply.github.com"

git remote add target https://x-access-token:${PERSONAL_TOKEN}@github.com/$REPO_DEST.git
git push target sdk7-only:$TARGET_BRANCH --force

