#!/usr/bin/env bash

source "base_api.sh"
source "utils.sh"

utils::validate_jq

TOKEN="$1"
OWNER="$2"
GITHUB_REPO="$3"

function list_user_repositories() {
  base_api::call "$TOKEN" "users/$OWNER/repos"
}

function list_user_repositories_name_only() {
  body=$(base_api::call "$TOKEN" "users/$OWNER/repos")
  echo "$body" | jq -r '.[] | .name'
}

function get_repository() {
  base_api::call "$TOKEN" "repos/$OWNER/$GITHUB_REPO"
}
