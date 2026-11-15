# Rust

[![codecov](https://codecov.io/gh/xynolog/sdk/graph/badge.svg?component=rust)](https://app.codecov.io/gh/xynolog/sdk/components)

The first four are how a Rust program uses Xynolog. The last three are what the Rust services share, and are built into their binaries. A service's own crates are beside its binary in [images/](../../images/README.md).

| Crate | Published | Coverage | What it is |
|---|---|---|---|
| [xynolog](./sdk/README.md) | [![crates.io](https://img.shields.io/crates/v/xynolog.svg)](https://crates.io/crates/xynolog) | [![codecov](https://codecov.io/gh/xynolog/sdk/graph/badge.svg?component=rust-sdk)](https://app.codecov.io/gh/xynolog/sdk/components) | The Rust SDK: the client of a knowledge base, the protocol's types, sessions and state units |
| [xynolog-http-transport](./http-transport/README.md) | [![crates.io](https://img.shields.io/crates/v/xynolog-http-transport.svg)](https://crates.io/crates/xynolog-http-transport) | [![codecov](https://codecov.io/gh/xynolog/sdk/graph/badge.svg?component=rust-http-transport)](https://app.codecov.io/gh/xynolog/sdk/components) | The SDK's transport over a gateway, and signing a person or a service in |
| [xynolog-telemetry](./telemetry/README.md) | [![crates.io](https://img.shields.io/crates/v/xynolog-telemetry.svg)](https://crates.io/crates/xynolog-telemetry) | [![codecov](https://codecov.io/gh/xynolog/sdk/graph/badge.svg?component=rust-telemetry)](https://app.codecov.io/gh/xynolog/sdk/components) | The SDK's spans and counts, reported to whatever OpenTelemetry the application installed. It exports nothing |
| [xynolog-codegen](./codegen/README.md) | [![crates.io](https://img.shields.io/crates/v/xynolog-codegen.svg)](https://crates.io/crates/xynolog-codegen) | [![codecov](https://codecov.io/gh/xynolog/sdk/graph/badge.svg?component=rust-codegen)](https://app.codecov.io/gh/xynolog/sdk/components) | The build-time generator of Rust types from the spec. A build dependency of `xynolog`: nobody adds it by hand |
| [xynolog-core](./core/README.md) | Not published | [![codecov](https://codecov.io/gh/xynolog/sdk/graph/badge.svg?component=rust-core)](https://app.codecov.io/gh/xynolog/sdk/components) | What the Rust services share and no client needs: the embedded spec and its validators, the configuration documents, the reach to the messaging broker |
| [xynolog-http-service](./http-service/README.md) | Not published | [![codecov](https://codecov.io/gh/xynolog/sdk/graph/badge.svg?component=rust-http-service)](https://app.codecov.io/gh/xynolog/sdk/components) | What the Rust services that serve HTTP share: connections a service can close from its side, the bearer credential, and the verifier of tokens from the trusted issuer |
| [xynolog-observability](./observability/README.md) | Not published | [![codecov](https://codecov.io/gh/xynolog/sdk/graph/badge.svg?component=rust-observability)](https://app.codecov.io/gh/xynolog/sdk/components) | What a Rust service writes about itself: telemetry exported over OTLP, and log lines |

## Where things are

- One Cargo workspace, rooted here: [`Cargo.toml`](./Cargo.toml) names these crates and the Rust images' (`images/gateway`, `images/dispatcher`, `images/archivist`), beside [`Cargo.lock`](./Cargo.lock), cargo-deny's [`deny.toml`](./deny.toml) and the [`rust-toolchain.toml`](./rust-toolchain.toml) every Rust build takes its compiler from. Run `cargo` here; its build output is `target/`.
- CI measures the workspace's coverage twice, and Codecov adds the two under each crate's flag, `rust-<name>`, scoped to the crate's directory. Rust Tests runs the crates' own tests under `cargo llvm-cov`. And the six binaries the conformance suites start (the three services and the SDK's three drivers) are built instrumented: every suite keeps what they ran, and Rust Coverage merges it into one report. The services and the crates only they use, `xynolog-core`, `xynolog-http-service` and `xynolog-observability`, are tested by those suites, and that report is where their tests are counted.

The other languages, and which SDK a program installs, are in [packages/](../README.md).
