# Xynoplex SDKs

This repository contains the language SDKs and consumer-facing packages for building applications on Xynoplex knowledge bases.

## Languages

- `typescript/` — client SDK, HTTP transport, core types, observability, and React UI
- `rust/` — client SDK, HTTP transport, telemetry, and its published code generator
- `python/` — Python SDK
- `go/` — Go SDK
- `csharp/`, `kotlin/`, `swift/`, `haskell/`, and `ocaml/` — SDK implementations under development

Each SDK subdirectory has a README with its package contents and development notes. Public packages use the Xynoplex names and scopes.

The shared wire protocol, specifications, and portable conformance kit live in the pinned [`protocol` submodule](https://github.com/Xynoplex/protocol). SDK-specific generators and implementations remain in this repository.

## Development

Run `git clone --recurse-submodules https://github.com/Xynoplex/sdk.git` (or initialize submodules after cloning), then run `make` at the repository root to build the Go SDK, or `make test` to run its tests and write a Codecov report. Build, test, clean, local publish, and local registry stop targets use the runtime selected by `CONTAINER_RUNTIME`, or auto-detect `container`, `docker`, then `podman`. GitHub Actions checks the SDKs and uploads coverage. Dependabot checks the supported manifests for Go, Rust and its toolchain, TypeScript, Python (uv), .NET, Kotlin, Swift, and GitHub Actions; Dependabot does not currently support the Haskell or OCaml package manifests.

Run `make local` to build and stage all nine SDKs in local, ecosystem-native formats. TypeScript packages are written as npm tarballs under `npm/packages`; no npm registry is started. The target starts a PyPI-compatible index at `http://localhost:8081/simple/` and Kellnr at `http://localhost:8000`. Every SDK build and package toolchain runs in its language container. Package data persists in `${XDG_CACHE_HOME:-~/.cache}/xynoplex-sdk/local`. Go uses a file-based module proxy, .NET a NuGet folder feed, Haskell a Cabal source distribution, Kotlin a Maven repository, OCaml a local opam repository, and Swift a source archive. `make local-stop` stops the registry containers without deleting package data.

## License

Apache-2.0. See [LICENSE](./LICENSE) and [NOTICE](./NOTICE) for attribution.
