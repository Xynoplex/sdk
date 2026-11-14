# Xynoplex SDKs

This repository contains the language SDKs and consumer-facing packages for building applications on Xynoplex knowledge bases.

## Languages

- `typescript/` — client SDK, HTTP transport, core types, observability, and React UI
- `rust/` — client SDK, HTTP transport, telemetry, and its published code generator
- `python/` — Python SDK
- `go/` — Go SDK
- `csharp/`, `kotlin/`, `swift/`, `haskell/`, and `ocaml/` — SDK implementations under development

Each SDK subdirectory has a README with its package contents and development notes. Public packages use the Xynoplex names and scopes.

The shared wire protocol, specifications, and portable conformance kit live in the pinned [`protocol` submodule](https://github.com/Xynoplex/protocol). The Go SDK tests read the protocol's language-neutral case tables from that revision. SDK-specific generators and implementations remain in this repository.

## Development

Run `git clone --recurse-submodules https://github.com/Xynoplex/sdk.git` (or initialize submodules after cloning), then run `make` at the repository root to build the Go SDK, or `make test` to run its tests and write a Codecov report. The other SDKs' build and test commands are documented in each language directory. GitHub Actions checks the Go SDK against the pinned protocol revision and uploads its coverage. Dependabot checks the supported manifests for Go, Rust and its toolchain, TypeScript, Python (uv), .NET, Kotlin, Swift, and GitHub Actions; Dependabot does not currently support the Haskell or OCaml package manifests.

## License

Apache-2.0. See [LICENSE](./LICENSE) and [NOTICE](./NOTICE) for attribution.
