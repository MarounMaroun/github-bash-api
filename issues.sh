#!/usr/bin/env bash

source "base_api.sh"

command -v jq >/dev/null 2>&1 || { echo >&2 "Please install 'jq'"; exit 1; }

TOKEN="$1"
OWNER="$2"
GITHUB_REPO="$3"

function list_issues() {
  echo $(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
}

function count_issues() {
  body=$(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
  echo "$body" | jq '. | length'
}

function get_unique_assignee() {
  body=$(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
  echo "$body" | jq -r '.[] | .assignee.login' | uniq -u
}

function get_all_desciptions() {
  body=$(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
  echo "$body" | jq -r '.[] | "\(.assignee.login) \(.body)"'
}
