# Rust

[![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=rust)](https://app.codecov.io/gh/Xynoplex/sdk/components)

The first four are how a Rust program uses Xynoplex. The last three are what the Rust services share, and are built into their binaries. A service's own crates are beside its binary in [images/](../../images/README.md).

| Crate | Published | Coverage | What it is |
|---|---|---|---|
| [xynoplex](./sdk/README.md) | [![crates.io](https://img.shields.io/crates/v/xynoplex.svg)](https://crates.io/crates/xynoplex) | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=rust-sdk)](https://app.codecov.io/gh/Xynoplex/sdk/components) | The Rust SDK: the client of a knowledge base, the protocol's types, sessions and state units |
| [xynoplex-http-transport](./http-transport/README.md) | [![crates.io](https://img.shields.io/crates/v/xynoplex-http-transport.svg)](https://crates.io/crates/xynoplex-http-transport) | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=rust-http-transport)](https://app.codecov.io/gh/Xynoplex/sdk/components) | The SDK's transport over a gateway, and signing a person or a service in |
| [xynoplex-telemetry](./telemetry/README.md) | [![crates.io](https://img.shields.io/crates/v/xynoplex-telemetry.svg)](https://crates.io/crates/xynoplex-telemetry) | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=rust-telemetry)](https://app.codecov.io/gh/Xynoplex/sdk/components) | The SDK's spans and counts, reported to whatever OpenTelemetry the application installed. It exports nothing |
| [xynoplex-codegen](./codegen/README.md) | [![crates.io](https://img.shields.io/crates/v/xynoplex-codegen.svg)](https://crates.io/crates/xynoplex-codegen) | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=rust-codegen)](https://app.codecov.io/gh/Xynoplex/sdk/components) | The build-time generator of Rust types from the spec. A build dependency of `xynoplex`: nobody adds it by hand |
| [xynoplex-core](./core/README.md) | Not published | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=rust-core)](https://app.codecov.io/gh/Xynoplex/sdk/components) | What the Rust services share and no client needs: the embedded spec and its validators, the configuration documents, the reach to the messaging broker |
| [xynoplex-http-service](./http-service/README.md) | Not published | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=rust-http-service)](https://app.codecov.io/gh/Xynoplex/sdk/components) | What the Rust services that serve HTTP share: connections a service can close from its side, the bearer credential, and the verifier of tokens from the trusted issuer |
| [xynoplex-observability](./observability/README.md) | Not published | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=rust-observability)](https://app.codecov.io/gh/Xynoplex/sdk/components) | What a Rust service writes about itself: telemetry exported over OTLP, and log lines |

## Where things are

- One Cargo workspace, rooted here: [`Cargo.toml`](./Cargo.toml) names these crates and the Rust images' (`images/gateway`, `images/dispatcher`, `images/archivist`), beside [`Cargo.lock`](./Cargo.lock), cargo-deny's [`deny.toml`](./deny.toml) and the [`rust-toolchain.toml`](./rust-toolchain.toml) every Rust build takes its compiler from. Run `cargo` here; its build output is `target/`.
- CI measures the workspace's coverage twice, and Codecov adds the two under each crate's flag, `rust-<name>`, scoped to the crate's directory. Rust Tests runs the crates' own tests under `cargo llvm-cov`. And the six binaries the conformance suites start (the three services and the SDK's three drivers) are built instrumented: every suite keeps what they ran, and Rust Coverage merges it into one report. The services and the crates only they use, `xynoplex-core`, `xynoplex-http-service` and `xynoplex-observability`, are tested by those suites, and that report is where their tests are counted.

The other languages, and which SDK a program installs, are in [packages/](../README.md).
