# Codegen

The generator that reads the pinned Protocol's specs and writes every SDK's
generated code. It is a Dune project on the OCaml toolchain that
[`ocaml/toolchain.json`](../ocaml/toolchain.json) pins, and
`ocaml/check-toolchain.py` holds it to the same pins as the OCaml SDK.
`node/` holds the Node generators each OCaml port replaces.

## The model

`lib/` reads every file of `protocol/specs/src` into OCaml types, and refuses
what it does not know. An unknown member, a duplicate member, a wrong type
and a missing member are each a refusal that names the file and the JSON
Pointer of the value refused; nothing is defaulted.

- `Decode`: the strict decoder every reader is written with.
- `Schema`: a JSON Schema, with only the keywords, types and formats Protocol
  uses.
- `Openapi`: the two OpenAPI documents, their path items and responses.
- `Tables`: one module per table, case table or registry, each typed to its
  leaves. Its module is a mirror of the table's instances, not read from the
  schema Protocol keeps beside the table, and the strict decoder is its
  census: a member, a case kind or a table that Protocol adds stops the run
  until the module knows it.
- `Spec`: every file accounted for, and every `$ref` resolved to a file of
  the kind its place calls for.
- `Normalize`: what an `allOf` means, its parts merged keyword by keyword
  into the one schema they describe, which every group's writers read and
  none decides itself. `Inherited` is which schema states each property it
  merges, so a writer names a type for the schema that states it.

## The groups

A group writes one subject's files, in every language it has, from the
model, and refuses a spec that breaks a rule its files rely on. `Groups.all`
lists them; each group's modules are a directory of `lib/`, with one module
per language it writes:

- `bus`: every SDK's bus vocabulary, from `bus/registry.json`.
  `Bus.Registry` holds the registry to the bus's rules and derives what the
  languages share; `Bus.Typescript`, `Bus.Go` and `Bus.Python` write
  `typescript/core/src`'s bus files, `go/bus`'s `_gen.go` files and
  `python/sdk/src/xynolog`'s `channels.py` and `operations.py`, and
  `Bus.Csharp` C#'s `BusDescriptors.g.cs`.
- `required`: what each component schema requires of a value, the table
  every SDK holds a reply to before it reads it. `Required.Shape` derives it
  and states its rules. `Required.Table` writes it as JSON for Go, and
  `Required.Typescript`, `Required.Python`, `Required.Rust`,
  `Required.Kotlin`, `Required.Csharp` and `Required.Haskell` write it for
  theirs, C#'s with each payload type the bus registry makes, Haskell's with
  each bus channel's
  payload and each HTTP operation's reply, which `Required.Event` derives
  for every reader of a channel's events. `Required.Go` holds it to the
  types the `go-types` group declares.
- `unicode-case`: the code points Unicode gives the Cased and the
  Case_Ignorable property, for the C#, Kotlin and Go SDKs, whose runtimes
  give neither. `Ucd` reads them from Unicode's own
  `DerivedCoreProperties.txt`, which [`ucd/`](ucd) holds;
  `Unicode_case.Kotlin`, `Unicode_case.Csharp` and `Unicode_case.Go` write
  Kotlin's, C#'s and Go's range tables.
- `encodings`: the Encoding Standard's labels, its single-byte encodings and
  the encodings whose labels are refused, from `text/encoding-cases.json`,
  for the readers of a resource's text whose platform lacks them.
  `Encodings.Table` holds the table to its rules: an encoding is among its
  own labels, a label names one encoding and is one a reader can match, and
  a single-byte encoding is 256 characters. `Encodings.Go` and
  `Encodings.Python` write the labels and the single-byte encodings, and
  `Encodings.Typescript` the refused encodings, which the platform's
  `TextDecoder` decodes all the same.
- `error-codes`: the codes a client reports a failure under, from
  `errors/codes.json`, for the Go, Python, TypeScript, OCaml and Haskell
  SDKs. `Error_codes.Table` holds the table to the wire's own codes
  (`CommandError.code`), each restated once, and to its statuses: one per
  code, at most one open range, and every code but the unclassified one read
  from a status. `Error_codes.Go`, `Error_codes.Python` and
  `Error_codes.Typescript` write each vocabulary, the bus code a wire code
  becomes and the transport code a status becomes. `Error_codes.Haskell`
  writes every vocabulary, the control plane's with them, and discovery's
  absent reasons as one more.
- `timing`: the durations, retry budgets and counts a client waits and
  retries by, from `client/timing.json`, for the Go, Python, TypeScript,
  OCaml and Haskell SDKs. `Timing.Table` holds each entry to the kind its name says (a name
  ending in Ms is a duration, in Retry a budget, in Count a count), states
  each once, and holds a budget's backoff at or below its ceiling.
  `Timing.Go`, `Timing.Python` and `Timing.Typescript` write each SDK's
  constants; `Timing.Haskell` writes Haskell's, and the settings
  `Xynolog.Timing.Settings` overrides.
- `cache-refresh`: what a client's live queries hold, and what each event on
  the bus, the reopening of a dropped stream and an event that cannot be read
  does to them, from `client/refresh.json`, for the Go, Python, TypeScript
  and Haskell SDKs. `Cache_refresh.Table` holds the table to the registry's
  operations, the gateway's GETs, the component each query's value names and
  each channel's events: each way to what a row names ends at the component
  its slot is, and a row a passing frame triggers only refetches what
  `reopened` refetches too. `Cache_refresh.Go`, `Cache_refresh.Python`,
  `Cache_refresh.Typescript` and `Cache_refresh.Haskell` write each SDK's
  table, Haskell's with the live conformance driver's queries.
- `identifiers`: the kinds of id, from `identifiers/kinds.json` and each
  kind's schema, for the Go, Python and TypeScript SDKs: a type of its own
  per kind, made only through the kind's pattern. `Identifiers.Table` holds
  each kind to a string schema with a pattern.
- `oauth-clients`: the client ids a client signs in as and the scope it asks
  for, from `session/oauth.json`, for the Go, Python, TypeScript, OCaml and
  Haskell SDKs. A client is named in lowercase letters, once.
- `telemetry`: every span and metric an SDK's transports export, from
  `sdk-telemetry/telemetry.json`, for the Go and Python SDKs. A span's kind
  is one of OTLP's, a metric a counter, a span's name holds no placeholder
  but `{channel}`, and no two rows or keys are one Go or Python name.
- `sign-in`: the sign-in store's entry, from `sign-in-store/SignIn.json`, and
  how its directory and files are kept to their owner, from
  `sign-in-store/owner-only.json`, for the Go, Python, TypeScript, OCaml and
  Haskell SDKs; TypeScript's and Haskell's with the names
  `sign-in-store/README.md` gives the store's files, and Haskell's native
  binding with the one byte of the lock file a Windows writer locks. `Sign_in.Flat` holds the entry to a flat schema (every property a
  described string, some of them a date-time), `Sign_in.Owner_only` each
  mode to four octal digits and each access list to one place for the owner,
  and `Sign_in.Contract` the README to one name for each.
- `media-types`: the types a knowledge base admits and what can be done with
  each, from `media-types/registry.json`, for the Go, Python, TypeScript and
  Haskell SDKs, Haskell's beside the Encoding Standard's labels. A row is a
  base media type stated once, with an extension, a label and a word of each
  vocabulary; an alias is another spelling of a row's extension; and the rows
  are the `SupportedMediaType` enum's members, no more and no fewer.
- `stored`: what a client keeps for its person, from `session/stored.json`,
  for the Python and Haskell SDKs: the store's keys and prefixes, the stored
  session (a flat schema, as `sign-in`'s entry is), an open resource, the
  last event ids, the cache document, and the queries a client keeps, which
  are the refresh table's persisted queries, by the identifier each is keyed
  by. A key is a camel-case `…Key` stated once, and no key begins with a
  prefix; a cache document is a version and its entries, each a key, a value
  and a whole-number stamp.
- `locales`: every language an SDK's interface speaks, from
  `locales/registry.json`, for the TypeScript SDK. A code is two or three
  lower-case letters stated once, with a native and an English name.
- `job-storage`: the stream, subjects, consumer and bucket jobs are kept in,
  from `jobs/storage.json`, with the `JobType` enum and the motivations
  `MarkJobParams` is told apart by, for the TypeScript SDK.
- `limits`: each gateway operation's `x-xynolog-limits` and each component
  property's `maxItems`, from `openapi.json`, for the TypeScript SDK.
- `client-types`: the shapes an SDK hands its callers that no wire message
  carries, from `client/types`, and the form a service account posts with a
  client secret, from `session/ClientSecretForm.json`, for the Haskell SDK:
  the reconciled span's and the sign-in's types as the `haskell-sdk` group
  reads them, the pending annotation's and the search state's records, the
  events a delegation and an upload report, and the secret proof. A type is
  words, an object's members (with those of each type it is all of) or a
  union told apart by one member, and a member is a scalar, a word of an
  enum, another schema, an open list or an object stated in place; anything
  else is refused. The secret proof's grant is the client assertion's.
- `testing`: the testing kit's facts, from `client/testing.json`, for the
  Haskell and OCaml SDKs: the faults, the bounds they and a schedule are
  drawn in, the slack, the delivery steps and, for Haskell, the kit's
  records, each member of the Haskell type the writer gives it. A member
  the table has and the writer types not, or the reverse, is refused.
- `ocaml-sdk`: the OCaml SDK's modules that no other group's table owns: the
  string enums, the selector and the records of the component schemas, what
  its HTTP transport says, the bus's channels and the namespace methods that
  are one channel or operation each, and the facts of tables no group writes
  for it, with the repository's `LICENSE`, which its package ships. The
  `required`, `identifiers`, `timing`, `error-codes`, `cache-refresh`,
  `encodings`, `oauth-clients`, `telemetry`, `sign-in` and `media-types`
  groups each write the OCaml SDK's module of their own table. The OCaml
  SDK's tests read Protocol's case tables where the checkout holds them, as
  every SDK's do; no group copies a table into one.
- `swift-sdk`: the Swift SDK's `Generated/Models.swift`, a model of every
  component schema and the sign-in store's entry with the tables as typed
  values, and its tests' `Generated/TestBridge.swift`, a round trip through
  each model by its schema's name. `Swift_sdk.Models` declares the schemas,
  `Swift_sdk.Table_decls` the tables, from the other groups' derivations
  where they hold the same data, and `Swift_sdk.Spec_values` the tables
  Swift holds as Protocol writes them, which the census holds to Protocol's
  own members.
- `haskell-sdk`: the Haskell SDK's modules that no other group's table owns:
  a model of every schema it reads or writes, from the gateway's components,
  the client registry's records, the stored session's, the HTTP routes'
  bodies and the bus's envelopes, each `allOf` merged into one object, a
  module per cycle of references, with `Xynolog.Types`, the schemas it
  validates against, each `allOf` in them merged, and the round trips its
  tests drive; its HTTP routes and
  what a refused credential is, from the reference transport; its
  transport's facts, from `TRANSPORT-HTTP.md`; its bus's channels and
  operations, with each operation's failure; the worker's channels and
  records, from `typescript/sdk/src/claims.ts`; the facts of tables no group
  writes for it; and its manifest, with the repository's `LICENSE`. A
  schema that states a keyword the SDK's validator does not read is refused,
  as is a model module no schema makes any more. The `error-codes`, `timing`,
  `cache-refresh`, `oauth-clients`, `sign-in`, `media-types`, `stored`,
  `client-types`, `testing`, `required` and `unicode-case` groups each write
  the Haskell SDK's module of their own table.
- `csharp-sdk`: the C# SDK's models of the component schemas, of the
  schemas it reads beside them and of the records Protocol states in its
  tables (`Table_records`), each with its converter
  (`Csharp_sdk.Models`), every schema they are made from as the SDK
  validates a value against it, the code each of the wire's failure codes
  becomes, and the tables the SDK reads as Protocol writes them. The `bus`,
  `required`, `unicode-case` and `identifiers` groups each write the C#
  SDK's file of their own table. `Csharp_syntax` is the C# they are built
  of, laid out as `dotnet format` leaves it.
- `kotlin-sdk`: the Kotlin SDK's types of the component schemas and of the
  sign-in store's entry, a file each under `xynolog/types`, and the kinds of
  id in `xynolog/identifiers` (`Kotlin_sdk.Types`), in
  `kotlin/sdk/src/generated/kotlin`; a file there that no schema writes is
  refused. The `bus`, `required`, `unicode-case`, `encodings`,
  `error-codes`, `timing`, `cache-refresh`, `oauth-clients`, `telemetry`,
  `sign-in` and `media-types` groups each write the Kotlin SDK's file of
  their own table. `Kotlin_syntax` is the Kotlin they are built of, laid out
  as ktlint leaves it.
- `go-types`: the Go SDK's package `api` (`go/api/types_gen.go`), a type for
  every component schema, every record Protocol states in its tables
  (`Table_records`), and every schema they reach but the kinds of id, which
  `identifiers` writes. A union embeds the hand-written generic
  `union` (`go/api/union.go`); `Go_syntax` is the Go it is built of, laid out
  as gofmt leaves it. It reads the schemas as Rust's types do, through `View`
  (a `$ref`'s schema, a union's members) and `Definitions.meant` (an `allOf`
  as `Normalize` merges it), and names what it writes in place by `Naming`.
- `typescript-types`: the TypeScript SDK's `components['schemas']`
  (`typescript/core/src/types.ts`), each component schema as a type written
  as the schema states it, and each kind of id branded. `Typescript_syntax`
  is the TypeScript it is built of, and Prettier lays it out.
- `python-types`: the Python SDK's `xynolog/types.py`, a frozen `WireModel`
  for every component schema that is an object and a type alias for every
  other, but the kinds of id, which it imports from `xynolog.identifiers`. A
  model states types and no rules: what a value must be beyond its type is
  the `required` table's. What a schema writes in place is named by
  `Naming`, and each declaration follows every one it names, so pydantic
  builds each model as the module runs. `Python_syntax` is the Python it is
  built of.

`Text` measures and spells text: a width in code points, a word ended by
ASCII white space, a string as JSON writes it or as a Go or Python literal
of printable ASCII, a camel-case name in upper or lower snake case, and a
comment as Go, Python and TypeScript write one. `Ocaml_syntax` builds an
OCaml module as compiler-libs' Parsetree, prints it with Pprintast and lays
it out with ocamlformat-lib, so a generated module is one the SDK's
`dune build @fmt` leaves as it is. `Python_layout` lays a Python
statement out as ruff's formatter does at the SDK's line length, so a
generated module is one `ruff format` leaves as it is. `Swift_syntax` is
the Swift a writer builds, printed as swift-format 6.4.2 lays it out under
`swift/sdk/.swift-format` through `Swift_layout`, so a generated Swift file
is that formatter's fixed point. `Banner` is the line
each generated file opens with, naming the module that writes it; a
generated Python module also names the lint rules it is exempt from (a long
line, an ambiguous character, the order of its imports and of its `__all__`,
and an exemption it does not use), and every other rule holds it. `Output` is
the drift gate.

## Coverage

Protocol's tables name no consumer: which SDK runs or has what Protocol
states is sdk's to record, so renaming a test, or an SDK gaining an item of
the client surface, is a change here alone. [`test/coverage_sdk.ml`](test/coverage_sdk.ml)
names the SDKs the records speak of.

- [`test/case_coverage.ml`](test/case_coverage.ml): for each case table of
  the pinned Protocol and each SDK, the tests that run it, or why the SDK
  runs none: absent, where the SDK has no counterpart of what the table
  states, or not yet reached, where it has one and does not run the table
  yet. A test named there runs every case of its table.
- [`test/surface_coverage.ml`](test/surface_coverage.ml): each item of the
  client surface (`client/surface.json`) some SDK lacks, with each SDK that
  lacks it and why: absent, or not yet reached. An item it does not name is
  one every SDK has.

`coverage_census.exe` holds both. Its case tables are the model's tables
whose file name ends in `cases.json` (`specs/README.md`, "Case tables"), and
it names each of them and no other. Its SDKs are the Makefile's `LANGUAGES`,
and the compiler holds every table to a coverage for each one. A named test
is a file this checkout has under the SDK's directory, and it names its
table's path. Every surface item named is one the surface has, named once,
and each SDK lacking it once; that an SDK has an item named nowhere is its own
surface test's to hold. The readers `annotations/reader-cases.json` names are
the annotations module's readers that no SDK lacks.

## Running it

```sh
make test-codegen
```

builds the project, checks its formatting, runs its tests, and reads the
pinned Protocol with `xynolog-codegen read`, in the toolchain's container.
`coverage_census.exe` holds the coverage records to the pinned Protocol
and to the checkout. `boundary_census.exe` holds the imports between
generated and hand-written modules in TypeScript's core and Python's SDK to
one direction: no base module a generated one imports at run time comes back
to it, and the generated modules are those the groups write.
`protocol_paths_census.exe` holds every sdk file the pinned Protocol names,
as `sdk/<path>` or as a link into this repository, to the files this checkout
has.

```sh
make generate
make check-generated
```

run every group. `xynolog-codegen generate` writes each OCaml group's files
into the checkout, a TypeScript file as it prints it, and Prettier then lays
those out, at the version `typescript/package.json` pins. check-generated
does the same in a copy of the checkout and fails when a file the generator
names differs from the committed one.
