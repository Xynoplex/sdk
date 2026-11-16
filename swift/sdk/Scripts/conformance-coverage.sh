#!/bin/sh
set -eu
# The package is the repository's: its manifest is at the root.
cd "$(dirname "$0")/../../.."
llvm-profdata merge -sparse .build/conformance/profiles/*.profraw -o .build/conformance/coverage.profdata
llvm-cov export -format=lcov .build/conformance/bin/XynologWireDriver \
  -instr-profile=.build/conformance/coverage.profdata \
  -ignore-filename-regex='(/Conformance/|/\.build/)' > .build/conformance/coverage.lcov
# The build and export run at the same mount point; make filenames repository-relative.
repo=$(pwd)
awk -v prefix="SF:$repo/" 'index($0, prefix) == 1 { $0="SF:" substr($0, length(prefix)+1) } { print }' \
  .build/conformance/coverage.lcov > .build/conformance/coverage.relative.lcov
mv .build/conformance/coverage.relative.lcov .build/conformance/coverage.lcov
# A nonempty lcov file could still report no library execution.
awk '/^DA:/ { split($0, fields, ","); if (fields[2] > 0) ran=1 } END { exit !ran }' .build/conformance/coverage.lcov
