#!/usr/bin/env bash
set -euo pipefail

# Publish all @xynolog/* packages to a registry, or pack them as local tarballs.
#
# Usage:
#   ./typescript/scripts/publish.sh [options]
#
# Options:
#   --registry <url>   Target registry (default: https://registry.npmjs.org)
#   --tag <tag>        Dist tag: latest or dev (default: latest)
#   --version <ver>    The version to publish (scripts/sdk_version.py typescript); required
#   --clean            Unpublish existing versions before publishing (for local registries)
#   --npmrc <path>     Path to .npmrc for registry auth
#   --pack-dir <path>  Write npm package tarballs to a directory instead
#   --dry-run          Stage but do not publish

# The repository root, found from where this script lives rather than asked of
# git: in a container that runs as root over a checkout owned by another user,
# git refuses the repository ("dubious ownership").
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# --- Colors ---

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

banner() { echo -e "\n${CYAN}${BOLD}══════════════════════════════════════════════════════════════${RESET}"; echo -e "${CYAN}${BOLD}  $1${RESET}"; echo -e "${CYAN}${BOLD}══════════════════════════════════════════════════════════════${RESET}\n"; }
step()   { echo -e "${GREEN}▸${RESET} $1"; }
ok()     { echo -e "${GREEN}✓${RESET} $1"; }

# --- Parse arguments ---

REGISTRY="https://registry.npmjs.org"
TAG="latest"
VERSION=""
CLEAN=false
NPMRC=""
PACK_DIR=""
DRY_RUN=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --registry) REGISTRY="$2"; shift 2 ;;
    --tag) TAG="$2"; shift 2 ;;
    --version) VERSION="$2"; shift 2 ;;
    --clean) CLEAN=true; shift ;;
    --npmrc) NPMRC="$2"; shift 2 ;;
    --pack-dir) PACK_DIR="$2"; shift 2 ;;
    --dry-run) DRY_RUN=true; shift ;;
    *) echo -e "${RED}Unknown argument: $1${RESET}" >&2; exit 1 ;;
  esac
done

# --- Determine version ---

if [[ -z "$VERSION" ]]; then
  echo -e "${RED}--version is required: the version scripts/sdk_version.py typescript gives this build${RESET}" >&2
  exit 1
fi

banner "STAMP VERSIONS"
if [[ -n "$PACK_DIR" ]]; then
  echo -e "  Version: ${BOLD}$VERSION${RESET}  Artifact directory: ${DIM}$PACK_DIR${RESET}"
else
  echo -e "  Version: ${BOLD}$VERSION${RESET}  Tag: ${BOLD}$TAG${RESET}  Registry: ${DIM}$REGISTRY${RESET}"
fi
echo ""

node typescript/scripts/stamp-versions.mjs "$VERSION"

# --- Stage app packages ---

banner "STAGE APPS"
node typescript/scripts/publish-npm-apps.mjs

# --- Build npmrc args ---

NPMRC_ARGS=()
if [[ -n "$NPMRC" ]]; then
  NPMRC_ARGS=(--userconfig "$NPMRC")
fi

# --- Publish ---

banner "PUBLISH PACKAGES"

publish_pkg() {
  local dir="$1"
  local label="${2:-}"
  local pkg_name pkg_version
  pkg_name=$(node -p "require('./$dir/package.json').name")
  pkg_version=$(node -p "require('./$dir/package.json').version")

  if [[ -n "$PACK_DIR" ]]; then
    # npm packs a LICENSE only from the directory it packs, and this repository
    # keeps the license at its root.
    cp LICENSE "$dir/LICENSE"
    (cd "$dir" && npm pack --loglevel=warn --pack-destination "$PACK_DIR")
    ok "$pkg_name@$pkg_version packed"
    return 0
  elif [[ "$CLEAN" == "true" ]]; then
    echo -e "  ${DIM}unpublish${RESET} $pkg_name@$pkg_version"
    npm unpublish "$pkg_name@$pkg_version" --registry "$REGISTRY" "${NPMRC_ARGS[@]}" --force 2>/dev/null || true
  fi

  if [[ "$DRY_RUN" == "true" ]]; then
    echo -e "  ${YELLOW}dry-run${RESET}  $pkg_name@$pkg_version${label:+ ($label)}"
  elif npm view "$pkg_name@$pkg_version" version --registry "$REGISTRY" "${NPMRC_ARGS[@]}" >/dev/null 2>&1; then
    # A partial publish leaves earlier packages live and later ones missing, and
    # npm refuses to republish a version — so without this the retry dies on the
    # first already-published package and never reaches the ones that failed.
    # Announced, never silent: a skip is a decision the log has to show.
    echo -e "  ${DIM}exists${RESET}   $pkg_name@$pkg_version${label:+ ($label)} — already published, skipping"
  else
    # npm publishes a LICENSE only from the directory it publishes, and the
    # repository has one LICENSE, at its root.
    cp LICENSE "$dir/LICENSE"
    # --loglevel=warn drops npm's per-file "Tarball Contents" listing, which for
    # react-ui alone is ~100 lines of dist/*.js and .map entries. Warnings and
    # errors still print; the `ok` line below is the signal worth reading.
    (cd "$dir" && npm publish --loglevel=warn --registry "$REGISTRY" --tag "$TAG" --access public "${NPMRC_ARGS[@]}")
    ok "$pkg_name@$pkg_version${label:+ ($label)}"
  fi
}

# Iterate every publishable package in version.json. Output is two
# tab-separated columns: dir-to-publish-from, label. Apps with a
# `stage` field publish from .npm-stage/<x> rather than from their own directory.
PUBLISH_LIST=$(node -e "
  const v = JSON.parse(require('fs').readFileSync('version.json', 'utf-8'));
  for (const pkg of Object.values(v.packages)) {
    if (!pkg.publish) continue;
    const dir = pkg.stage || pkg.dir;
    const label = pkg.stage ? 'staged' : '';
    console.log(dir + '\t' + label);
  }
")

while IFS=$'\t' read -r dir label; do
  publish_pkg "$dir" "$label"
done <<< "$PUBLISH_LIST"

banner "PUBLISH COMPLETE ✓"
