// Code generated from protocol/specs/src/session/oauth.json — DO NOT EDIT.
//
// Regenerate: node packages/codegen/schemas/generate-oauth-clients-go.mjs
// The TypeScript (typescript/core/src/generated/oauth-clients.ts), Rust
// (rust/sdk/build.rs) and Python (xynolog.oauth_clients) SDKs generate
// from the same file.

package xynolog

// BrowserClientID: An application a person uses: the authorization-code grant
// with PKCE (RFC 7636), at a redirect address the registration lists.
const BrowserClientID = "xynolog-browser"

// ScriptClientID: A process with no browser of its own, and the launcher: the
// device authorization grant (RFC 8628).
const ScriptClientID = "xynolog-cli"

// SignInScope: What every sign-in asks for. `offline_access` asks for a
// refresh token that outlives the issuer's own browser session: a session
// with a knowledge base is renewed for weeks, not minutes.
const SignInScope = "openid email profile offline_access"
