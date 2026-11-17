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
  leaves. A table has no schema of its own, so its module is a mirror of its
  instances, and the strict decoder is its census: a member, a case kind or a
  table that Protocol adds stops the run until the module knows it.
- `Spec`: every file accounted for, and every `$ref` resolved to a file of
  the kind its place calls for.

## The groups

A group writes one subject's files, in every language it has, from the
model, and refuses a spec that breaks a rule its files rely on. `Groups.all`
lists them; each group's modules are a directory of `lib/`, with one module
per language it writes:

- `bus`: every SDK's bus vocabulary, from `bus/registry.json`.
  `Bus.Registry` holds the registry to the bus's rules and derives what the
  languages share; `Bus.Typescript`, `Bus.Go` and `Bus.Python` write
  `typescript/core/src`'s bus files, `go/bus`'s `_gen.go` files and
  `python/sdk/src/xynolog`'s `channels.py` and `operations.py`.

`Text` measures and spells text: a width in code points, a word ended by
ASCII white space, a string as JSON writes it. `Output` is the drift gate.

## Running it

```sh
make test-codegen
```

builds the project, checks its formatting, runs its tests, and reads the
pinned Protocol with `xynolog-codegen read`, in the toolchain's container.

```sh
make generate
make check-generated
```

run every group, the OCaml ones with `xynolog-codegen generate` and
`xynolog-codegen check`: generate writes each group's files into the
checkout, and check compares them with the committed ones and writes nothing.
