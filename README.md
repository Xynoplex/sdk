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

Run `git clone --recurse-submodules https://github.com/Xynoplex/sdk.git` (or initialize submodules after cloning), then run `make` at the repository root to build and stage all nine SDKs, or `make test` to run the Go SDK tests and write a Codecov report. Build, test, clean, and local artifact targets use the runtime selected by `CONTAINER_RUNTIME`, or auto-detect `container`, `docker`, then `podman`. GitHub Actions checks the SDKs and uploads coverage. Dependabot checks the supported manifests for Go, Rust and its toolchain, TypeScript, Python (uv), .NET, Kotlin, Swift, and GitHub Actions; Dependabot does not currently support the Haskell or OCaml package manifests.

Run `make local` to build and stage all nine SDKs in local, ecosystem-native formats, or run `make typescript`, `make python`, `make rust`, `make go`, `make csharp`, `make haskell`, `make kotlin`, `make ocaml`, or `make swift` to build one language. These targets create package archives and local feeds as files; they do not start npm, PyPI, or Cargo registry servers. Every SDK build and package toolchain runs in its language container. Artifacts persist under `${XDG_CACHE_HOME:-~/.cache}/xynoplex-sdk/local`:

| SDK | Output | Format |
| --- | --- | --- |
| TypeScript | `npm/packages` | npm tarballs |
| Python | `python/packages` | wheel and source distribution |
| Rust | `rust/packages` | Cargo `.crate` archives |
| Go | `go-proxy` | file-based Go module proxy |
| C# | `nuget` | NuGet packages / folder feed |
| Haskell | `haskell` | Cabal source distribution |
| Kotlin | `kotlin-maven` | Maven repository |
| OCaml | `opam-repo/repo` | opam repository |
| Swift | `swift` | source archive |

`make local-stop` stops retired registry containers from older versions of the local build and retains cached package artifacts.

## License

Apache-2.0. See [LICENSE](./LICENSE) and [NOTICE](./NOTICE) for attribution.
