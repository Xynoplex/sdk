package readme

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"path/filepath"

	xynoplex "github.com/Xynoplex/sdk/go"
	"github.com/Xynoplex/sdk/go/api"
	"github.com/Xynoplex/sdk/go/bus"
)

func show(code xynoplex.DeviceCode) {
	fmt.Printf("Open %s and enter %s\n", code.VerificationURI, code.UserCode)
}

// AsMe is a session as the person signed in to kb, by `xynoplex login` or by
// the device grant here.
func AsMe(ctx context.Context, kb api.KbTarget, home string) error {
	directory, ok := xynoplex.StateDir(xynoplex.ThisSystem(), home, "", "")
	if !ok {
		return errors.New("this system keeps no sign-ins")
	}
	// The sign-in of the stack `xynoplex login` keys as the knowledge base's id.
	kept := xynoplex.NewSignInStore(filepath.Join(directory, xynoplex.SignInFile)).Entry(kb.Id)
	timing := xynoplex.DefaultTiming()
	if _, held, err := kept.Held(ctx); err != nil {
		return err
	} else if !held {
		endpoint, err := kb.Endpoint.AsHttpEndpoint()
		if err != nil {
			return err
		}
		gateway, err := xynoplex.GatewayURL(endpoint)
		if err != nil {
			return err
		}
		issuer := xynoplex.Issuer{HTTP: http.DefaultClient, Timing: timing}
		if _, err := xynoplex.SignInWithDevice(ctx, issuer, gateway, kept, show); err != nil {
			return err
		}
	}
	session, end, err := xynoplex.SessionFromKept(ctx, xynoplex.SessionFromKeptConfig{
		Kb: kb, Kept: kept, HTTP: http.DefaultClient, Timing: timing, Channels: bus.BridgedChannels,
	})
	if err != nil {
		return err
	}
	defer end() // the client, then the session, then its transport
	status, err := session.Client().System.Status(ctx)
	if err != nil {
		return err
	}
	if me := session.User().Value(); me != nil {
		fmt.Println(me.Did, status.Version)
	}
	return nil
}
