.DEFAULT_GOAL := build

.PHONY: help build test local local-stop go-build go-test clean

CONTAINER_RUNTIME ?=
export CONTAINER_RUNTIME

# Source operations run in containers. scripts/container-runtime.sh honors
# CONTAINER_RUNTIME, or detects container, docker, then podman.
help:
	@printf '%s\n' \
	  'Xynoplex SDK repository' \
	  '' \
	  '  make build    Build the Go SDK in a container' \
	  '  make test     Run Go SDK tests with coverage in a container' \
	  '  make local    Publish all SDKs to local package feeds' \
	  '  make local-stop Stop local package registries' \
	  '  make clean    Remove Go build outputs'

build: go-build

test: go-test

local:
	bash scripts/publish-local.sh

local-stop:
	bash scripts/publish-local.sh --stop

go-build:
	bash scripts/make-target.sh go-build

go-test:
	bash scripts/make-target.sh go-test

clean:
	bash scripts/make-target.sh clean
