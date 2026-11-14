package readme

import (
	"context"
	"fmt"

	xynoplex "github.com/Xynoplex/sdk/go"
	"github.com/Xynoplex/sdk/go/api"
)

// Watch shows a resource's annotations as they change, until ctx is done.
func Watch(ctx context.Context, client *xynoplex.Client, resource api.ResourceId) {
	for state := range client.Browse.Annotations(resource).States(ctx) { // holds the resource's scope
		switch state := state.(type) {
		case xynoplex.Pending:
			fmt.Println("asking")
		case xynoplex.Ready[[]api.Annotation]:
			fmt.Println(len(state.Value), "annotations")
		case xynoplex.Failed: // a state, not the end: the query lives on
			fmt.Println("failed:", state.Err)
		}
	}
}
