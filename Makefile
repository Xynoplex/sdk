.DEFAULT_GOAL := local

.PHONY: help build test local local-stop verify-artifacts images cli desktop typescript python rust go csharp haskell kotlin ocaml swift go-build go-test clean

CONTAINER_RUNTIME ?=
export CONTAINER_RUNTIME
export SDK_ARTIFACTS

# Source operations run in containers. scripts/container-runtime.sh honors
# CONTAINER_RUNTIME, or detects container, docker, then podman.
help:
	@printf '%s\n' \
	  'Xynoplex SDK repository' \
	  '' \
	  '  make          Build and stage all nine SDKs from the pinned protocol submodule' \
	  '  make local    Build and stage all nine SDKs from the pinned protocol submodule' \
	  '  make images   Build TypeScript, Python, and Rust SDK artifacts' \
	  '  make cli      Build Go SDK artifacts' \
	  '  make desktop  Build TypeScript and Go artifacts used by Desktop and its Xynaut sidecar' \
	  '  make verify-artifacts SDK_ARTIFACTS=/path/to/bundle' \
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

images:
	bash scripts/publish-local.sh typescript,python,rust

cli:
	bash scripts/publish-local.sh go

desktop:
	bash scripts/publish-local.sh typescript,go

verify-artifacts:
	@test -n "$(SDK_ARTIFACTS)" || { echo 'Set SDK_ARTIFACTS to an artifact bundle path.' >&2; exit 2; }
	python3 scripts/verify-artifact-bundle.py "$(SDK_ARTIFACTS)"

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
