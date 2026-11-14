# TypeScript

[![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=typescript)](https://app.codecov.io/gh/Xynoplex/sdk/components)

The client side: the SDK and what it stands on. These are the consumer-facing TypeScript packages.

| Package | Published | Coverage | What it is |
|---|---|---|---|
| [@xynoplex/sdk](./sdk/README.md) | [![npm](https://img.shields.io/npm/v/@xynoplex/sdk)](https://www.npmjs.com/package/@xynoplex/sdk) | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=typescript-sdk)](https://app.codecov.io/gh/Xynoplex/sdk/components) | The TypeScript SDK: `XynoplexClient` and its verb namespaces, `XynoplexSession` and `XynoplexBrowser`, state units, and the cache behind live queries |
| [@xynoplex/react-ui](./react-ui/README.md) | [![npm](https://img.shields.io/npm/v/@xynoplex/react-ui)](https://www.npmjs.com/package/@xynoplex/react-ui) | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=typescript-react-ui)](https://app.codecov.io/gh/Xynoplex/sdk/components) | React components and hooks over the SDK: the resource viewer, the annotation components, and the `useStateUnit` and `useObservable` adapters |
| [@xynoplex/http-transport](./http-transport/README.md) | [![npm](https://img.shields.io/npm/v/@xynoplex/http-transport)](https://www.npmjs.com/package/@xynoplex/http-transport) | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=typescript-http-transport)](https://app.codecov.io/gh/Xynoplex/sdk/components) | How the SDK reaches a knowledge base over HTTP: `HttpTransport` and `HttpContentTransport`. The SDK depends on it |
| [@xynoplex/core](./core/README.md) | [![npm](https://img.shields.io/npm/v/@xynoplex/core)](https://www.npmjs.com/package/@xynoplex/core) | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=typescript-core)](https://app.codecov.io/gh/Xynoplex/sdk/components) | What every TypeScript package stands on: the protocol's types, generated from the spec, the ids, the event bus, and the contracts a transport implements |
| [@xynoplex/observability](./observability/README.md) | [![npm](https://img.shields.io/npm/v/@xynoplex/observability)](https://www.npmjs.com/package/@xynoplex/observability) | [![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=typescript-observability)](https://app.codecov.io/gh/Xynoplex/sdk/components) | Tracing and metrics for the TypeScript transport, on OpenTelemetry. It does nothing until a process is given somewhere to export to |

## Where things are

- The packages are npm workspaces of the repository's root, which installs and builds them all (`npm ci`, `npm run build:packages`).
- [`tsconfig.base.json`](./tsconfig.base.json) is what each package's `tsconfig.json` extends, and [`vitest.shared.config.ts`](./vitest.shared.config.ts) what each package's suite, and the Browser's, merges.
- Each package measures its coverage with `npm run test:coverage`, which CI uploads under the flag `typescript-<name>`.

The other languages, and which SDK a program installs, are in [packages/](../README.md).
