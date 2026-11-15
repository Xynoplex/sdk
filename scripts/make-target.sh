#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
source "$ROOT/build-tools/container-runtime.sh"
source "$ROOT/scripts/require-protocol-pin.sh"
RUNTIME="$(detect_container_runtime)"
PROTOCOL="$ROOT/protocol"
require_protocol_pin "$ROOT" >/dev/null

case "${1:-}" in
  go-test)
    COVERAGE_DIR="$(mktemp -d "${TMPDIR:-/tmp}/xynolog-sdk-coverage.XXXXXX")"
    trap 'rm -rf "$COVERAGE_DIR"' EXIT
    mkdir -p "$COVERAGE_DIR/out"
    "$RUNTIME" run --rm \
      --volume "$ROOT:/source:ro" \
      --volume "$PROTOCOL:/protocol:ro" \
      --volume "$COVERAGE_DIR/out:/coverage" \
      --workdir /tmp \
      golang:1.27.4-bookworm \
      bash -euc 'cp -a /source /tmp/sdk && mkdir -p /tmp/sdk/protocol && cp -a /protocol/. /tmp/sdk/protocol/ && cd /tmp/sdk/go && go test -race -coverprofile=/coverage/coverage.txt -covermode=atomic ./...'
    cp "$COVERAGE_DIR/out/coverage.txt" "$ROOT/coverage.txt"
    ;;
  *)
    echo 'Usage: make-target.sh go-test' >&2
    exit 2
    ;;
esac
