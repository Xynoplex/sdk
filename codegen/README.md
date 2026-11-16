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

## Running it

```sh
make test-codegen
```

builds the project, checks its formatting, runs its tests, and decodes the
pinned Protocol with `xynolog-codegen --check`, in the toolchain's container.
It writes no generated output yet.
