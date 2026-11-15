#!/usr/bin/env bash
set -euo pipefail

# The persistent uv cache is a mounted volume while builds run under /tmp, so
# cached files and the environment live on different filesystems. Copying is
# therefore the supported link mode; making it explicit avoids uv's fallback
# warning without changing the resulting environment.
export UV_LINK_MODE=copy

ROOT=/source
SCRATCH="$(mktemp -d /tmp/xynoplex-sdk-python.XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

mkdir -p "$SCRATCH/python"
cp -a "$ROOT/python/sdk" "$SCRATCH/python/sdk"
cp -a "$ROOT/python/scripts" "$SCRATCH/python/scripts"
cp -a /protocol "$SCRATCH/protocol"
cp "$ROOT/version.json" "$ROOT/LICENSE" "$SCRATCH/"

cd "$SCRATCH"
cd python/sdk
uv run --locked python scripts/generate_models.py --check
cd "$SCRATCH"
python/sdk/scripts/build-python-sdk.sh

mkdir -p /artifacts
cp -f python/sdk/dist/* /artifacts/

printf '\nPython SDK distribution files are ready under /artifacts\n'
