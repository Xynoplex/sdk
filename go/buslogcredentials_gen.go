// Code generated from protocol/specs/src/bus/log-cases.json — DO NOT EDIT.
//
// Regenerate: make generate (codegen/lib/bus/credentials.ml)

package xynolog

// credentials: The names a credential goes by: a bus log line shows
// `[withheld]` for the value of a member under any of them.
var credentials = map[string]bool{
	"token":          true,
	"cloneToken":     true,
	"accessToken":    true,
	"access_token":   true,
	"refreshToken":   true,
	"refresh_token":  true,
	"apiKey":         true,
	"api_key":        true,
	"clientSecret":   true,
	"client_secret":  true,
	"secret":         true,
	"password":       true,
	"authorization":  true,
	"Authorization":  true,
	"x-api-key":      true,
	"x-goog-api-key": true,
}
