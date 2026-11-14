package readme

import (
	"context"
	"errors"
	"fmt"
	"net/http"

	xynoplex "github.com/Xynoplex/sdk/go"
	"github.com/Xynoplex/sdk/go/api"
	"github.com/Xynoplex/sdk/go/bus"
)

// Read asks for a resource on the bus, then hears what is added to it.
func Read(ctx context.Context, origin, token string, resource api.ResourceId) error {
	timing := xynoplex.DefaultTiming()
	transport := xynoplex.NewHTTPTransport(xynoplex.HTTPTransportConfig{
		BaseURL: origin, Token: xynoplex.NewVariable(token), Channels: bus.BridgedChannels, HTTP: http.DefaultClient, Timing: timing,
	})
	defer transport.Close()
	wire := xynoplex.NewWire(transport)

	reply, err := xynoplex.Request(ctx, wire, bus.BrowseResourceRequested, api.BrowseResourceRequest{ResourceId: resource}, timing.BusRequestTimeout)
	var refused *xynoplex.BusRequestError
	if errors.As(err, &refused) {
		fmt.Println(refused.Code) // "bus.not-found", "bus.timeout", …: a closed vocabulary
		return nil
	}
	if err != nil {
		return err
	}
	fmt.Println(reply.Response.Resource.Name)

	// A resource's channel is read for the resource: the read holds its scope, and lets go when the loop stops or ctx is done.
	added, err := xynoplex.FramesOf(ctx, wire, bus.MarkAdded, resource)
	if err != nil {
		return err
	}
	for frame, err := range added {
		if err != nil {
			return err
		}
		fmt.Println(frame.Scope, frame.Payload.Type)
		return nil
	}
	return ctx.Err()
}
