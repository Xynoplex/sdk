#!/usr/bin/env bash
# Write the pinned Protocol's bundled specs, specs/openapi.json and
# specs/archivist.openapi.json, into the protocol checkout. The SDKs' builds
# and tests read them there; Protocol commits only their sources.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
source "$ROOT/build-tools/container-runtime.sh"
source "$ROOT/scripts/run-container-quietly.sh"
source "$ROOT/scripts/require-protocol-pin.sh"
RUNTIME="$(detect_container_runtime)"
PROTOCOL="$ROOT/protocol"

echo "Building protocol bundles from pinned revision $(require_protocol_pin "$ROOT")…"
run_container_quietly "$RUNTIME" run --rm \
  --volume "$PROTOCOL:/protocol" \
  --workdir /tmp \
  node:26-bookworm bash -euc '
    cp -a /protocol /tmp/protocol
    cd /tmp/protocol
    npm ci
    npm run specs:bundle
    cp -f specs/openapi.json /protocol/specs/openapi.json
    cp -f specs/archivist.openapi.json /protocol/specs/archivist.openapi.json
  '
