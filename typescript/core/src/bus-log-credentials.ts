// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/bus/log-cases.json
// Regenerate:  make generate  (codegen/lib/bus/credentials.ml)

/** The names a credential goes by: a bus log line shows `[withheld]` for the value of a member under any of them. */
export const CREDENTIALS: ReadonlySet<string> = new Set([
  'token',
  'cloneToken',
  'accessToken',
  'access_token',
  'refreshToken',
  'refresh_token',
  'apiKey',
  'api_key',
  'clientSecret',
  'client_secret',
  'secret',
  'password',
  'authorization',
  'Authorization',
  'x-api-key',
  'x-goog-api-key',
]);
