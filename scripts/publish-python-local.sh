#!/usr/bin/env bash
set -euo pipefail

ROOT=/source
SCRATCH="$(mktemp -d /tmp/xynoplex-sdk-python.XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

mkdir -p "$SCRATCH/python"
cp -a "$ROOT/python/sdk" "$SCRATCH/python/sdk"
cp "$ROOT/version.json" "$ROOT/LICENSE" "$SCRATCH/"

cd "$SCRATCH"
python/sdk/scripts/build-python-sdk.sh

mkdir -p /artifacts
cp -f python/sdk/dist/* /artifacts/

printf '\nPython SDK distribution files are ready under /artifacts\n'
