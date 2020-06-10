#!/usr/bin/env bash

source "base_api.sh"

command -v jq >/dev/null 2>&1 || { echo >&2 "Please install 'jq'"; exit 1; }

TOKEN="$1"
OWNER="$2"
GITHUB_REPO="$3"
PR_NUM="$4"

function list_prs() {
  echo $(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls")
}

function get_pr() {
  echo $(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM")
}

function list_commits() {
  echo $(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM/commits")
}

function list_commits_message_only() {
  body=$(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM/commits")
  echo "$body" | jq -r '.[] | .commit.message'
}

function list_commits_files() {
  body=$(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM/files")
  echo "$body"
}

function list_commits_files_name_only() {
  body=$(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls/$PR_NUM/files")
  echo "$body" | jq -r '.[] | .filename'
}

function prs_count() {
  body=$(base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO/pulls")
  echo "$body" | jq '. | length'
}
