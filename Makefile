.DEFAULT_GOAL := local

.PHONY: help build test local local-stop verify-artifacts images cli desktop typescript python rust go csharp haskell kotlin ocaml swift go-build go-test clean clean-local typescript-clean python-clean rust-clean go-clean csharp-clean haskell-clean kotlin-clean ocaml-clean swift-clean

CONTAINER_RUNTIME ?=
export CONTAINER_RUNTIME
export SDK_ARTIFACTS

# Source operations run in containers. scripts/container-runtime.sh honors
# CONTAINER_RUNTIME, or detects container, docker, then podman.
help:
	@printf '%s\n' \
	  'Xynoplex SDK' \
	  '' \
	  'Build and stage:' \
	  '  make                  Build and stage all nine SDKs (default target)' \
	  '  make local            Same as make' \
	  '  make <language>       Build one SDK: typescript, python, rust, go, csharp,' \
	  '                       haskell, kotlin, ocaml, or swift' \
	  '  make images           Build TypeScript, Python, and Rust artifacts' \
	  '  make cli              Build Go artifacts' \
	  '  make desktop          Build TypeScript and Go artifacts for Desktop and Xynaut' \
	  '  make verify-artifacts SDK_ARTIFACTS=/path/to/bundle' \
	  '' \
	  'Build and test Go:' \
	  '  make build            Build the Go SDK' \
	  '  make test             Run Go SDK tests with coverage' \
	  '' \
	  'Clean:' \
	  '  make clean            Remove all language outputs, local artifacts, caches, and bundles' \
	  '  make clean-local      Remove local artifacts, caches, bundles, and retired containers' \
	  '  make <language>-clean Clean one language and its local package/compiler caches' \
	  '  make local-stop       Stop retired registry containers; preserve cached artifacts'

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
	bash scripts/clean-sdk.sh all

clean-local:
	bash scripts/clean-sdk.sh local

typescript-clean python-clean rust-clean go-clean csharp-clean haskell-clean kotlin-clean ocaml-clean swift-clean:
	bash scripts/clean-sdk.sh $(@:-clean=)
