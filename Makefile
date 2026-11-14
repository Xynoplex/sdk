.DEFAULT_GOAL := build

.PHONY: help build test go-build go-test clean

# Protocol schemas and behavior tables are pinned as the `protocol` submodule.
help:
	@printf '%s\n' \
	  'Xynoplex SDK repository' \
	  '' \
	  '  make build    Build the standalone Go SDK' \
	  '  make test     Run Go SDK tests with coverage (needs the protocol submodule)' \
	  '  make clean    Remove Go build outputs'

build: go-build

test: go-test

go-build:
	cd go/sdk && go build ./...

go-test:
	@test -f protocol/specs/src/graph/codec-cases.json || { \
	  echo 'Protocol specs are missing. Clone with --recurse-submodules or run: git submodule update --init --recursive' >&2; \
	  exit 1; \
	}
	cd go/sdk && go test -race -coverprofile=../../coverage.txt -covermode=atomic ./...

clean:
	rm -f coverage.txt
	cd go/sdk && go clean
