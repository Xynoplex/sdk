# @xynoplex/core

[![Tests](https://github.com/Xynoplex/sdk/actions/workflows/ci.yml/badge.svg)](https://github.com/Xynoplex/sdk/actions/workflows/ci.yml?query=branch%3Amain+is%3Asuccess+job%3A%22Test+core%22)
[![codecov](https://codecov.io/gh/Xynoplex/sdk/graph/badge.svg?component=typescript-core)](https://app.codecov.io/gh/Xynoplex/sdk/components)
[![npm version](https://img.shields.io/npm/v/@xynoplex/core.svg)](https://www.npmjs.com/package/@xynoplex/core)
[![npm downloads](https://img.shields.io/npm/dm/@xynoplex/core.svg)](https://www.npmjs.com/package/@xynoplex/core)
[![License](https://img.shields.io/npm/l/@xynoplex/core.svg)](https://github.com/Xynoplex/sdk/blob/main/LICENSE)

What every TypeScript package in Xynoplex stands on: the protocol's types, generated from the [spec](../../../protocol/specs/README.md), and the logic that has to be the same wherever it runs. That is ids, the event bus and its channels, the transport contract, annotations and how they are anchored, and identities.

## Who uses it

Every other TypeScript package, the Browser, and the conformance and end-to-end suites. It depends on no other Xynoplex package.

**Building an application?** Use [`@xynoplex/sdk`](../sdk/README.md). It re-exports what an application needs from here, the id constructors and the error types among them, and an application rarely imports this package by name.

## What is in it

| Area | What | Where |
|---|---|---|
| The protocol's types | `components`, `paths`, `operations`: every request, response and schema | `src/types.ts`, generated when the package is built and not committed |
| Ids | `ResourceId`, `AnnotationId`, `JobId`, `UserId`, each with a constructor that holds text to its rule and a guard that asks without throwing | `src/generated/identifiers.ts`, generated |
| The bus | `EventBus`, the `EventMap` of every channel and its payload, and `Bus`, the typed bus over a transport, whose `request` is a request and its reply | [src/event-bus.ts](src/event-bus.ts), [src/bus-protocol.ts](src/bus-protocol.ts), [src/bus.ts](src/bus.ts), [src/bus-request.ts](src/bus-request.ts) |
| The record's events | `PersistedEvent`, `StoredEvent`, and the list of every event type a knowledge base records | [src/persisted-events.ts](src/persisted-events.ts), [src/event-base.ts](src/event-base.ts) |
| The transport contract | `ITransport`, `IContentTransport`, `IGatewayOperations`: what a client needs of the wire | [src/transport.ts](src/transport.ts) |
| Annotations | Building one (`reconcile`, `annotationOfSpan`, `annotationOfResource`), and reading its target, its selectors and its links | [src/annotation-builders.ts](src/annotation-builders.ts), [src/web-annotation-utils.ts](src/web-annotation-utils.ts) |
| Anchoring | Finding an annotation again after its text changed, and the geometry of text on a PDF page (`locate`, `textUnder`) | [src/anchor-annotation.ts](src/anchor-annotation.ts), [src/pdf-anchoring.ts](src/pdf-anchoring.ts) |
| Identity | A knowledge base's own did and resource identifier (`kbDid`, `kbResource`). A principal's DID is the gateway's to mint and the record's to read | [src/did-utils.ts](src/did-utils.ts) |
| Media types | Which types a knowledge base admits, and what can be done with each | [src/media-types.ts](src/media-types.ts) |
| Shared rules | Error codes, timing, retry and the cache's refresh table, the same for every SDK | `src/generated/`, [src/retry.ts](src/retry.ts) |

The main import runs in a browser. What cannot is on a subpath:

| Import | |
|---|---|
| `@xynoplex/core/openapi` | The spec's validators, compiled when the package is built, and its limits |
| `@xynoplex/core/testing` | The test doubles every layer shares |
| `@xynoplex/core/testing/axioms` | Property-based harnesses for state units and transports. They need `fast-check` |
| `@xynoplex/core/testing/issuer` | An OIDC issuer in one process, for tests that verify tokens |

## Example

```typescript
import { resourceId, isResourceId, kbDid, kbResource } from '@xynoplex/core';

// An id is made by its constructor, which throws for text its rule refuses.
const id = resourceId('5bcd259ab1464cf68a556bbad21f513f');

// A guard asks the same rule without throwing.
const typed = isResourceId('https://kb.example/resources/5bcd');   // false: a URI is not an id

// A knowledge base's did and the audience its tokens carry, from its committed domain.
const did = kbDid('xynoplex.github.io:xynoplex-caselaw-kb');        // 'did:web:xynoplex.github.io:xynoplex-caselaw-kb'
const audience = kbResource('xynoplex.github.io:xynoplex-caselaw-kb'); // 'https://xynoplex.github.io/xynoplex-caselaw-kb'
```

## What a change must keep

- **The spec is the source.** `src/types.ts`, [src/bus-protocol.ts](src/bus-protocol.ts) and everything in `src/generated/` are generated from [`protocol/specs/src`](../../../protocol/specs/src/), and never edited. Only `bus-protocol.ts` is committed; the rest is made when the package is built. Change the spec, then run `npm run generate:openapi --workspace=@xynoplex/core`. A type written by hand that restates a schema is a second copy that nothing keeps true: use the spec's type, under the spec's name.
- **The main import runs in a browser.** It uses no Node builtin. The validators and the test issuer are reachable only by their subpaths, because of the weight they would add to every bundle, and `npm run lint:core-subpaths` fails a re-export of either from the root.
- **It depends on no other Xynoplex package.** Everything else depends on it.
- **An id is made only by its constructor or its guard.** One kind is never assignable to another.
- **Its tests read every package.** Three census tests here walk the source of all of `packages/`, `apps/` and `images/`, tests included, so a change somewhere else can fail this package's suite.

## Documentation

- [API tour](docs/API.md): each area, with examples.
- [Utilities](docs/Utilities.md): the small helpers.
- [The spec](../../../protocol/specs/README.md), which this package is generated from.

## License

Apache-2.0
