# Protocol-derived SDK code

`protocol/` is the SDK's sole Protocol input. It is a Git submodule, and its
revision is part of every SDK source revision. SDK builds reject an uninitialized,
mismatched, or modified submodule. They never select a sibling checkout or a
branch tip.

Before producing language artifacts, `make build` bundles both OpenAPI documents
from `protocol/specs/src/` using the Protocol repository's locked toolchain. The
language generators then read those bundles or the same pinned `specs/src/`
files. Generated SDK code belongs to this repository, not Protocol.

Generation runs as part of building the SDK artifact, with language-native tools:

| SDK | Protocol-derived output | Generation point |
| --- | --- | --- |
| TypeScript | OpenAPI types, validators, registries, limits, and client tables | Package build; emitted npm packages carry built output |
| Python | OpenAPI models | Drift check and package build; wheel carries generated models |
| Go | REST client and registry tables | SDK-owned generators; module artifact carries generated Go source |
| Rust | Wire types, bus operations, and protocol tables | Cargo build script; the crate carries the pinned inputs and generator dependency |
| C# | API and protocol types | .NET package build from the pinned submodule |
| Kotlin | API types and tables | Gradle generation task before compilation; Maven artifact carries compiled output |
| Swift | Wire models and protocol tables | SwiftPM plugin; source archive carries the same pinned Protocol tree at the package's expected relative path |
| Haskell | Protocol and conformance tables | SDK-owned generator and checks |
| OCaml | Bus registry and protocol tables | SDK-owned generator and checks |

A Protocol change therefore follows one path: update the SDK's submodule pointer,
regenerate and drift-check the SDK-owned outputs, build the affected native
packages, and record that Protocol commit in the artifact manifest. Product
repositories consume those packages; they do not regenerate SDK types from a
separate Protocol checkout.
