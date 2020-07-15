#!/usr/bin/env bash

source "base_api.sh"
source "utils.sh"

function traffic_clones() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/traffic/clones")
  echo "$body" | jq -r '.count, .uniques'
}

function traffic_ref() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/traffic/popular/referrers")
  echo "$body" | jq -r '.[] | .referrer, .count, .uniques'
}

function traffic_ref_path() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/traffic/popular/paths")
  echo "$body" | jq -r '.[] | .path, .title, .count, .uniques'
  # You can also replace it with:
  # echo "$body" | jq -r '.[] | "Path: \(.path)\nTitle: \(.title)\nCount: \(.count)\nUniques: \(.uniques)\n"'
  # for more readable output.
}

function traffic_views() {
  local -r TOKEN="$1"
  local -r OWNER="$2"
  local -r REPO="$3"
  body=$(base_api::get "$TOKEN" "repos/$OWNER/$REPO/traffic/views")
  echo "$body" | jq -r '.count, .uniques'
}
