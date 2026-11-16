# Xynolog SDKs

This repository contains the language SDKs and consumer-facing packages for building applications on Xynolog knowledge bases.

## Languages

- `typescript/` — client SDK, HTTP transport, core types, observability, and React UI
- `rust/` — client SDK, HTTP transport, telemetry, and its published code generator
- `python/` — Python SDK
- `go/` — Go SDK
- `csharp/`, `kotlin/`, `swift/`, `haskell/`, and `ocaml/` — SDK implementations under development

Each SDK subdirectory has a README with its package contents and development notes. Public packages use the Xynolog names and scopes.

The shared wire protocol, specifications, and portable conformance kit live in the pinned [`protocol` submodule](https://github.com/xynolog/protocol). SDK-specific generators and implementations remain in this repository.

### Protocol-derived code generation

`protocol/specs/src/` is the only source for protocol schemas and registries.
The SDK build checks that the submodule is initialized at the commit recorded by
this SDK commit, then generates the OpenAPI bundles from those sources before
building any language artifacts. Language generators remain in their SDK
directories and consume either those bundles or files under the same pinned
`protocol/specs/src/` tree. Generated SDK types and package artifacts are owned
and released here; the Protocol repository does not generate SDK code.

Do not substitute a sibling checkout or a moving Protocol branch. To change the
protocol input, update the `protocol` submodule pointer, regenerate the affected
SDK outputs, and build the SDK packages from that commit.

## Development

Run `git clone --recurse-submodules https://github.com/xynolog/sdk.git` (or initialize submodules after cloning), then run `make` at the repository root to build and stage all nine SDKs, or `make test` to run the Go SDK tests and write a Codecov report; `make help` lists every target. Build, test, clean, and local artifact targets use the runtime selected by `CONTAINER_RUNTIME`, or auto-detect `container`, `docker`, then `podman`. GitHub Actions checks the SDKs and uploads coverage. Dependabot checks the supported manifests for Go, Rust and its toolchain, TypeScript, Python (uv), .NET, Kotlin, Swift, and GitHub Actions; Dependabot does not currently support the Haskell or OCaml package manifests.

`make build` (the default) builds and stages all nine SDKs in local, ecosystem-native formats; run `make typescript`, `make python`, `make rust`, `make go`, `make csharp`, `make haskell`, `make kotlin`, `make ocaml`, or `make swift` to build one language. These targets create package archives and local feeds as files; they do not start npm, PyPI, or Cargo registry servers. Every SDK build and package toolchain runs in its language container. Native packages persist under `${XDG_CACHE_HOME:-~/.cache}/xynolog-sdk/local`. Each target also creates an immutable bundle containing its native artifacts and an `artifacts.json` manifest with SDK commit, working-tree digest, pinned Protocol commit, package coordinates, toolchains, and SHA-256 checksums. The default bundle path is under `${XDG_CACHE_HOME:-~/.cache}/xynolog-sdk/bundles`; set `SDK_ARTIFACTS` to select a destination:

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
| Swift | `swift` | SwiftPM package, as a release writes it to `xynolog/sdk-swift` |

`make clean` removes generated build directories and local package artifacts for all nine SDK languages, their SDK-scoped compiler and dependency caches, and cached artifact bundles. Use `make rust-clean` (or another `<language>-clean` target) to clean one language. It leaves downloaded container images and any bundle written to an external `SDK_ARTIFACTS` path untouched.

## Releasing

`version.json` names the coming release, `YY.M.N`, and each language's compatibility number; `scripts/sdk_version.py` derives every package version from them. A commit tagged `vYY.M.N` builds the release; every other commit builds a development version, which no registry receives.

To release, check out the commit on `main` and run `bash scripts/tag-release.sh`. It runs `scripts/release-ready.sh`, which checks four things:

- the committed manifests hold the release's versions;
- the release is not tagged on another commit;
- `main` holds the commit;
- the Protocol submodule is at a Protocol release.

It then signs and pushes `vYY.M.N` and Go's `go/vC.YYMM.N` together. Pushing `go/v…` releases the Go module, since the Go module proxy serves the tag from then on. The release workflow publishes nothing until it has fetched both tags and found each one annotated, named as pushed, on the commit, and signed by the key it trusts; it then runs the same checks again.

Once the release is tagged, CI fails until the coming release moves on: `python3 scripts/sdk_version.py move YY.M.N` writes a later one into `version.json` and every manifest, in a pull request of its own.

## License

Apache-2.0. See [LICENSE](./LICENSE) and [NOTICE](./NOTICE) for attribution.
