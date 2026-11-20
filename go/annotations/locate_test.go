package annotations

// Where a span of a PDF's text is on its pages, held to the `cases` of
// protocol/specs/src/annotations/pdf-locate-cases.json. The table's `claims` and
// `landing` are the first-party worker's, and no SDK's.

import (
	"encoding/json"
	"os"
	"slices"
	"testing"

	"github.com/xynolog/sdk/go/api"
)

func TestASpanIsLocatedAsTheTableSays(t *testing.T) {
	text, err := os.ReadFile("../../protocol/specs/src/annotations/pdf-locate-cases.json")
	if err != nil {
		t.Fatal(err)
	}
	var table struct {
		Cases []struct {
			Why      string           `json:"why"`
			Anchored api.AnchoredText `json:"anchored"`
			Span     struct {
				Start int `json:"start"`
				End   int `json:"end"`
			} `json:"span"`
			Overlapping []api.PdfTextItem   `json:"overlapping"`
			Rects       []api.PdfCoordinate `json:"rects"`
			Fragments   []string            `json:"fragments"`
		} `json:"cases"`
	}
	if err := json.Unmarshal(text, &table); err != nil {
		t.Fatal(err)
	}
	if len(table.Cases) == 0 {
		t.Fatal("the table has no case")
	}
	for _, stated := range table.Cases {
		overlapping, rectangles := locate(stated.Anchored, stated.Span.Start, stated.Span.End)
		if !slices.Equal(overlapping, stated.Overlapping) {
			t.Errorf("%s: the span overlaps %v, and the table says %v", stated.Why, overlapping, stated.Overlapping)
		}
		fragments := make([]string, len(rectangles))
		for i, at := range rectangles {
			fragments[i] = fragmentOf(at)
		}
		if !slices.Equal(rectangles, stated.Rects) {
			t.Errorf("%s: the rectangles are %v, and the table says %v", stated.Why, rectangles, stated.Rects)
		}
		if !slices.Equal(fragments, stated.Fragments) {
			t.Errorf("%s: the fragments are %v, and the table says %v", stated.Why, fragments, stated.Fragments)
		}
	}
}

func TestANumberIsWrittenAsTheShortestDecimalWithNoExponent(t *testing.T) {
	hairline := api.PdfCoordinate{Page: 1, X: 72, Y: 700.25, Width: 0.00005, Height: 12}
	if got := fragmentOf(hairline); got != "page=1&viewrect=72,700.25,0.00005,12" {
		t.Errorf("a hairline is written %s", got)
	}
}
