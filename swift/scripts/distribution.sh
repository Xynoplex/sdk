#!/bin/sh
# Assemble the Swift distribution package, the tree a release writes to
# xynolog/sdk-swift, and prove it installs.
#
#   swift/scripts/distribution.sh <version> <build path> <out dir>
#
# The tree, <out dir>/sdk-swift, holds the SDK's library targets, a manifest
# distribution-manifest.py derives from swift/sdk's, the build plugin's models
# generated and committed, and the LICENSE, NOTICE and README. It is then
# committed to a scratch git repository, tagged <version>, and a package that
# depends on it by URL at exactly that version is built, as an application
# would depend on it. Run in the pinned Swift container, from a checkout with
# Protocol at protocol/ and python3 and git on the path.
set -eu
version=$1
build=$2
tree="$3/sdk-swift"
root=$(CDPATH='' cd "$(dirname "$0")/../.." && pwd)
manifest="$root/swift/scripts/distribution-manifest.py"
work=$(mktemp -d)
test ! -e "$tree" || { echo "distribution.sh: $tree already exists" >&2; exit 1; }

cd "$root/swift/sdk"
swift package dump-package > "$work/dump.json"
python3 "$manifest" manifest "$work/dump.json" > "$work/Package.swift"
mkdir -p "$tree/Sources"
mv "$work/Package.swift" "$tree/Package.swift"
python3 "$manifest" targets "$work/dump.json" > "$work/targets"
while IFS= read -r target; do cp -a "Sources/$target" "$tree/Sources/$target"; done < "$work/targets"

# What the build plugin generates at build time, generated once and committed.
swift build --build-path "$build" --jobs 4 --force-resolved-versions --product GenerateXynolog
python3 "$manifest" generated "$work/dump.json" > "$work/generated"
while IFS= read -r target; do
  mkdir -p "$tree/Sources/$target/Generated"
  "$(swift build --build-path "$build" --show-bin-path)/GenerateXynolog" "$root/protocol/specs/src" \
    Sources/XynologCodegen/required-schemas.json "$tree/Sources/$target/Generated/Models.swift" models
done < "$work/generated"
cp "$root/LICENSE" "$root/swift/distribution/NOTICE" "$root/swift/distribution/README.md" "$tree/"

# Installed as an application installs it: by URL, at exactly this version.
cp -a "$tree" "$work/sdk-swift"
git -C "$work/sdk-swift" init -q
git -C "$work/sdk-swift" add -A
git -C "$work/sdk-swift" -c user.name=distribution -c user.email=distribution@invalid commit -q -m "Xynolog SDK for Swift $version"
git -C "$work/sdk-swift" tag "$version"
cp -a "$root/swift/distribution/consumer" "$work/consumer"
cat > "$work/consumer/Package.swift" <<MANIFEST
// swift-tools-version: 6.2
import PackageDescription

let package = Package(
  name: "Consumer",
  dependencies: [.package(url: "file://$work/sdk-swift", exact: "$version")],
  targets: [
    .executableTarget(
      name: "Consumer",
      dependencies: [
        .product(name: "Xynolog", package: "sdk-swift"),
        .product(name: "XynologTesting", package: "sdk-swift"),
      ])
  ]
)
MANIFEST
cd "$work/consumer"
swift build --jobs 4
# How SwiftPM took the dependency: the pin names its kind.
cat Package.resolved
