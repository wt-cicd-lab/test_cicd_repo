#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

git rev-parse --verify HEAD >/dev/null
git fetch --prune origin '+refs/tags/*:refs/tags/*'

existing="$(git tag --points-at HEAD | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1 || true)"
if [[ -n "$existing" ]]; then
    echo "Commit already has version tag: $existing"
    exit 0
fi

latest="$(git tag --list | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1 || true)"
if [[ -z "$latest" ]]; then
    next=0.1.0
else
    IFS=. read -r major minor patch <<< "$latest"
    next="$major.$minor.$((10#$patch + 1))"
fi

git -c tag.gpgSign=false tag -a "$next" -m "Release $next" HEAD
git push origin "refs/tags/$next:refs/tags/$next"
echo "Created and pushed version tag: $next"
