package readme

import (
	"context"
	"fmt"
	"net/http"

	xynoplex "github.com/Xynoplex/sdk/go"
)

// Work signs the agent in, and opens a stream as it.
func Work(ctx context.Context, gateway, issuer, secret string) error {
	timing := xynoplex.DefaultTiming()
	service := xynoplex.NewServiceToken(
		xynoplex.SecretCredential{Issuer: issuer, ClientID: "xynoplex-smelter", ClientSecret: secret},
		xynoplex.Issuer{HTTP: http.DefaultClient, Timing: timing},
	)
	agent, err := xynoplex.SignInAgent(ctx, xynoplex.AgentConfig{
		Gateway: gateway, Service: service, HTTP: http.DefaultClient, Timing: timing,
	})
	if err != nil {
		return err
	}
	defer agent.Close()
	transport := xynoplex.NewHTTPTransport(xynoplex.HTTPTransportConfig{
		BaseURL: gateway, Token: agent.Token(), Refresher: agent, Channels: xynoplex.JobClaimChannels,
		HTTP: http.DefaultClient, Timing: timing,
	})
	defer transport.Close()
	fmt.Println("working as", agent.DID()) // who its work is attributed to: its account, as the gateway names it
	for state := range transport.State().Changes(ctx) {
		if state == xynoplex.ConnectionStateOpen {
			fmt.Println("its stream is open, as the agent")
			return nil
		}
	}
	return ctx.Err()
}
