package readme

import (
	"bytes"
	"context"
	"fmt"

	xynoplex "github.com/Xynoplex/sdk/go"
	"github.com/Xynoplex/sdk/go/api"
)

// Store uploads a page, reads it back, and asks the gateway who is signed in
// and whether it is serving. Over HTTP, content is
// xynoplex.NewHTTPContentTransport(transport), and gateway is the transport.
func Store(ctx context.Context, content xynoplex.ContentTransport, gateway xynoplex.GatewayOperations, page []byte) (api.ResourceId, error) {
	upload := content.PutBinary(ctx, xynoplex.PutBinaryRequest{
		Name: "A page", Bytes: page, Format: "text/markdown", StorageURI: "file://pages/a.md", EntityTypes: []string{"Note"},
	})
	for progress := range upload.Progress() {
		fmt.Println(progress.BytesUploaded, "of", progress.TotalBytes)
	}
	created, err := upload.Wait(ctx)
	if err != nil {
		return api.ResourceId{}, err
	}

	stored, err := content.GetBinary(ctx, created.ResourceId)
	if err != nil {
		return api.ResourceId{}, err
	}
	if !bytes.Equal(stored.Bytes, page) || stored.ContentType != "text/markdown" {
		return api.ResourceId{}, fmt.Errorf("read back %d bytes of %s", len(stored.Bytes), stored.ContentType)
	}

	me, err := gateway.GetCurrentUser(ctx)
	if err != nil {
		return api.ResourceId{}, err
	}
	health, _, err := gateway.HealthCheck(ctx)
	if err != nil {
		return api.ResourceId{}, err
	}
	fmt.Println(me.Did, health.Status)
	return created.ResourceId, nil
}
