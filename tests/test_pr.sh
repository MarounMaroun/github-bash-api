#!/usr/bin/env bash

# test script should be ran from the project's WD
source "pull_request.sh"

utils::validate_jq

# params are passed from the GitHub action
TOKEN="$1"
OWNER="$2"
GITHUB_REPO="$3"

count=$(prs_count "$TOKEN" "$OWNER" "$GITHUB_REPO")
[[ "$count" -eq 2 ]] || { echo "PR count test failed"; exit 1; }
