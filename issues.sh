#!/usr/bin/env bash

source "base_api.sh"
source "utils.sh"

utils::validate_jq

TOKEN="$1"
OWNER="$2"
GITHUB_REPO="$3"

function list_issues() {
  base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues"
}

function count_issues() {
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
  echo "$body" | jq '. | length'
}

function get_unique_assignee() {
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
  echo "$body" | jq -r '.[] | .assignee.login' | uniq -u
}

function get_all_desciptions() {
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
  echo "$body" | jq -r '.[] | "\(.assignee.login) \(.body)"'
}
