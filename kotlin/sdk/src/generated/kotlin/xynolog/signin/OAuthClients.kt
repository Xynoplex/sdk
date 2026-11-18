// Generated from protocol/specs/src/session/oauth.json; do not edit.
// Regenerate: make generate (codegen/lib/oauth_clients/kotlin.ml)

package xynolog.signin

import xynolog.Generated

/**
 * An application a person uses: the authorization-code grant with PKCE (RFC 7636), at a redirect address the registration lists.
 */
@Generated
public const val BROWSER_CLIENT_ID: String = "xynolog-browser"

/**
 * A process with no browser of its own, and the launcher: the device authorization grant (RFC 8628).
 */
@Generated
public const val SCRIPT_CLIENT_ID: String = "xynolog-cli"

/**
 * What every sign-in asks for. `offline_access` asks for a refresh token that outlives the issuer's own browser session: a session with a knowledge base is renewed for weeks, not minutes.
 */
@Generated
public const val SIGN_IN_SCOPE: String = "openid email profile offline_access"
