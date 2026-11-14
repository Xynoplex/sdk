#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
engine=${1:-container}
case "$engine" in container|docker) ;; *) printf 'expected container or docker\n' >&2; exit 2 ;; esac
root=$(git rev-parse --show-toplevel)
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/xynoplex/haskell-cabal"
mkdir -p "$cache_dir"
"$engine" build --build-arg "GHC_VERSION=$(bash probes/toolchain.sh --ghc)" \
  --tag xynoplex-haskell-development --file probes/Dockerfile probes
"$engine" run --rm --memory 4g \
  --volume "$root:/work" --volume "$cache_dir:/root/.cabal" \
  --workdir /work/haskell xynoplex-haskell-development \
  bash -c 'bash probes/run.sh && bash sdk/run.sh /work && python3 coverage.py probes/coverage.lcov && python3 coverage.py sdk/coverage.lcov'
