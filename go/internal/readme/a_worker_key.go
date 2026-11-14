package readme

import (
	"fmt"
	"os"

	xynoplex "github.com/Xynoplex/sdk/go"
)

// WorkerCredential is a worker's account at issuer, which proves itself with
// the key the launcher handed it.
func WorkerCredential(issuer, clientID string) (xynoplex.KeyCredential, error) {
	key, err := xynoplex.ParsePrivateKeyPEM(os.Getenv("XYNOPLEX_OIDC_CLIENT_KEY"))
	if err != nil {
		return xynoplex.KeyCredential{}, fmt.Errorf("XYNOPLEX_OIDC_CLIENT_KEY: %w", err)
	}
	return xynoplex.KeyCredential{Issuer: issuer, ClientID: clientID, PrivateKey: key}, nil
}
