#!/usr/bin/env bash
# Keep successful build output concise while preserving diagnostics. If a
# container command fails, emit its full log so the original error is visible.
run_container_quietly() {
  local log_file
  log_file="$(mktemp "${TMPDIR:-/tmp}/xynoplex-container-build.XXXXXX")"
  if "$@" >"$log_file" 2>&1; then
    grep -Ei 'npm warn|warning:|(^|[[:space:]])warning([[:space:]]|$)|warn:|error:|NETSDK[0-9]+: warning|missing a readme' "$log_file" || true
    rm -f "$log_file"
  else
    local status=$?
    cat "$log_file" >&2
    rm -f "$log_file"
    return "$status"
  fi
}
