// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/session/oauth.json
// Regenerate:  make generate  (codegen/lib/oauth_clients/oauth_clients.ml)

/** An application a person uses: the authorization-code grant with PKCE (RFC 7636), at a redirect address the registration lists. */
export const BROWSER_CLIENT_ID = 'xynolog-browser';

/** A process with no browser of its own, and the launcher: the device authorization grant (RFC 8628). */
export const SCRIPT_CLIENT_ID = 'xynolog-cli';

/** What every sign-in asks for. `offline_access` asks for a refresh token that outlives the issuer's own browser session: a session with a knowledge base is renewed for weeks, not minutes. */
export const SIGN_IN_SCOPE = 'openid email profile offline_access';
