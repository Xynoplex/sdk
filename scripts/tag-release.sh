#!/usr/bin/env bash
# Tag this commit as the SDK release version.json names, and push the tags.
#
#   scripts/tag-release.sh
#
# A person runs it, with their own Git signer: each tag is annotated and
# signed, and the release workflow publishes nothing unless the key it trusts
# signed both. Pushing `go/v…` is itself the Go release, since the Go module
# proxy serves it from then on, so the release workflow's own checks run here
# first. The tags are pushed together or not at all.

set -euo pipefail
cd "$(dirname "$0")/.."

if [ -n "$(git status --porcelain)" ]; then
  echo "The working tree has changes: tag a commit as it is." >&2
  exit 1
fi
bash scripts/release-ready.sh

read -r -a tags <<< "$(python3 scripts/sdk_version.py tags)"
for tag in "${tags[@]}"; do
  git tag --sign --annotate --message "Xynolog SDK $tag" "$tag"
done
git push --atomic origin "${tags[@]}"
