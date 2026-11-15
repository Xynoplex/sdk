#!/bin/sh
# go-toolchain.sh — the Go toolchain the SDK builds with, printed: the
# `toolchain` line of go/go.mod, without its "go". A Go image's tag
# (golang:<toolchain>) asks here; the go:generate line of go/api does.
#
# With no toolchain line it prints nothing and fails, so a build that cannot
# name its compiler stops. It is plain sh: an image with no bash can run it.
set -eu
cd "$(dirname "$0")/../.."

toolchain=$(sed -n 's/^toolchain go\([0-9][0-9.]*\)$/\1/p' go/go.mod)
if [ -z "$toolchain" ]; then
  echo "go-toolchain.sh: go/go.mod has no 'toolchain goX.Y.Z' line" >&2
  exit 1
fi
echo "$toolchain"
