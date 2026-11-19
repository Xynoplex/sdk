package annotations_test

// Finding the words a model quoted, held to
// protocol/specs/src/annotations/reconcile-cases.json: the table every SDK's Reconcile
// runs.

import (
	"encoding/json"
	"reflect"
	"testing"

	"github.com/xynolog/sdk/go/annotations"
	"github.com/xynolog/sdk/go/api"
)

// Reconcile finds what the table says, and a span it finds is the text's own:
// its TextSpan is the table's span less how it was found, and AnnotationOfSpan
// builds the annotation of it.
func TestReconcileFindsWhatTheTableSaysOfEveryQuote(t *testing.T) {
	var table struct {
		Cases []struct {
			Why        string          `json:"why"`
			Text       string          `json:"text"`
			Quoted     api.QuotedText  `json:"quoted"`
			Reconciled json.RawMessage `json:"reconciled"`
		} `json:"cases"`
	}
	if err := json.Unmarshal(readSpec(t, "annotations/reconcile-cases.json"), &table); err != nil {
		t.Fatal(err)
	}
	if len(table.Cases) == 0 {
		t.Fatal("the table has no case")
	}
	resource, err := api.ParseResourceId("res-1")
	if err != nil {
		t.Fatal(err)
	}
	var generator api.Agent
	if err := generator.UnmarshalJSON([]byte(`{"@type":"Software","@id":"did:web:kb.example:agents:a","name":"a"}`)); err != nil {
		t.Fatal(err)
	}
	for _, stated := range table.Cases {
		var want any
		if err := json.Unmarshal(stated.Reconciled, &want); err != nil {
			t.Fatal(err)
		}
		span, found := annotations.Reconcile(stated.Text, stated.Quoted)
		var got any
		if found {
			got = asJSON(t, span)
		}
		if !reflect.DeepEqual(got, want) {
			t.Errorf("%s: reconciled %v, and the table says %v", stated.Why, got, want)
		}
		if !found {
			continue
		}
		textSpan, err := span.TextSpan()
		if err != nil {
			t.Fatalf("%s: %v", stated.Why, err)
		}
		if spanned, ok := want.(map[string]any); ok {
			delete(spanned, "anchorMethod")
			delete(spanned, "matchQuality")
			if written := asJSON(t, textSpan); !reflect.DeepEqual(written, any(spanned)) {
				t.Errorf("%s: the span found is %v, and the table's is %v", stated.Why, written, spanned)
			}
		}
		of := annotations.OfSpan{ResourceID: resource, Motivation: api.MotivationHighlighting, Generator: generator, Span: textSpan, Text: stated.Text}
		if _, err := annotations.AnnotationOfSpan(of); err != nil {
			t.Errorf("%s: the span found is refused: %v", stated.Why, err)
		}
	}
}
