#!/usr/bin/env bash

set -e

# test script should be ran from the project's WD
source "pull_request.sh"

utils::validate_jq

# params are passed from the GitHub action
TOKEN="$1"
OWNER="$2"
GITHUB_REPO="$3"

echo "---= Running PR count test =---"
count=$(prs_count "$TOKEN" "$OWNER" "$GITHUB_REPO")
echo "[INFO] got PRs count of $count"
[[ "$count" -eq 2 ]] || { echo "[X] PR count test failed"; exit 1; }
