// Generated from protocol/specs/src/bus/log-cases.json; do not edit.
// Regenerate: make generate (codegen/lib/bus/kotlin.ml)

package xynolog.bus

/** The names a credential goes by: a bus log line shows `[withheld]` for the value of a member under any of them (protocol/specs/src/bus/log-cases.json). */
internal val CREDENTIAL_NAMES: Set<String> = setOf("token", "cloneToken", "accessToken", "access_token", "refreshToken", "refresh_token", "apiKey", "api_key", "clientSecret", "client_secret", "secret", "password", "authorization", "Authorization", "x-api-key", "x-goog-api-key")
