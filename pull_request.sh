#!/usr/bin/env bash

source "base_api.sh"
source "utils.sh"

utils::validate_jq

TOKEN="$1"
OWNER="$2"
GITHUB_REPO="$3"
PR_NUM="$4"
BODY="$5"

function list_prs() {
  base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls"
}

function get_pr() {
  base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM"
}

function list_commits() {
  base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM/commits"
}

function list_commits_message_only() {
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM/commits")
  echo "$body" | jq -r '.[] | .commit.message'
}

function list_commits_files() {
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM/files")
  echo "$body"
}

function list_commits_files_name_only() {
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM/files")
  echo "$body" | jq -r '.[] | .filename'
}

function prs_count() {
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls")
  echo "$body" | jq '. | length'
}

function get_pr_author() {
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM")
  echo "$body" | jq '.user.login'
}

function get_pr_changed_files_count() {
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM")
  echo "$body" | jq '.changed_files'
}

function comment_on_pr() {
  res=$(base_api::post "$TOKEN" "repos/$OWNER/$GITHUB_REPO/issues/$PR_NUM/comments" "{\"body\": \"$BODY\"}")
  echo "$res" | jq '.body'
}
