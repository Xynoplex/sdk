#!/usr/bin/env bash
set -euo pipefail

SCRATCH=/tmp/xynoplex-sdk-rust
rm -rf "$SCRATCH"
mkdir -p "$SCRATCH"
cp -a /source/rust "$SCRATCH/rust"
cp -a /protocol "$SCRATCH/protocol"
cp /source/LICENSE /source/version.json "$SCRATCH/"

version="$(sed -n 's/^[[:space:]]*"version":[[:space:]]*"\([^"]*\)".*/\1/p' /source/version.json | head -n 1)"
if [[ -z "$version" ]]; then
  echo 'Could not read the SDK version.' >&2
  exit 1
fi

# Internal path dependencies need to resolve from the selected local registry
# after Cargo packages each crate for publication. Keep this adaptation in the
# disposable build tree; the public manifests continue to target crates.io.
sed -i \
  -e "s/xynoplex = { path = \"sdk\", version = \"$version\" }/xynoplex = { path = \"sdk\", version = \"$version\", registry = \"xynoplex-local\" }/" \
  -e "s/xynoplex-codegen = { path = \"codegen\", version = \"$version\" }/xynoplex-codegen = { path = \"codegen\", version = \"$version\", registry = \"xynoplex-local\" }/" \
  -e "s/xynoplex-telemetry = { path = \"telemetry\", version = \"$version\" }/xynoplex-telemetry = { path = \"telemetry\", version = \"$version\", registry = \"xynoplex-local\" }/" \
  "$SCRATCH/rust/Cargo.toml"

cd "$SCRATCH/rust"

echo 'Building the Rust workspace in the local-registry container…'
# The extracted SDK repository's lockfile can lag the independently-versioned
# protocol/workspace graph. Resolve in this disposable container copy, then
# use that same resolved lockfile for every crate publication below.
cargo build --workspace

index_entry() {
  local crate="$1"
  case "${#crate}" in
    1) printf '1/%s' "$crate" ;;
    2) printf '2/%s' "$crate" ;;
    3) printf '3/%s/%s' "${crate:0:1}" "$crate" ;;
    *) printf '%s/%s/%s' "${crate:0:2}" "${crate:2:2}" "$crate" ;;
  esac
}

version="$(awk '/^\[workspace.package\]$/ { in_workspace=1; next } /^\[/ { in_workspace=0 } in_workspace && /^version = / { gsub(/"/, "", $3); print $3; exit }' Cargo.toml)"
if [[ -z "$version" ]]; then
  echo 'Could not read the Rust workspace package version.' >&2
  exit 1
fi

# Publish transitive build/runtime dependencies before their consumers. The
# shared version comes from [workspace.package], and these are the workspace
# crates declared publishable by rust/scripts/published-crates.sh.
for crate in xynoplex-codegen xynoplex xynoplex-telemetry xynoplex-http-transport; do
  url="http://127.0.0.1:8000/api/v1/crates/$(index_entry "$crate")"
  if curl --connect-timeout 3 --max-time 15 --fail --silent "$url" | grep -Fq "\"vers\":\"$version\""; then
    printf 'Already in local Cargo registry: %s %s\n' "$crate" "$version"
    continue
  fi
  cargo publish --locked --no-verify --package "$crate" --registry xynoplex-local
done

echo 'Rust SDK crates published to http://localhost:8000.'
