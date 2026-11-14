#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
source "$ROOT/scripts/container-runtime.sh"
RUNTIME="$(detect_container_runtime)"
STATE_ROOT="${XDG_CACHE_HOME:-$HOME/.cache}/xynoplex-sdk/local"
PROTOCOL="$ROOT/protocol"
[[ -d "$PROTOCOL/specs/src" ]] || PROTOCOL="$ROOT/../protocol"
LEGACY_NPM_CONTAINER=xynoplex-sdk-local-npm
PYPI_CONTAINER=xynoplex-sdk-local-pypi
CARGO_CONTAINER=xynoplex-sdk-local-cargo
CARGO_IMAGE=xynoplex-sdk-local-cargo:6.0.0-v2

mkdir -p "$STATE_ROOT/npm/packages" "$STATE_ROOT/pypi/packages" \
  "$STATE_ROOT/cargo-home" "$STATE_ROOT/kellnr" "$STATE_ROOT/uv-cache"
chmod 0777 "$STATE_ROOT/npm/packages" "$STATE_ROOT/pypi/packages" \
  "$STATE_ROOT/cargo-home" "$STATE_ROOT/kellnr"

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

ensure_container() {
  local name="$1" image="$2" before_separator=1
  local -a options=() command=()
  shift 2
  local argument
  for argument in "$@"; do
    if [[ "$argument" == -- && "$before_separator" == 1 ]]; then
      before_separator=0
    elif [[ "$before_separator" == 1 ]]; then
      options+=("$argument")
    else
      command+=("$argument")
    fi
  done
  if container_exists "$name"; then
    if ! container_running "$name"; then
      echo "Starting existing local registry container ${name}…"
      "$RUNTIME" start "$name" >/dev/null
    fi
  else
    echo "Starting local registry container ${name}…"
    if ((${#command[@]})); then
      "$RUNTIME" run --detach --name "$name" "${options[@]}" "$image" "${command[@]}"
    else
      "$RUNTIME" run --detach --name "$name" "${options[@]}" "$image"
    fi
  fi
}

wait_for_url() {
  local url="$1" label="$2" attempt
  for attempt in $(seq 1 60); do
    if curl --fail --silent --show-error "$url" >/dev/null 2>&1; then
      return 0
    fi
    sleep 1
  done
  echo "$label did not become ready at $url." >&2
  if container_exists "$3"; then "$RUNTIME" logs "$3" >&2 || true; fi
  return 1
}

stop_local() {
  local name
  for name in "$LEGACY_NPM_CONTAINER" "$PYPI_CONTAINER" "$CARGO_CONTAINER"; do
    if container_exists "$name" && container_running "$name"; then
      echo "Stopping ${name}…"
      "$RUNTIME" stop "$name" >/dev/null
    fi
  done
  echo "Local registry data is retained at $STATE_ROOT."
}

# Stop the npm registry created by older versions of this script. Leave its
# package data untouched, but free :4873 now that npm tarballs are local files.
stop_legacy_npm_registry() {
  if container_exists "$LEGACY_NPM_CONTAINER" && container_running "$LEGACY_NPM_CONTAINER"; then
    echo "Stopping retired npm registry ${LEGACY_NPM_CONTAINER}…"
    "$RUNTIME" stop "$LEGACY_NPM_CONTAINER" >/dev/null
  fi
}

if [[ "${1:-}" == --stop ]]; then
  stop_local
  exit 0
elif [[ $# -gt 0 ]]; then
  echo 'Usage: scripts/publish-local.sh [--stop]' >&2
  exit 2
fi

stop_legacy_npm_registry

if [[ ! -d "$PROTOCOL/specs/src" ]]; then
  echo "Protocol specs were not found at $PROTOCOL/specs/src." >&2
  echo 'Check out the xynoplex/protocol repository beside this SDK repository.' >&2
  exit 1
fi

# Keep the PyPI- and Cargo-compatible registries on predictable local ports. Their
# package data survives `make local-stop` and subsequent runs.
ensure_container "$PYPI_CONTAINER" pypiserver/pypiserver:v2.4.3 \
  --publish 8081:8080 \
  --volume "$STATE_ROOT/pypi/packages:/data/packages" \
  -- run -p 8080 -a . -P . --disable-fallback /data/packages
wait_for_url http://localhost:8081/simple/ 'Local PyPI registry' "$PYPI_CONTAINER"

if ! container_exists "$CARGO_CONTAINER"; then
  if [[ ! -f "$STATE_ROOT/cargo-token" ]]; then
    (umask 077; openssl rand -hex 32 > "$STATE_ROOT/cargo-token")
  fi
  cargo_token="$(cat "$STATE_ROOT/cargo-token")"
  cat > "$STATE_ROOT/cargo-home/config.toml" <<'EOF'
[registry]
global-credential-providers = ["cargo:token"]

[registries.xynoplex-local]
index = "sparse+http://127.0.0.1:8000/api/v1/crates/"
credential-provider = "cargo:token"
EOF
  cat > "$STATE_ROOT/cargo-home/credentials.toml" <<EOF
[registries.xynoplex-local]
token = "$cargo_token"
EOF
  chmod 0600 "$STATE_ROOT/cargo-home/config.toml" "$STATE_ROOT/cargo-home/credentials.toml" "$STATE_ROOT/cargo-token"
fi

image_exists=0
if [[ "$RUNTIME" == container ]]; then
  "$RUNTIME" image inspect "$CARGO_IMAGE" >/dev/null 2>&1 || image_exists=1
else
  "$RUNTIME" image inspect "$CARGO_IMAGE" >/dev/null 2>&1 || image_exists=1
fi
if [[ "${image_exists:-1}" == 1 ]]; then
  echo 'Building the Cargo registry image (Rust toolchain plus Kellnr)…'
  "$RUNTIME" build --tag "$CARGO_IMAGE" --file "$ROOT/scripts/rust-registry/Containerfile" "$ROOT/scripts/rust-registry"
fi

if ! container_exists "$CARGO_CONTAINER"; then
  cargo_token="$(cat "$STATE_ROOT/cargo-token")"
  "$RUNTIME" run --detach --name "$CARGO_CONTAINER" \
    --cpus 4 --memory 4g \
    --publish 8000:8000 \
    --volume "$ROOT:/source:ro" \
    --volume "$PROTOCOL:/protocol:ro" \
    --volume "$STATE_ROOT/cargo-home:/var/lib/cargo" \
    --volume "$STATE_ROOT/kellnr:/var/lib/kellnr" \
    --env "KELLNR_SETUP__ADMIN_TOKEN=$cargo_token" \
    --env KELLNR_ORIGIN__HOSTNAME=localhost \
    --env CARGO_HOME=/var/lib/cargo \
    "$CARGO_IMAGE"
fi
wait_for_url http://localhost:8000/ 'Local Cargo registry (Kellnr)' "$CARGO_CONTAINER"

echo 'Building TypeScript packages and packing npm artifacts in a Node container…'
"$RUNTIME" run --rm \
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

echo 'Building and publishing the Python distribution in a Python container…'
"$RUNTIME" run --rm \
  --volume "$ROOT:/source:ro" \
  --volume "$STATE_ROOT/uv-cache:/root/.cache/uv" \
  --volume "$STATE_ROOT/pypi/packages:/repo/packages" \
  --workdir /source \
  python:3.12-bookworm bash -euc '
    apt-get update -qq
    apt-get install -y -qq --no-install-recommends jq iproute2 >/dev/null
    python -m pip install --disable-pip-version-check --no-cache-dir uv
    host_addr=$(ip route | awk "/^default / { print \$3; exit }")
    test -n "$host_addr"
    export PYPI_INDEX_URL="http://$host_addr:8081/simple/"
    bash /source/scripts/publish-python-local.sh
  '

echo 'Building and publishing Rust crates in the local Cargo registry container…'
if [[ "$RUNTIME" == container ]]; then
  "$RUNTIME" exec --workdir /source --env CARGO_HOME=/var/lib/cargo \
    "$CARGO_CONTAINER" bash /source/scripts/publish-rust-local.sh
else
  "$RUNTIME" exec --workdir /source --env CARGO_HOME=/var/lib/cargo \
    "$CARGO_CONTAINER" bash /source/scripts/publish-rust-local.sh
fi

echo 'Building the Go, .NET, Haskell, Kotlin, OCaml, and Swift local artifacts…'
bash "$ROOT/scripts/publish-other-local.sh"

cat <<EOF

Local SDK feeds and archives are ready:
  Python: http://localhost:8081/simple/
  Cargo:  sparse+http://127.0.0.1:8000/api/v1/crates/
  npm tarballs and other SDK feeds/source archives: $STATE_ROOT

Run 'make local-stop' to stop registry containers. Their packages remain in:
  $STATE_ROOT
EOF
