package readme

import (
	"context"
	"fmt"

	xynolog "github.com/xynolog/sdk/go"
	"github.com/xynolog/sdk/go/api"
)

// Annotate reads a resource, has it highlighted, and directs attention to
// one of its annotations.
func Annotate(ctx context.Context, client *xynolog.Client, resource api.ResourceId, annotation api.AnnotationId) error {
	described, err := client.Browse.Resource(resource).Fresh(ctx) // a query, read once
	if err != nil {
		return err
	}
	text, err := client.Browse.ResourceContent(ctx, resource) // asked once, answered once
	if err != nil {
		return err
	}
	fmt.Println(described.Name, len(text))

	var highlighting api.MarkJobParams
	if err := highlighting.From(api.HighlightingJobParams{Motivation: api.HighlightingJobParamsMotivationHighlighting}); err != nil {
		return err
	}
	for event, err := range client.Mark.Delegate(resource, highlighting).Events(ctx) { // a job, followed
		if err != nil {
			return err
		}
		switch event := event.(type) {
		case xynolog.JobCreated:
			fmt.Println("to cancel it:", event.Data.JobId) // what client.Job.Cancel names
		case xynolog.JobProgressed:
			fmt.Println(event.Data.Percentage)
		case xynolog.JobAttemptFailed:
			fmt.Println("trying again after:", event.Data.Error)
		case xynolog.JobCompleted[api.MarkJobCompleteCommand]:
			fmt.Println(event.Data.Result)
		}
	}

	reached, counted, err := client.Beckon.Attention(ctx, resource, &annotation) // a drive: how many the gateway reached
	if err != nil {
		return err
	}
	client.Browse.Click(annotation, nil) // a signal: this viewer's own, never sent
	fmt.Println(reached, counted)
	return nil
}
