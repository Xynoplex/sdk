package api

import "fmt"

// InvalidIdentifierError is text that is not an id of the kind it was to be.
type InvalidIdentifierError struct {
	// Kind is the kind of id the text was to be, as its schema is named.
	Kind string
	// Pattern is the kind's rule, as its schema states it.
	Pattern string
	// Value is the text the rule refused.
	Value string
}

func (e *InvalidIdentifierError) Error() string {
	return fmt.Sprintf("%q is not a %s: it does not match %s", e.Value, e.Kind, e.Pattern)
}
