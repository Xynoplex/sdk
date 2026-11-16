#!/usr/bin/env bash
set -euo pipefail

# The version this build gives the crates (scripts/sdk_version.py rust).
version="${1:?usage: publish-rust-local.sh <version>}"
SCRATCH=/tmp/xynolog-sdk-rust
rm -rf "$SCRATCH"
mkdir -p "$SCRATCH"
cp -a /source/rust "$SCRATCH/rust"
cp -a /protocol "$SCRATCH/protocol"
cp /source/LICENSE "$SCRATCH/"
bash "$SCRATCH/rust/scripts/cargo-version.sh" "$version"

cd "$SCRATCH/rust"

echo 'Building the Rust workspace and creating crate archives…'
# The extracted SDK repository's lockfile can lag the independently-versioned
# protocol/workspace graph. Resolve in this disposable container copy, then
# use that same resolved lockfile for every archive below. Build all features
# so the optional sign-in code is checked too, and reject every lint warning.
RUSTFLAGS="${RUSTFLAGS:+$RUSTFLAGS }-D warnings" cargo build --workspace --all-features

# Package dependencies before consumers. Cargo writes one .crate archive per
# publishable workspace crate to target/package; no registry is involved.
for crate in xynolog-codegen xynolog xynolog-telemetry xynolog-http-transport; do
  config=""
  case "$crate" in
    xynolog)
      mkdir -p .cargo
      cat > .cargo/config.toml <<EOF
[patch.crates-io]
xynolog-codegen = { path = "$SCRATCH/rust/codegen" }
EOF
      config=.cargo/config.toml
      ;;
    xynolog-telemetry)
      mkdir -p .cargo
      cat > .cargo/config.toml <<EOF
[patch.crates-io]
xynolog = { path = "$SCRATCH/rust/sdk" }
EOF
      config=.cargo/config.toml
      ;;
    xynolog-http-transport)
      mkdir -p .cargo
      cat > .cargo/config.toml <<EOF
[patch.crates-io]
xynolog = { path = "$SCRATCH/rust/sdk" }
xynolog-telemetry = { path = "$SCRATCH/rust/telemetry" }
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
