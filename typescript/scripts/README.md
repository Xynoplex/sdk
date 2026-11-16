# TypeScript build and publish tooling

`publish.sh` stamps and stages the npm packages, then publishes them or packs them
as tarballs; its supporting modules normalize internal dependencies.
`stage-local-publish.mjs` checks the publication inputs and stages them, and
`test-local-publish.mjs` tests it. `verify-nodenext-resolution.sh` installs the
packed tarballs as an external NodeNext consumer would and type-checks them.
`make typescript` runs all of these in the Node container.

`compliance/` holds shared TypeScript architecture analysis. CSS tools and Stylelint
plugins live in `typescript/react-ui/scripts/`.

For the complete container-based local build, run `make build` from the
repository root; `make help` lists the other targets.
