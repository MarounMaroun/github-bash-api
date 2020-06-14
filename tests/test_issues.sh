#!/usr/bin/env bash

set -e

# test script should be ran from the project's WD
source "issues.sh"

utils::validate_jq

# params are passed from the GitHub action
TOKEN="$1"
OWNER="$2"
GITHUB_REPO="$3"

echo "---= Running issue count test =---"
count=$(count_issues "$TOKEN" "$OWNER" "$GITHUB_REPO")
echo "[INFO] got issues count of $count"
[[ "$count" -eq 1 ]] || { echo "[X] issues count test failed"; exit 1; }

echo "---= Running issue title test =---"
title=$(get_issue_title "$TOKEN" "$OWNER" "$GITHUB_REPO" 3)
echo "[INFO] got issue title '$title'"
[[ "$title" == "this is the first issue" ]] || { echo "[X] issue title test failed"; exit 1; }
