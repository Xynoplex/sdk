#!/usr/bin/env bash
# cabal-version.sh <version> <manifest> — put a Haskell SDK manifest at <version>.
#
# The SDK's codegen writes xynolog.cabal from xynolog.cabal.in, and the manifest
# is committed because the codegen is an executable of the package it
# describes. This rewrites only the version line, as the codegen would, without
# building the Haskell toolchain's image. scripts/sdk_version.py write runs it
# on the committed haskell/sdk/xynolog.cabal, with the release's version, and
# scripts/publish-other-local.sh on a build's copy, with the version that
# build gives the package: the release's, or a development version, four
# numeric parts (scripts/sdk_version.py).
set -euo pipefail
version=${1:-}
manifest=${2:-}
if [[ ! "$version" =~ ^[0-9]+(\.[0-9]+)+$ || ! -f "$manifest" ]]; then
  echo "usage: cabal-version.sh <version> <manifest>" >&2
  exit 2
fi
trap 'rm -f "$manifest.tmp"' EXIT

awk -v v="$version" '
  /^version: / { $0 = "version: " v; lines++ }
  { print }
  END { if (lines != 1) { print "cabal-version.sh: xynolog.cabal has " lines + 0 " top-level version lines, not one" > "/dev/stderr"; exit 1 } }
' "$manifest" > "$manifest.tmp"
mv "$manifest.tmp" "$manifest"

echo "  $manifest -> $version"
