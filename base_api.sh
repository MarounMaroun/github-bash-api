#!/usr/bin/env bash

GITHUB_API_HEADER="Accept: application/vnd.github.v3+json"
GITHUB_API_URI="https://api.github.com"

base_api::call() {
  local -r token="$1"
  local -r api="$2"
  body=$(curl -sSL -H "Authorization: token $token" -H "$GITHUB_API_HEADER" "$GITHUB_API_URI/$api")
  echo "$body"
}
