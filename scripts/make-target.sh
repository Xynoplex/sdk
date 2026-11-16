#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
source "$ROOT/build-tools/container-runtime.sh"
source "$ROOT/scripts/require-protocol-pin.sh"
RUNTIME="$(detect_container_runtime)"
require_protocol_pin "$ROOT" >/dev/null

# Run a language's checks in its toolchain's container, on a copy of the
# checkout laid out as the checkout is, with the Protocol bundles built.
in_container() {
  local image="$1" script="$2"
  shift 2
  "$RUNTIME" run --rm --volume "$ROOT:/source:ro" --workdir /tmp "$@" "$image" \
    bash -euc "cp -a /source /tmp/sdk
$script"
}

case "${1:-}" in
  test-typescript)
    bash "$ROOT/scripts/bundle-protocol.sh"
    in_container node:26-bookworm '
      cd /tmp/sdk/typescript
      npm install --no-package-lock
      npm run build:packages
      for package in core observability http-transport sdk react-ui; do
        npm run typecheck --workspace="@xynolog/$package"
      done
      npm run typecheck:conformance --workspace=@xynolog/http-transport
      npm run typecheck:conformance --workspace=@xynolog/sdk
      npm run lint:css --workspace=@xynolog/react-ui
      for package in core observability http-transport sdk react-ui; do
        npm test --workspace="@xynolog/$package"
      done'
    ;;
  test-python)
    bash "$ROOT/scripts/bundle-protocol.sh"
    in_container python:3.12-bookworm '
      # pyright is a Node program, and its Python wrapper runs the node it
      # finds on PATH.
      apt-get update -qq
      apt-get install -y -qq --no-install-recommends nodejs > /dev/null
      python -m pip install --disable-pip-version-check --no-cache-dir --root-user-action=ignore uv
      cd /tmp/sdk/python/sdk
      uv sync --locked
      uv run mypy
      uv run pyright
      uv run mypy --platform win32
      uv run pyright --pythonplatform Windows
      uv run ruff check
      uv run ruff format --check
      uv run pytest'
    ;;
  test-rust)
    bash "$ROOT/scripts/bundle-protocol.sh"
    in_container "rust:$(sh "$ROOT/rust/scripts/rust-toolchain.sh")-bookworm" '
      cd /tmp/sdk/rust
      cargo fmt --all --check
      cargo clippy --workspace --all-targets --all-features --locked -- -D warnings
      cargo test --workspace --all-features --locked' --memory 4g
    ;;
  test-go)
    COVERAGE_DIR="$(mktemp -d "${TMPDIR:-/tmp}/xynolog-sdk-coverage.XXXXXX")"
    trap 'rm -rf "$COVERAGE_DIR"' EXIT
    in_container "golang:$(sh "$ROOT/go/scripts/go-toolchain.sh")-bookworm" '
      cd /tmp/sdk/go
      go vet ./...
      go test -race -coverprofile=/coverage/coverage.txt -covermode=atomic ./...' \
      --volume "$COVERAGE_DIR:/coverage"
    cp "$COVERAGE_DIR/coverage.txt" "$ROOT/coverage.txt"
    ;;
  test-csharp)
    bash "$ROOT/scripts/bundle-protocol.sh"
    in_container "mcr.microsoft.com/dotnet/sdk:$(sh "$ROOT/csharp/scripts/dotnet-version.sh" --image-tag)" '
      cd /tmp/sdk/csharp/sdk
      test "$(dotnet --version)" = "$(sh ../scripts/dotnet-version.sh)"
      dotnet build -p:RestoreLockedMode=true
      dotnet test --no-build --settings test.runsettings
      dotnet format --no-restore --verify-no-changes'
    ;;
  test-kotlin)
    bash "$ROOT/scripts/bundle-protocol.sh"
    in_container "eclipse-temurin:$(sh "$ROOT/kotlin/scripts/jdk-version.sh")-jdk" '
      cd /tmp/sdk/kotlin/sdk
      ./gradlew --no-daemon --console=plain check' --memory 4g
    ;;
  test-swift)
    in_container "swift:$(sh "$ROOT/swift/scripts/swift-version.sh")" '
      cd /tmp/sdk/swift/sdk
      Scripts/test.sh
      swift format lint --strict --recursive .
      Scripts/census.sh
      Scripts/refusals.sh' --memory 4g
    ;;
  test-haskell)
    "$RUNTIME" build --build-arg "GHC_VERSION=$(bash "$ROOT/haskell/toolchain/toolchain.sh" --ghc)" \
      --tag xynolog-haskell-toolchain --file "$ROOT/haskell/toolchain/Dockerfile" "$ROOT/haskell/toolchain"
    in_container xynolog-haskell-toolchain '
      cd /tmp/sdk/haskell/sdk
      cabal update
      bash run.sh /tmp/sdk
      python3 ../coverage.py coverage.lcov' --memory 4g
    ;;
  test-ocaml)
    python3 "$ROOT/ocaml/check-toolchain.py"
    "$RUNTIME" build --build-arg "BASE_IMAGE=$(python3 "$ROOT/ocaml/check-toolchain.py" --base-image)" \
      --tag xynolog-ocaml-toolchain --file "$ROOT/ocaml/Dockerfile" "$ROOT/ocaml"
    in_container xynolog-ocaml-toolchain '
      cd /tmp/sdk/ocaml/sdk
      dune build @all @opam
      python3 test/check-format.py
      python3 test/check-installed-api.py
      python3 probes/check-interface.py
      python3 api.py
      python3 probes/check-api-controls.py
      dune runtest' --memory 4g
    ;;
  generate|check-generated)
    # Each group is codegen/node/package.json's generate:<group>, in the order
    # it lists them; check-generated runs each one's :check, which compares
    # the committed files and writes nothing. generate writes into the
    # checkout itself.
    bash "$ROOT/scripts/bundle-protocol.sh"
    suffix=""
    [[ "$1" == check-generated ]] && suffix=:check
    groups='
      cd typescript
      npm install --no-package-lock --ignore-scripts
      ln -sfn ../../typescript/node_modules ../codegen/node/node_modules
      cd ../codegen/node
      for script in $(node -p "Object.keys(require(\"./package.json\").scripts).filter((s) => /^generate:[a-z-]+$/.test(s)).join(\" \")"); do
        npm run --silent "$script'"$suffix"'"
      done'
    if [[ "$1" == generate ]]; then
      "$RUNTIME" run --rm --volume "$ROOT:/sdk" --workdir /sdk node:26-bookworm bash -euc "$groups"
    else
      in_container node:26-bookworm "cd /tmp/sdk
$groups"
    fi
    ;;
  *)
    echo 'Usage: make-target.sh test-<language>|generate|check-generated' >&2
    exit 2
    ;;
esac
