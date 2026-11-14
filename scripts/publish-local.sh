#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
source "$ROOT/scripts/container-runtime.sh"
RUNTIME="$(detect_container_runtime)"
STATE_ROOT="${XDG_CACHE_HOME:-$HOME/.cache}/xynoplex-sdk/local"
PROTOCOL="$ROOT/protocol"
[[ -d "$PROTOCOL/specs/src" ]] || PROTOCOL="$ROOT/../protocol"
OLD_NPM_CONTAINER=xynoplex-sdk-local-npm
OLD_PYPI_CONTAINER=xynoplex-sdk-local-pypi
OLD_CARGO_CONTAINER=xynoplex-sdk-local-cargo

mkdir -p "$STATE_ROOT/npm/packages" "$STATE_ROOT/python/packages" \
  "$STATE_ROOT/rust/packages" "$STATE_ROOT/uv-cache" \
  "$STATE_ROOT/rust/cargo-home" "$STATE_ROOT/rust/target"
chmod 0777 "$STATE_ROOT/npm/packages" "$STATE_ROOT/python/packages" \
  "$STATE_ROOT/rust/packages" "$STATE_ROOT/rust/cargo-home" "$STATE_ROOT/rust/target"

container_exists() {
  if [[ "$RUNTIME" == container ]]; then
    "$RUNTIME" list --all --format table | awk -v name="$1" '$1 == name { found=1 } END { exit !found }'
  else
    "$RUNTIME" inspect "$1" >/dev/null 2>&1
  fi
}

container_running() {
  if [[ "$RUNTIME" == container ]]; then
    "$RUNTIME" list --all --format table | awk -v name="$1" '$1 == name && $6 == "running" { found=1 } END { exit !found }'
  else
    [[ "$("$RUNTIME" inspect --format '{{.State.Running}}' "$1" 2>/dev/null || true)" == true ]]
  fi
}

stop_old_registry_containers() {
  local name
  for name in "$OLD_NPM_CONTAINER" "$OLD_PYPI_CONTAINER" "$OLD_CARGO_CONTAINER"; do
    if container_exists "$name" && container_running "$name"; then
      echo "Stopping old registry container ${name}…"
      "$RUNTIME" stop "$name" >/dev/null
    fi
  done
}

if [[ "${1:-}" == --stop ]]; then
  stop_old_registry_containers
  echo "Cached package artifacts are retained at $STATE_ROOT."
  exit 0
elif [[ $# -gt 1 ]]; then
  echo 'Usage: scripts/publish-local.sh [all|typescript|python|rust|go|csharp|haskell|kotlin|ocaml|swift|--stop]' >&2
  exit 2
fi

LANGUAGE="${1:-all}"
case "$LANGUAGE" in
  all|typescript|python|rust|go|csharp|haskell|kotlin|ocaml|swift) ;;
  *) echo "Unknown SDK language: $LANGUAGE" >&2; exit 2 ;;
esac

# Retire registry processes left by older versions of this script. New artifact
# builds only write files under STATE_ROOT.
stop_old_registry_containers

case "$LANGUAGE" in
  all|typescript|rust|go|csharp|kotlin)
    if [[ ! -d "$PROTOCOL/specs/src" ]]; then
      echo "Protocol specs were not found at $PROTOCOL/specs/src." >&2
      echo 'Check out the xynoplex/protocol repository beside this SDK repository.' >&2
      exit 1
    fi
    ;;
esac

if [[ "$LANGUAGE" == all || "$LANGUAGE" == typescript ]]; then
  echo 'Building TypeScript packages and packing npm artifacts in a Node container…'
  run_container_quietly "$RUNTIME" run --rm \
    --volume "$ROOT:/source:ro" \
    --volume "$PROTOCOL:/protocol:ro" \
    --volume "$STATE_ROOT/npm/packages:/artifacts" \
    --workdir /source \
    node:26-bookworm bash -euc '
      mkdir -p /tmp/sdk/typescript
      cp -a /source/version.json /source/LICENSE /tmp/sdk/
      cp -a /source/typescript/. /tmp/sdk/typescript/
      cp -a /protocol /tmp/sdk/protocol
      cd /tmp/sdk/typescript
      npm install --no-package-lock
      npm run build:packages
      node scripts/stage-local-publish.mjs verify
      node scripts/stage-local-publish.mjs stage /tmp/local-publish
      cd /tmp/local-publish
      bash typescript/scripts/publish.sh --pack-dir /artifacts
    '
fi

if [[ "$LANGUAGE" == all || "$LANGUAGE" == python ]]; then
  echo 'Building Python source and wheel archives in a Python container…'
  run_container_quietly "$RUNTIME" run --rm \
    --volume "$ROOT:/source:ro" \
    --volume "$STATE_ROOT/uv-cache:/root/.cache/uv" \
    --volume "$STATE_ROOT/python/packages:/artifacts" \
    --workdir /source \
    python:3.12-bookworm bash -euc '
      apt-get update -qq
      apt-get install -y -qq --no-install-recommends jq >/dev/null
      python -m pip install --disable-pip-version-check --no-cache-dir --root-user-action=ignore uv
      bash /source/scripts/publish-python-local.sh
    '
fi

if [[ "$LANGUAGE" == all || "$LANGUAGE" == rust ]]; then
  echo 'Building and packaging Rust crates in a Rust container…'
  run_container_quietly "$RUNTIME" run --rm --memory 4g \
    --volume "$ROOT:/source:ro" \
    --volume "$PROTOCOL:/protocol:ro" \
    --volume "$STATE_ROOT/rust/packages:/artifacts" \
    --volume "$STATE_ROOT/rust/cargo-home:/cargo-home" \
    --volume "$STATE_ROOT/rust/target:/cargo-target" \
    --env CARGO_HOME=/cargo-home \
    --env CARGO_TARGET_DIR=/cargo-target \
    --workdir /source \
    rust:1.99.1-bookworm bash /source/scripts/publish-rust-local.sh
fi

if [[ "$LANGUAGE" == all || "$LANGUAGE" == go || "$LANGUAGE" == csharp || "$LANGUAGE" == haskell || "$LANGUAGE" == kotlin || "$LANGUAGE" == ocaml || "$LANGUAGE" == swift ]]; then
  if [[ "$LANGUAGE" == all ]]; then
    echo 'Building the Go, .NET, Haskell, Kotlin, OCaml, and Swift local artifacts…'
  else
    case "$LANGUAGE" in
      go) echo 'Building Go local artifacts…' ;;
      csharp) echo 'Building .NET local artifacts…' ;;
      haskell) echo 'Building Haskell local artifacts…' ;;
      kotlin) echo 'Building Kotlin local artifacts…' ;;
      ocaml) echo 'Building OCaml local artifacts…' ;;
      swift) echo 'Building Swift local artifacts…' ;;
    esac
  fi
  bash "$ROOT/scripts/publish-other-local.sh" "$LANGUAGE"
fi

if [[ "$LANGUAGE" == all ]]; then
  cat <<EOF

SDK artifacts are ready under:
  TypeScript: $STATE_ROOT/npm/packages
  Python:     $STATE_ROOT/python/packages
  Rust:       $STATE_ROOT/rust/packages
  Other SDKs: $STATE_ROOT

EOF
else
  case "$LANGUAGE" in
    typescript) echo "TypeScript npm archives are ready under: $STATE_ROOT/npm/packages" ;;
    python) echo "Python archives are ready under: $STATE_ROOT/python/packages" ;;
    rust) echo "Rust crate archives are ready under: $STATE_ROOT/rust/packages" ;;
    go) echo "Go module proxy artifacts are ready under: $STATE_ROOT/go-proxy" ;;
    csharp) echo "NuGet package artifacts are ready under: $STATE_ROOT/nuget" ;;
    haskell) echo "Haskell source distribution is ready under: $STATE_ROOT/haskell" ;;
    kotlin) echo "Kotlin Maven artifacts are ready under: $STATE_ROOT/kotlin-maven" ;;
    ocaml) echo "OCaml package repository is ready under: $STATE_ROOT/opam-repo/repo" ;;
    swift) echo "Swift package archive is ready under: $STATE_ROOT/swift" ;;
  esac
fi
