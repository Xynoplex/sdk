// Package xynolog is the Go SDK for Xynolog.
//
// The REST client and every wire type, generated from the OpenAPI authority,
// are in package api; the bus's channel vocabulary is in package bus.
//
// The launcher (apps/launcher) consumes this module via a replace directive on
// its relative path. Publishing is mechanical: drop the replace and push a
// go/vX.Y.Z tag — the import path
// github.com/xynolog/sdk/go is the permanent
// identity.
package xynolog
