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

## License

Apache-2.0. See [LICENSE](./LICENSE) and [NOTICE](./NOTICE) for attribution.
