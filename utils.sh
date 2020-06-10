#!/usr/bin/env bash

utils::validate_jq() {
  command -v jq >/dev/null 2>&1 || { echo >&2 "Please install 'jq'"; exit 1; }
}
