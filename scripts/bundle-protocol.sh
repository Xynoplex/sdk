#!/usr/bin/env bash
# Write the pinned Protocol's bundles, each one the reader writes into specs/
# (xynolog-protocol bundle), into the protocol checkout. The SDKs' builds and
# tests read them there; Protocol commits only their sources. The reader is
# built in the generator's workspace, which vendors the pinned Protocol, on
# the OCaml toolchain's image.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
source "$ROOT/build-tools/container-runtime.sh"
source "$ROOT/scripts/run-container-quietly.sh"
source "$ROOT/scripts/require-protocol-pin.sh"
RUNTIME="$(detect_container_runtime)"

echo "Building protocol bundles from pinned revision $(require_protocol_pin "$ROOT")…"
run_container_quietly bash "$ROOT/build-tools/ocaml/toolchain-image.sh" "$ROOT/codegen"
run_container_quietly "$RUNTIME" run --rm \
  --volume "$ROOT/codegen:/source/codegen:ro" \
  --volume "$ROOT/protocol:/source/protocol" \
  --workdir /tmp \
  xynolog-ocaml-toolchain bash -euc '
    mkdir /tmp/sdk
    tar -C /source --exclude=_build -cf - codegen protocol | tar -C /tmp/sdk -xf -
    cd /tmp/sdk/codegen
    dune exec -- xynolog-protocol bundle ../protocol
    cp -f ../protocol/specs/*.json /source/protocol/specs/
  '
