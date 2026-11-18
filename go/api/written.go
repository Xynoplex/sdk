package api

import (
	"encoding/json"
	"reflect"
	"strings"
)

// listOf is list, or the empty list where Go holds list as nil. Go takes both
// for the empty list; encoding/json writes the one as [] and the other as
// null, which a member its schema requires may not be.
func listOf[S ~[]E, E any](list S) S {
	if list == nil {
		return S{}
	}
	return list
}

// writeOpen writes known, an object's members its schema names, with rest,
// the members it does not.
func writeOpen(known any, rest map[string]any) ([]byte, error) {
	raw, err := json.Marshal(known)
	if err != nil || len(rest) == 0 {
		return raw, err
	}
	var object map[string]json.RawMessage
	if err := json.Unmarshal(raw, &object); err != nil {
		return nil, err
	}
	for name, value := range rest {
		if object[name], err = json.Marshal(value); err != nil {
			return nil, err
		}
	}
	return json.Marshal(object)
}

// readOpen reads raw into known, a pointer to a struct of the members its
// schema names, and the members it does not into rest, which is nil where
// there are none.
func readOpen(raw []byte, known any, rest *map[string]any) error {
	if err := json.Unmarshal(raw, known); err != nil {
		return err
	}
	var object map[string]json.RawMessage
	if err := json.Unmarshal(raw, &object); err != nil {
		return err
	}
	for name := range named(reflect.TypeOf(known).Elem()) {
		delete(object, name)
	}
	*rest = nil
	for name, value := range object {
		var held any
		if err := json.Unmarshal(value, &held); err != nil {
			return err
		}
		if *rest == nil {
			*rest = map[string]any{}
		}
		(*rest)[name] = held
	}
	return nil
}

// named is the members a struct's fields are written as, by their json tags.
func named(t reflect.Type) map[string]bool {
	names := map[string]bool{}
	for i := range t.NumField() {
		name, _, _ := strings.Cut(t.Field(i).Tag.Get("json"), ",")
		if name != "" && name != "-" {
			names[name] = true
		}
	}
	return names
}
