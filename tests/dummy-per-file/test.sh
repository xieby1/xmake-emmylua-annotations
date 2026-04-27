#!/usr/bin/env bash
set -euo pipefail

set +e
output=$(env LUA_PATH="$(realpath ../..)/?.lua" emmylua_check . 2>&1)
status=$?
set -e

printf '%s\n' "$output"

if [ "$status" -eq 0 ]; then
  printf 'Expected stock emmylua_check to reject per-file xmake annotations loaded only via require/LUA_PATH.\n' >&2
  exit 1
fi

[[ "$output" == *"undefined global variable: target"* ]] || {
  printf 'Expected undefined-global diagnostic for target().\n' >&2
  exit 1
}

[[ "$output" == *"undefined global variable: target_end"* ]] || {
  printf 'Expected undefined-global diagnostic for target_end().\n' >&2
  exit 1
}

