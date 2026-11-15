.DEFAULT_GOAL := build

LANGUAGES := typescript python rust go csharp haskell kotlin ocaml swift

.PHONY: help build test verify-artifacts clean clean-local $(LANGUAGES) $(addsuffix -clean,$(LANGUAGES))

# `make help` prints the `##` lines below, in order (scripts/make-help.awk).
##@ Xynoplex SDK: make [target] [VARIABLE=value ...]
##@ Variables
## CONTAINER_RUNTIME=name: container|docker|podman; else the first to respond
CONTAINER_RUNTIME ?=
export CONTAINER_RUNTIME
## SDK_ARTIFACTS=path: Where a build writes its artifact bundle; the bundle verify-artifacts checks
export SDK_ARTIFACTS

help:
	@awk -v list="$(LANGUAGES)" -f scripts/make-help.awk Makefile Makefile

##@ Build and stage
## build: Every SDK, as local artifacts and an artifact bundle
build:
	bash scripts/publish-local.sh

## <language>: One SDK: <list>
$(LANGUAGES):
	bash scripts/publish-local.sh $@

## verify-artifacts: Check the artifact bundle SDK_ARTIFACTS names
verify-artifacts:
	@test -n "$(SDK_ARTIFACTS)" || { echo 'Set SDK_ARTIFACTS to an artifact bundle path.' >&2; exit 2; }
	python3 scripts/verify-artifact-bundle.py "$(SDK_ARTIFACTS)"

##@ Test
## test: The Go SDK's tests, writing coverage.txt
test:
	bash scripts/make-target.sh go-test

##@ Clean
## clean: Remove every language's output, the local artifacts, caches and bundles
clean:
	bash scripts/clean-sdk.sh all

## clean-local: Remove the local artifacts, caches and bundles
clean-local:
	bash scripts/clean-sdk.sh local

## <language>-clean: Remove one language's output and its package and compiler caches
$(addsuffix -clean,$(LANGUAGES)):
	bash scripts/clean-sdk.sh $(@:-clean=)
