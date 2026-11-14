# xynoplex-codegen

[![crates.io](https://img.shields.io/crates/v/xynoplex-codegen.svg)](https://crates.io/crates/xynoplex-codegen)
[![docs.rs](https://img.shields.io/docsrs/xynoplex-codegen)](https://docs.rs/xynoplex-codegen)
[![CI](https://github.com/Xynoplex/sdk/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/Xynoplex/sdk/actions/workflows/ci.yml?query=branch%3Amain)
[![License](https://img.shields.io/crates/l/xynoplex-codegen.svg)](https://github.com/Xynoplex/sdk/blob/main/LICENSE)
[![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=rust-codegen)](https://app.codecov.io/gh/Xynoplex/sdk/components)

The build-time code generator of the [Xynoplex Rust SDK](../sdk/README.md).
It turns the [Xynoplex specification](../../../protocol/specs/README.md), an OpenAPI
document and its JSON Schemas, into the Rust types of `xynoplex::types`.

## You do not need to add it

[`xynoplex`](https://crates.io/crates/xynoplex) names this crate as a build
dependency, so Cargo fetches and builds it when it builds the SDK. It runs
in the SDK's build script and is linked into no program. It is published
because a published crate's build dependencies have to be.

To use Xynoplex from Rust, add `xynoplex` and
[`xynoplex-http-transport`](../http-transport/README.md).

## What it does

| Module | |
|---|---|
| `bundle` | `Bundle::of(root_file)` reads a spec document and follows every file `$ref`, giving one whole document. `draft7_definitions` gives its component schemas as JSON Schema draft 7. |
| `types` | `generate(definitions, &generation)` gives the Rust source of the types: a struct per object, an enum per string enumeration, an untagged enum per `oneOf` or `anyOf` (decoded as the member its discriminating property names, when the schema names one), and a type of its own per kind of id, made only by a constructor that holds a value to the schema's pattern. |

It is not a general OpenAPI generator. It knows the shapes Xynoplex's schemas
use and refuses any other, so a schema that grows a new shape fails the
build rather than generating something wrong. Every function panics with
the reason: a build script has nothing better to do with a spec it cannot
read.

Two build scripts use it, and each is a worked example:
[the SDK's](../sdk/build.rs), for the protocol's types, and
[the services' shared crate's](../core/build.rs), for the types only a
service needs. One generator, so the two are never generated two ways.

Every item is documented on [docs.rs](https://docs.rs/xynoplex-codegen).

## License

Apache-2.0. See [LICENSE](../../../LICENSE).
