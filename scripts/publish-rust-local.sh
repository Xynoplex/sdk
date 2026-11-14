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

cd "$SCRATCH/rust"

echo 'Building the Rust workspace and creating crate archives…'
# The extracted SDK repository's lockfile can lag the independently-versioned
# protocol/workspace graph. Resolve in this disposable container copy, then
# use that same resolved lockfile for every archive below. Build all features
# so the optional sign-in code is checked too, and reject every lint warning.
RUSTFLAGS="${RUSTFLAGS:+$RUSTFLAGS }-D warnings" cargo build --workspace --all-features

version="$(awk '/^\[workspace.package\]$/ { in_workspace=1; next } /^\[/ { in_workspace=0 } in_workspace && /^version = / { gsub(/"/, "", $3); print $3; exit }' Cargo.toml)"
if [[ -z "$version" ]]; then
  echo 'Could not read the Rust workspace package version.' >&2
  exit 1
fi

# Package dependencies before consumers. Cargo writes one .crate archive per
# publishable workspace crate to target/package; no registry is involved.
for crate in xynoplex-codegen xynoplex xynoplex-telemetry xynoplex-http-transport; do
  config=""
  case "$crate" in
    xynoplex)
      mkdir -p .cargo
      cat > .cargo/config.toml <<EOF
[patch.crates-io]
xynoplex-codegen = { path = "$SCRATCH/rust/codegen" }
EOF
      config=.cargo/config.toml
      ;;
    xynoplex-telemetry)
      mkdir -p .cargo
      cat > .cargo/config.toml <<EOF
[patch.crates-io]
xynoplex = { path = "$SCRATCH/rust/sdk" }
EOF
      config=.cargo/config.toml
      ;;
    xynoplex-http-transport)
      mkdir -p .cargo
      cat > .cargo/config.toml <<EOF
[patch.crates-io]
xynoplex = { path = "$SCRATCH/rust/sdk" }
xynoplex-telemetry = { path = "$SCRATCH/rust/telemetry" }
EOF
      config=.cargo/config.toml
      ;;
  esac
  if [[ -n "$config" ]]; then
    cargo --config "$config" package --locked --no-verify --all-features --package "$crate"
  else
    cargo package --locked --no-verify --all-features --package "$crate"
  fi
  archive="$CARGO_TARGET_DIR/package/${crate}-${version}.crate"
  if [[ ! -f "$archive" ]]; then
    echo "Cargo did not create the expected archive: $archive" >&2
    exit 1
  fi
  cp -f "$archive" /artifacts/
  printf 'Created %s %s\n' "$crate" "$version"
done

echo 'Rust crate archives are ready under /artifacts.'
