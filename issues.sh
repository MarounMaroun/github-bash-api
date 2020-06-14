#!/usr/bin/env bash

source "base_api.sh"
source "utils.sh"

function list_issues() {
  local  -r TOKEN="$1"
  local -r OWNER="$2"
  local -r GITHUB_REPO="$3"
  base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues"
}

function count_issues() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r GITHUB_REPO="$3"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
  echo "$body" | jq 'map(select(.pull_request == null)) | length'
}

function get_unique_assignee() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r GITHUB_REPO="$3"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
  echo "$body" | jq -r '.[] | .assignee.login' | uniq -u
}

function add_issue_label() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r GITHUB_REPO="$3"
  local -r ISSUE_NUM="$4"
  local -r PAYLOAD="$5"
  # payload should be: {"labels": ["label2", "label2"]}
  base_api::post "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues/$ISSUE_NUM/labels" "$PAYLOAD"
}

function remove_issue_label() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r GITHUB_REPO="$3"
  local -r ISSUE_NUM="$4"
  local -r PAYLOAD="$5"
  # payload should be the name of the label
  base_api::delete "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues/$ISSUE_NUM/labels/$PAYLOAD"
}

function get_all_desciptions() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r GITHUB_REPO="$3"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
  echo "$body" | jq -r '.[] | "\(.assignee.login) \(.body)"'
}
