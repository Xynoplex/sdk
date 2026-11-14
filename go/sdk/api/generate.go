// Package api is the Xynoplex API's REST client and its wire types, generated
// from the OpenAPI authority (protocol/specs/openapi.json) — the same single source of
// truth the TypeScript SDK's types derive from. Generation is FULL-SURFACE by
// deliberate choice: filtering machinery would solve a scale problem this
// spec does not have, and every operation is a complete typed HTTP call,
// not a stub. Regenerate after any spec change with `go generate ./...`
// (containerized — no host Go needed), then commit the result.
//
// The SDK's own client is the module's root package, xynoplex; this package is
// what it and the launcher send and receive.
package api

//go:generate sh -c "cd ../../../.. && container run --rm -v $(pwd):/w -w /w golang:$(go/scripts/go-toolchain.sh) go run github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@v2.6.0 -config go/sdk/oapi-codegen.yaml -o go/sdk/api/client_gen.go protocol/specs/openapi.json"
