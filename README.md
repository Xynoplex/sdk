# Xynoplex SDKs

This repository contains the language SDKs and consumer-facing packages for building applications on Xynoplex knowledge bases.

## Languages

- `typescript/` — client SDK, HTTP transport, core types, observability, and React UI
- `rust/` — client SDK, HTTP transport, telemetry, and its published code generator
- `python/` — Python SDK
- `go/` — Go SDK
- `csharp/`, `kotlin/`, `swift/`, `haskell/`, and `ocaml/` — SDK implementations under development

Each SDK subdirectory has a README with its package contents and development notes. Public packages use the Xynoplex names and scopes.

The wire protocol and its specifications remain in the original monorepo for now. Some generation and conformance tooling still expects `protocol/specs/` and shared generators from the monorepo. Those remain there for now; neither is copied into this repository.

## Development

Run `make` at the repository root to build the Go SDK, or `make test` to run its tests and write a Codecov report. Go's tests use protocol fixtures retained in the monorepo; pass `MONOREPO_ROOT=/path/to/semiont` when that checkout is not at `../semiont`. The other SDKs also need the protocol specs and generators retained in the monorepo, so their complete build and test commands remain documented in each language directory. GitHub Actions checks the Go SDK against the monorepo protocol and uploads its coverage. Dependabot checks the supported manifests for Go, Rust and its toolchain, TypeScript, Python (uv), .NET, Kotlin, Swift, and GitHub Actions; Dependabot does not currently support the Haskell or OCaml package manifests.

## License

Apache-2.0. See [LICENSE](./LICENSE) and [NOTICE](./NOTICE) for attribution.
