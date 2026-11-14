#!/usr/bin/env bash

require_protocol_pin() {
  local root="$1"
  local expected actual status

  if [[ ! -d "$root/protocol/specs/src" ]]; then
    echo 'The pinned protocol submodule is missing. Initialize it with: git submodule update --init --recursive' >&2
    return 1
  fi

  expected="$(git -C "$root" ls-tree HEAD protocol | awk '{print $3}')"
  actual="$(git -C "$root/protocol" rev-parse HEAD)"
  if [[ -z "$expected" || "$actual" != "$expected" ]]; then
    echo "Protocol checkout does not match the SDK's pinned submodule revision (${expected:-missing})." >&2
    return 1
  fi

  status="$(git -C "$root/protocol" status --porcelain --untracked-files=all)"
  if [[ -n "$status" ]]; then
    echo 'The pinned protocol submodule has local changes; commit and pin them before building SDK artifacts.' >&2
    return 1
  fi

  printf '%s\n' "$expected"
}
