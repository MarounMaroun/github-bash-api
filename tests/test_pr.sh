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
[[ "$count" -eq 3 ]] || { echo "[X] PR count test failed"; exit 1; }

echo "---= Running PR author test =---"
author=$(get_pr_author "$TOKEN" "$OWNER" "$GITHUB_REPO" 1)
echo "[INFO] got PR #1 author $author"
[[ "$author" -eq "MarounMaroun" ]] || { echo "[X] PR author test failed"; exit 1; }

echo "---= Running PR base branch test =---"
base_branch=$(get_base_branch "$TOKEN" "$OWNER" "$GITHUB_REPO" 1)
echo "[INFO] got base branch $base_branch for PR #1"
[[ "$base_branch" -eq "pr1" ]] || { echo "[X] PR base branch test failed"; exit 1; }

echo "---= Running PR additions count =---"
additions=$(get_pr_added_lines "$TOKEN" "$OWNER" "$GITHUB_REPO" 1)
echo "[INFO] got added lines count $additions for PR #1"
[[ "$additions" -eq 1 ]] || { echo "[X] PR additions count test failed"; exit 1; }
