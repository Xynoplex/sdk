.DEFAULT_GOAL := local

.PHONY: help build test local local-stop typescript python rust go csharp haskell kotlin ocaml swift go-build go-test clean

CONTAINER_RUNTIME ?=
export CONTAINER_RUNTIME

# Source operations run in containers. scripts/container-runtime.sh honors
# CONTAINER_RUNTIME, or detects container, docker, then podman.
help:
	@printf '%s\n' \
	  'Xynoplex SDK repository' \
	  '' \
	  '  make          Build and stage all nine SDKs (same as make local)' \
	  '  make local    Build and stage all nine SDKs' \
	  '  make <sdk>    Build one SDK: typescript, python, rust, go, csharp,' \
	  '                haskell, kotlin, ocaml, or swift' \
	  '  make build    Build the Go SDK' \
	  '  make test     Run Go SDK tests with coverage' \
	  '  make clean    Remove Go build outputs' \
	  '  make local-stop Stop retired registry containers; keep cached artifacts'

build: go-build

test: go-test

local:
	bash scripts/publish-local.sh

typescript python rust go csharp haskell kotlin ocaml swift:
	bash scripts/publish-local.sh $@

local-stop:
	bash scripts/publish-local.sh --stop

go-build:
	bash scripts/make-target.sh go-build

go-test:
	bash scripts/make-target.sh go-test

clean:
	bash scripts/make-target.sh clean
