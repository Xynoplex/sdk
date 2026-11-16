#!/usr/bin/env bash
set -euo pipefail

# Invariant A5: gathered context is SDK state, never component state.
#
# 1. No `useResourceGather`: a react-ui hook of that name holds a
#    GatheredContext in component-local useState.
# 2. No react-ui source holds a GatheredContext in useState — the
#    page reads the gather state unit's slots (`context$`/`resourceContext$`
#    and friends) and threads props. A component that needs gathered context
#    receives it; one that needs a gather calls the unit.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SOURCE="$REPO_ROOT/typescript/react-ui/src"
[ -d "$SOURCE" ] || { echo "❌ $SOURCE is not a directory" >&2; exit 2; }
violations=0

if grep -rn "useResourceGather" "$SOURCE" --include='*.ts' --include='*.tsx'; then
  echo "❌ useResourceGather is present (components receive gather state as props)"
  violations=1
fi

if grep -rn "useState<GatheredContext" "$SOURCE" --include='*.ts' --include='*.tsx'; then
  echo "❌ a component holds GatheredContext in useState — gather state lives in the SDK's units"
  violations=1
fi

if [ "$violations" -ne 0 ]; then
  exit 1
fi
echo "✅ gathered context stays in the SDK's state units (invariant A5)"
