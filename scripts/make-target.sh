#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
source "$ROOT/scripts/container-runtime.sh"
RUNTIME="$(detect_container_runtime)"

PROTOCOL="$ROOT/protocol"
[[ -d "$PROTOCOL/specs/src" ]] || PROTOCOL="$ROOT/../protocol"

case "${1:-}" in
  go-build)
    echo 'Building the Go SDK in a container…'
    run_container_quietly "$RUNTIME" run --rm \
      --volume "$ROOT:/workspace" \
      --workdir /workspace/go \
      golang:1.27.4-bookworm go build ./...
    ;;
  go-test)
    if [[ ! -d "$PROTOCOL/specs/src" ]]; then
      echo "Protocol specs were not found at $PROTOCOL/specs/src." >&2
      echo 'Check out the xynoplex/protocol repository beside this SDK repository.' >&2
      exit 1
    fi
    COVERAGE_DIR="$(mktemp -d "${TMPDIR:-/tmp}/xynoplex-sdk-coverage.XXXXXX")"
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
  clean)
    echo 'Cleaning Go build outputs in a container…'
    run_container_quietly "$RUNTIME" run --rm \
      --volume "$ROOT:/workspace" \
      --workdir /workspace/go \
      golang:1.27.4-bookworm sh -eu -c 'go clean; rm -f /workspace/coverage.txt'
    ;;
  *)
    echo 'Usage: make-target.sh {go-build|go-test|clean}' >&2
    exit 2
    ;;
esac
