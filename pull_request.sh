#!/usr/bin/env bash

source "base_api.sh"
source "utils.sh"

function list_prs() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls"
}

function get_pr() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls/$PR_NUM"
}

function get_pr_added_lines() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  pr=$(get_pr "$TOKEN" "$OWNER" "$REPO" "$PR_NUM")
  echo "$pr" | jq '.additions'
}

function get_pr_deleted_lines() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  pr=$(get_pr "$TOKEN" "$OWNER" "$REPO" "$PR_NUM")
  echo "$pr" | jq '.deletions'
}

function list_commits() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls/$PR_NUM/commits"
}

function list_commits_message_only() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls/$PR_NUM/commits")
  echo "$body" | jq -r '.[] | .commit.message'
}

function list_commits_files() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls/$PR_NUM/files")
  echo "$body"
}

function list_commits_files_name_only() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls/$PR_NUM/files")
  echo "$body" | jq -r '.[] | .filename'
}

function list_commits_files_added_name_only() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls/$PR_NUM/files")
  echo "$body" | jq -r 'map(select(.status != "removed")) | .[].filename'
}

function prs_count() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls")
  echo "$body" | jq '. | length'
}

function get_pr_author() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls/$PR_NUM")
  echo "$body" | jq -r '.user.login'
}

function get_pr_changed_files_count() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls/$PR_NUM")
  echo "$body" | jq '.changed_files'
}

function comment_on_pr() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  local -r PAYLOAD="$5"
  # payload should be: {"body": <message>}
  res=$(base_api::post "$TOKEN" "repos/$OWNER/$REPO/issues/$PR_NUM/comments" "$PAYLOAD")
  echo "$res" | jq '.body'
}

function close_pr() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  local -r PAYLOAD="$5"
  # payload should be: {"state": "close", "body": <message>}
  base_api::patch "$TOKEN" "repos/$OWNER/$REPO/pulls/$PR_NUM" "$PAYLOAD"
}

function get_pr_labels() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/issues/$PR_NUM")
  echo "$body" | jq -r '.labels[].name'
}

function add_pr_label() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  local -r PAYLOAD="$5"
  # payload should be: {"labels": ["label2", "label2"]}
  base_api::post "$TOKEN" "repos/$OWNER/$REPO/issues/$PR_NUM/labels" "$PAYLOAD"
}

function remove_pr_label() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  local -r PAYLOAD="$5"
  # payload should be the name of the label
  base_api::delete "$TOKEN" "repos/$OWNER/$REPO/issues/$PR_NUM/labels/$PAYLOAD"
}

function get_base_branch() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  local -r PR_NUM="$4"
  # payload should be the name of the label
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/pulls/$PR_NUM")
  echo "$body" | jq -r '.head.ref'
}
