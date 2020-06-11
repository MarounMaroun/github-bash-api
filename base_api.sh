#!/usr/bin/env bash

GITHUB_API_HEADER="Accept: application/vnd.github.v3+json"
GITHUB_API_URI="https://api.github.com"

base_api::get() {
  local -r token="$1"
  local -r api="$2"
  body=$(curl -sSL -H "Authorization: token $token" -H "$GITHUB_API_HEADER" "$GITHUB_API_URI/$api")
  echo "$body"
}

base_api::post() {
  local -r token="$1"
  local -r api="$2"
  local -r data="$3"
  body=$(curl -XPOST -sSL -H "Authorization: token $token" -H "$GITHUB_API_HEADER" "$GITHUB_API_URI/$api" --data "$data")
  echo "$body"
}

base_api::patch() {
  local -r token="$1"
  local -r api="$2"
  local -r data="$3"
  body=$(curl -XPATCH -sSL -H "Authorization: token $token" -H "$GITHUB_API_HEADER" "$GITHUB_API_URI/$api" --data "$data")
  echo "$body"
}
