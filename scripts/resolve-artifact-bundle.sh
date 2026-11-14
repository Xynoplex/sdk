#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
if [[ $# -eq 0 ]]; then
  echo "Usage: $0 <language> [language ...]" >&2
  exit 2
fi
LANGUAGES=("$@")

if [[ -n "${SDK_ARTIFACTS:-}" ]]; then
  BUNDLE="$(cd "$SDK_ARTIFACTS" && pwd -P)"
else
  LANGUAGES_CSV="$(IFS=,; printf '%s' "${LANGUAGES[*]}")"
  bash "$ROOT/scripts/publish-local.sh" "$LANGUAGES_CSV" >&2
  BUNDLE="$(python3 "$ROOT/scripts/create-artifact-bundle.py" --path "${LANGUAGES[@]}")"
fi

VERIFY_ARGS=()
for language in "${LANGUAGES[@]}"; do
  VERIFY_ARGS+=(--language "$language")
done
python3 "$ROOT/scripts/verify-artifact-bundle.py" "$BUNDLE" "${VERIFY_ARGS[@]}" >/dev/null
printf '%s\n' "$BUNDLE"
