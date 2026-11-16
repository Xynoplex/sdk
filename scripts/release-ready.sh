#!/usr/bin/env bash
# What a release of this commit needs, checked before it is tagged and again
# before anything is published:
#
#   - the committed manifests hold the coming release's versions;
#   - the coming release is not tagged on another commit;
#   - main holds the commit, so its release workflow and the signing key it
#     trusts came through a pull request;
#   - its Protocol submodule is at a released Protocol, `vYY.M.N`.
#
#   scripts/release-ready.sh

set -euo pipefail
cd "$(dirname "$0")/.."

fail() { echo "::error::$1" >&2; exit 1; }

python3 scripts/sdk_version.py check
python3 scripts/sdk_version.py unreleased

git fetch --quiet origin main
git merge-base --is-ancestor HEAD FETCH_HEAD || fail "main does not hold $(git rev-parse HEAD)"

protocol="$(git rev-parse HEAD:protocol)"
url="$(git config --file .gitmodules submodule.protocol.url)"
released="$(git ls-remote --tags "$url" \
  | grep -E "^$protocol"$'\t'"refs/tags/v[0-9]{2}\.([1-9]|1[0-2])\.(0|[1-9][0-9]*)(\^\{\})?$" \
  | sed -E 's#^.*refs/tags/##; s#\^\{\}$##' | sort -u || true)"
test -n "$released" || fail "the Protocol submodule's commit $protocol is not a Protocol release (no vYY.M.N tag at it in $url)"
echo "Protocol $released, at $protocol."
