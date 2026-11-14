.DEFAULT_GOAL := build

.PHONY: help build test go-build go-test clean

MONOREPO_ROOT ?= ../semiont

# The extracted SDKs still consume protocol/specs from the monorepo. Until
# those specs are published as their own repository, this root build covers
# the Go SDK, whose generated protocol surface is checked in.
help:
	@printf '%s\n' \
	  'Xynoplex SDK repository' \
	  '' \
	  '  make build    Build the standalone Go SDK' \
	  '  make test     Run Go SDK tests with coverage (needs the monorepo protocol specs)' \
	  '  make clean    Remove Go build outputs'

build: go-build

test: go-test

go-build:
	cd go/sdk && go build ./...

go-test:
	@set -eu; linked=0; repo_root=$$(pwd -P); \
	if [ ! -d protocol/specs/src ]; then \
	  if [ ! -d "$(MONOREPO_ROOT)/protocol/specs/src" ]; then \
	    echo 'Go SDK tests need protocol/specs/src from the semiont monorepo.' >&2; \
	    echo 'Pass MONOREPO_ROOT=/path/to/semiont or check out the monorepo beside this repository.' >&2; \
	    exit 1; \
	  fi; \
	  ln -s "$(MONOREPO_ROOT)/protocol" protocol; linked=1; \
	fi; \
	trap '[ "$$linked" -eq 0 ] || rm "$$repo_root/protocol"' EXIT; \
	cd "$$repo_root/go/sdk" && go test -race -coverprofile=../../coverage.txt -covermode=atomic ./...

clean:
	rm -f coverage.txt
	cd go/sdk && go clean
