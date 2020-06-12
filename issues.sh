#!/usr/bin/env bash

source "base_api.sh"
source "utils.sh"

utils::validate_jq

TOKEN="$1"
OWNER="$2"
GITHUB_REPO="$3"
ISSUE_NUM="$4"
PAYLOAD="$5"

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

function add_issue_label() {
  # payload should be: {"labels": ["label2", "label2"]}
  base_api::post "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues/$ISSUE_NUM/labels" "$PAYLOAD"
}

function remove_issue_label() {
  # payload should be the name of the label
  base_api::delete "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues/$ISSUE_NUM/labels/$PAYLOAD"
}

function get_all_desciptions() {
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues")
  echo "$body" | jq -r '.[] | "\(.assignee.login) \(.body)"'
}
