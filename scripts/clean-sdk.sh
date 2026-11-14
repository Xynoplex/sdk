#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
CACHE_ROOT="${XDG_CACHE_HOME:-$HOME/.cache}/xynoplex-sdk"
STATE_ROOT="$CACHE_ROOT/local"
OPAM_VOLUME=xynoplex-sdk-opam-5-5
LANGUAGES=(typescript python rust go csharp haskell kotlin ocaml swift)

remove_path() {
  local path="$1"
  [[ -e "$path" || -L "$path" ]] || return 0
  # Go marks module-cache directories read-only. Make directories writable by
  # their owner so removing SDK-owned outputs works on macOS and Linux alike.
  if [[ -d "$path" ]]; then
    find "$path" -type d -exec chmod u+rwx {} +
  fi
  rm -rf "$path"
}

clean_language() {
  local language="$1"
  local source_root="$ROOT/$language"
  local -a cache_paths=()

  case "$language" in
    typescript) cache_paths=("$STATE_ROOT/npm") ;;
    python) cache_paths=("$STATE_ROOT/python" "$STATE_ROOT/uv-cache") ;;
    rust) cache_paths=("$STATE_ROOT/rust") ;;
    go) cache_paths=("$STATE_ROOT/go-proxy" "$STATE_ROOT/go-mod-cache" "$STATE_ROOT/go-build-cache") ;;
    csharp) cache_paths=("$STATE_ROOT/nuget" "$STATE_ROOT/nuget-cache") ;;
    haskell) cache_paths=("$STATE_ROOT/haskell" "$STATE_ROOT/cabal-cache" "$STATE_ROOT/haskell-build") ;;
    kotlin) cache_paths=("$STATE_ROOT/kotlin-maven" "$STATE_ROOT/gradle-cache" "$STATE_ROOT/kotlin-publish.init.gradle") ;;
    ocaml) cache_paths=("$STATE_ROOT/opam-repo") ;;
    swift) cache_paths=("$STATE_ROOT/swift" "$STATE_ROOT/swift-cache" "$STATE_ROOT/swift-build") ;;
    *) echo "Unknown SDK language: $language" >&2; return 2 ;;
  esac

  printf '==> Cleaning %s build outputs and local artifacts\n' "$language"
  if [[ -d "$source_root" ]]; then
    while IFS= read -r -d '' output; do
      remove_path "$output"
    done < <(find "$source_root" -type d \
      \( -name node_modules -o -name dist -o -name target -o -name .gradle \
      -o -name build -o -name obj -o -name .build -o -name dist-newstyle \
      -o -name _build -o -name __pycache__ -o -name .pytest_cache \
      -o -name .mypy_cache -o -name .ruff_cache -o -name .tox -o -name .venv \
      -o -name coverage -o -name .coverage \) \
      -prune -print0)
  fi
  for path in "${cache_paths[@]}"; do
    remove_path "$path"
  done
  if [[ "$language" == ocaml ]]; then
    remove_named_volume "$OPAM_VOLUME"
  fi
}

remove_named_volume() {
  local name="$1" runtime
  runtime="$(available_runtime 2>/dev/null || true)"
  [[ -n "$runtime" ]] || return 0
  if "$runtime" volume inspect "$name" >/dev/null 2>&1; then
    printf '    Removing container volume %s\n' "$name"
    "$runtime" volume rm "$name" >/dev/null
  fi
}

available_runtime() {
  local candidate
  if [[ -n "${CONTAINER_RUNTIME:-}" ]]; then
    command -v "$CONTAINER_RUNTIME" >/dev/null 2>&1 || return 1
    candidate="$CONTAINER_RUNTIME"
    case "$(basename "$candidate")" in
      container) "$candidate" system status >/dev/null 2>&1 || return 1 ;;
      *) "$candidate" info >/dev/null 2>&1 || return 1 ;;
    esac
    printf '%s\n' "$candidate"
    return
  fi
  for candidate in container docker podman; do
    command -v "$candidate" >/dev/null 2>&1 || continue
    if [[ "$candidate" == container ]]; then
      "$candidate" system status >/dev/null 2>&1 || continue
    else
      "$candidate" info >/dev/null 2>&1 || continue
    fi
    printf '%s\n' "$candidate"
    return
  done
  return 1
}

clean_local_artifacts() {
  local runtime name
  printf '==> Cleaning shared local artifact state and cached bundles\n'
  remove_path "$STATE_ROOT"
  remove_path "$CACHE_ROOT/bundles"

  runtime="$(available_runtime 2>/dev/null || true)"
  if [[ -z "$runtime" ]]; then
    echo '    Container runtime unavailable; skipped removal of retired registry containers.'
    return
  fi
  for name in xynoplex-sdk-local-npm xynoplex-sdk-local-pypi xynoplex-sdk-local-cargo; do
    if [[ "$(basename "$runtime")" == container ]]; then
      if "$runtime" list --all --format table | awk -v name="$name" '$1 == name { found=1 } END { exit !found }'; then
        printf '    Removing retired registry container %s\n' "$name"
        "$runtime" stop "$name" >/dev/null 2>&1 || true
        "$runtime" rm "$name" >/dev/null
      fi
    elif "$runtime" inspect "$name" >/dev/null 2>&1; then
      printf '    Removing retired registry container %s\n' "$name"
      "$runtime" rm --force "$name" >/dev/null
    fi
  done
  remove_named_volume "$OPAM_VOLUME"
}

clean_temporary_outputs() {
  local temp_root="${TMPDIR:-/tmp}"
  printf '==> Cleaning interrupted SDK temporary build directories\n'
  remove_path /tmp/xynoplex-sdk-rust
  if [[ -d "$temp_root" ]]; then
    while IFS= read -r -d '' output; do
      remove_path "$output"
    done < <(find "$temp_root" -mindepth 1 -maxdepth 1 -type d \
      \( -name 'xynoplex-sdk-python.*' -o -name 'xynoplex-go-proxy.*' \) \
      -prune -print0)
  fi
}

clean_all() {
  local language
  for language in "${LANGUAGES[@]}"; do
    clean_language "$language"
  done
  rm -f "$ROOT/coverage.txt"
  clean_local_artifacts
  clean_temporary_outputs
  echo 'Clean complete. Downloaded container images and external SDK_ARTIFACTS destinations were left untouched.'
}

case "${1:-all}" in
  all) clean_all ;;
  local)
    clean_local_artifacts
    clean_temporary_outputs
    ;;
  typescript|python|rust|go|csharp|haskell|kotlin|ocaml|swift)
    clean_language "$1"
    ;;
  *) echo 'Usage: clean-sdk.sh {all|local|typescript|python|rust|go|csharp|haskell|kotlin|ocaml|swift}' >&2; exit 2 ;;
esac
