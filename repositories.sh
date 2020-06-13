#!/usr/bin/env bash

source "base_api.sh"
source "utils.sh"

function list_user_repositories() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  base_api::get "$TOKEN" "users/$OWNER/repos"
}

function list_user_repositories_name_only() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  body=$(base_api::get "$TOKEN" "users/$OWNER/repos")
  echo "$body" | jq -r '.[] | .name'
}

function get_repository() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r GITHUB_REPO="$3"
  base_api::get "$TOKEN" "repos/$OWNER/$GITHUB_REPO"
}
