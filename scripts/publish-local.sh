#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
source "$ROOT/scripts/container-runtime.sh"
source "$ROOT/scripts/require-protocol-pin.sh"
RUNTIME="$(detect_container_runtime)"
STATE_ROOT="${XDG_CACHE_HOME:-$HOME/.cache}/xynoplex-sdk/local"
PROTOCOL="$ROOT/protocol"

mkdir -p "$STATE_ROOT/npm/packages" "$STATE_ROOT/python/packages" \
  "$STATE_ROOT/rust/packages" "$STATE_ROOT/uv-cache" \
  "$STATE_ROOT/rust/cargo-home" "$STATE_ROOT/rust/target"
chmod 0777 "$STATE_ROOT/npm/packages" "$STATE_ROOT/python/packages" \
  "$STATE_ROOT/rust/packages" "$STATE_ROOT/rust/cargo-home" "$STATE_ROOT/rust/target"

LANGUAGE="${1:-all}"
if [[ "$LANGUAGE" == all ]]; then
  LANGUAGES=(typescript python rust go csharp haskell kotlin ocaml swift)
else
  IFS=, read -r -a LANGUAGES <<< "$LANGUAGE"
fi
for language in "${LANGUAGES[@]}"; do
  case "$language" in
    typescript|python|rust|go|csharp|haskell|kotlin|ocaml|swift) ;;
    *) echo "Unknown SDK language: $language" >&2; exit 2 ;;
  esac
done
if [[ " ${LANGUAGES[*]} " == *" all "* ]]; then
  echo 'Use all by itself or list SDK languages separated by commas.' >&2
  exit 2
fi
for ((index = 0; index < ${#LANGUAGES[@]}; index++)); do
  for ((previous = 0; previous < index; previous++)); do
    if [[ "${LANGUAGES[$index]}" == "${LANGUAGES[$previous]}" ]]; then
      echo 'Do not repeat SDK languages.' >&2
      exit 2
    fi
  done
done
has_language() {
  [[ " ${LANGUAGES[*]} " == *" $1 "* ]]
}
ALL_LANGUAGES=false
[[ "$LANGUAGE" == all ]] && ALL_LANGUAGES=true

PROTOCOL_REVISION="$(require_protocol_pin "$ROOT")"

echo "Building protocol bundles from pinned revision ${PROTOCOL_REVISION}…"
run_container_quietly "$RUNTIME" run --rm \
  --volume "$PROTOCOL:/protocol" \
  --workdir /tmp \
  node:26-bookworm bash -euc '
    cp -a /protocol /tmp/protocol
    cd /tmp/protocol
    npm ci
    npm run specs:bundle
    cp -f specs/openapi.json /protocol/specs/openapi.json
    cp -f specs/archivist.openapi.json /protocol/specs/archivist.openapi.json
  '

if has_language typescript; then
  echo 'Building TypeScript packages and packing npm artifacts in a Node container…'
  run_container_quietly "$RUNTIME" run --rm \
    --volume "$ROOT:/source:ro" \
    --volume "$PROTOCOL:/protocol:ro" \
    --volume "$STATE_ROOT/npm/packages:/artifacts" \
    --workdir /source \
    node:26-bookworm bash -euc '
      mkdir -p /tmp/sdk/typescript
      cp -a /source/version.json /source/LICENSE /tmp/sdk/
      cp -a /source/typescript/. /tmp/sdk/typescript/
      cp -a /protocol /tmp/sdk/protocol
      cd /tmp/sdk/typescript
      npm install --no-package-lock
      npm run build:packages
      node scripts/stage-local-publish.mjs verify
      node scripts/stage-local-publish.mjs stage /tmp/local-publish
      cd /tmp/local-publish
      bash typescript/scripts/publish.sh --pack-dir /artifacts
    '
fi

if has_language python; then
  echo 'Building Python source and wheel archives in a Python container…'
  run_container_quietly "$RUNTIME" run --rm \
    --volume "$ROOT:/source:ro" \
    --volume "$PROTOCOL:/protocol:ro" \
    --volume "$STATE_ROOT/uv-cache:/root/.cache/uv" \
    --volume "$STATE_ROOT/python/packages:/artifacts" \
    --workdir /source \
    python:3.12-bookworm bash -euc '
      apt-get update -qq
      apt-get install -y -qq --no-install-recommends jq >/dev/null
      python -m pip install --disable-pip-version-check --no-cache-dir --root-user-action=ignore uv
      bash /source/scripts/publish-python-local.sh
    '
fi

if has_language rust; then
  echo 'Building and packaging Rust crates in a Rust container…'
  run_container_quietly "$RUNTIME" run --rm --memory 4g \
    --volume "$ROOT:/source:ro" \
    --volume "$PROTOCOL:/protocol:ro" \
    --volume "$STATE_ROOT/rust/packages:/artifacts" \
    --volume "$STATE_ROOT/rust/cargo-home:/cargo-home" \
    --volume "$STATE_ROOT/rust/target:/cargo-target" \
    --env CARGO_HOME=/cargo-home \
    --env CARGO_TARGET_DIR=/cargo-target \
    --workdir /source \
    rust:1.100.0-bookworm bash /source/scripts/publish-rust-local.sh
fi

for language in go csharp haskell kotlin ocaml swift; do
  if has_language "$language"; then
    bash "$ROOT/scripts/publish-other-local.sh" "$language"
  fi
done

python3 "$ROOT/scripts/create-artifact-bundle.py" "${LANGUAGES[@]}"

if [[ "$ALL_LANGUAGES" == true ]]; then
  cat <<EOF

SDK artifacts are ready under:
  TypeScript (npm archives): $STATE_ROOT/npm/packages
  Python (wheel and sdist):  $STATE_ROOT/python/packages
  Rust (.crate archives):    $STATE_ROOT/rust/packages
  Go (module proxy):         $STATE_ROOT/go-proxy
  C# (NuGet packages):       $STATE_ROOT/nuget
  Haskell (sdist):           $STATE_ROOT/haskell
  Kotlin (Maven repository): $STATE_ROOT/kotlin-maven
  OCaml (opam repository):   $STATE_ROOT/opam-repo/repo
  Swift (source archive):    $STATE_ROOT/swift

EOF
else
  printf 'Native SDK artifacts staged for: %s\n' "${LANGUAGES[*]}"
  case "$LANGUAGE" in
    typescript) echo "TypeScript npm archives are ready under: $STATE_ROOT/npm/packages" ;;
    python) echo "Python archives are ready under: $STATE_ROOT/python/packages" ;;
    rust) echo "Rust crate archives are ready under: $STATE_ROOT/rust/packages" ;;
    go) echo "Go module proxy artifacts are ready under: $STATE_ROOT/go-proxy" ;;
    csharp) echo "NuGet package artifacts are ready under: $STATE_ROOT/nuget" ;;
    haskell) echo "Haskell source distribution is ready under: $STATE_ROOT/haskell" ;;
    kotlin) echo "Kotlin Maven artifacts are ready under: $STATE_ROOT/kotlin-maven" ;;
    ocaml) echo "OCaml package repository is ready under: $STATE_ROOT/opam-repo/repo" ;;
    swift) echo "Swift package archive is ready under: $STATE_ROOT/swift" ;;
  esac
fi
