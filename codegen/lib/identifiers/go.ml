(* The kinds of id as the Go SDK's package api declares them
   (go/api/ids_gen.go): a type of its own for each, made only through the
   kind's rule.

   oapi-codegen writes the rest of package api, and would write each kind as
   an alias of string, which any text converts to. So go/oapi-codegen.yaml's
   exclude-schemas names the kinds, and this writes them instead. That list
   restates the table, so it is held to it here. *)

let path = "go/api/ids_gen.go"
let config = "go/oapi-codegen.yaml"

(* The config's exclude-schemas, read as the config writes it: one `- Name`
   per line, indented four, under the key indented two. *)
let excluded text =
  let rec after_key = function
    | [] -> None
    | "  exclude-schemas:" :: rest -> Some (names rest)
    | _ :: rest -> after_key rest
  and names = function
    | line :: rest when String.starts_with ~prefix:"    - " line ->
        String.trim (String.sub line 6 (String.length line - 6)) :: names rest
    | _ -> []
  in
  after_key (String.split_on_char '\n' text)

let held ~root (kinds : Table.kind list) =
  let refuse message =
    Error [ { Decode.file = config; pointer = ""; message } ]
  in
  let text =
    In_channel.with_open_bin (Filename.concat root config) In_channel.input_all
  in
  let named = List.map (fun (k : Table.kind) -> k.name) kinds in
  match excluded text with
  | None | Some [] ->
      refuse
        "names no exclude-schemas under output-options, so oapi-codegen would \
         write each kind of id as a string"
  | Some excluded -> (
      let missing = List.filter (fun n -> not (List.mem n excluded)) named in
      let stray = List.filter (fun n -> not (List.mem n named)) excluded in
      match (missing, stray) with
      | [], [] -> Ok ()
      | _ :: _, _ ->
          refuse
            ("exclude-schemas leaves out " ^ String.concat ", " missing
           ^ ", a kind of id in protocol/specs/src/" ^ Table.file)
      | [], _ :: _ ->
          refuse
            ("exclude-schemas names " ^ String.concat ", " stray
           ^ ", which is no kind of id in protocol/specs/src/" ^ Table.file))

let lower name =
  String.make 1 (Char.lowercase_ascii name.[0])
  ^ String.sub name 1 (String.length name - 1)

let kind (k : Table.kind) =
  let rule = lower k.name ^ "Rule" and pattern = lower k.name ^ "Pattern" in
  let name = k.name and quoted = Text.quoted k.name in
  Text.go_comment ~indent:"" k.description
  ^ Printf.sprintf
      {|
//
// It is made only by Parse%s, which holds text to the kind's rule, and
// by decoding, which goes through the same rule. Its zero value is no id: it
// is refused wherever an id is written, and IsZero names it.
type %s struct{ text string }

const %s = %s

var %s = regexp.MustCompile(%s)

// Parse%s is text as a %s, or an *InvalidIdentifierError when the
// kind's rule refuses it.
func Parse%s(text string) (%s, error) {
	if !%s.MatchString(text) {
		return %s{}, &InvalidIdentifierError{Kind: %s, Pattern: %s, Value: text}
	}
	return %s{text: text}, nil
}

// String is the id's text.
func (id %s) String() string { return id.text }

// IsZero reports whether id is the zero value, which is no id.
func (id %s) IsZero() bool { return id.text == "" }

// MarshalText is the id's text. The zero value is refused, as the rule refuses
// empty text.
func (id %s) MarshalText() ([]byte, error) {
	if id.text == "" {
		return nil, &InvalidIdentifierError{Kind: %s, Pattern: %s, Value: ""}
	}
	return []byte(id.text), nil
}

// UnmarshalText holds decoded text to the kind's rule.
func (id *%s) UnmarshalText(text []byte) error {
	parsed, err := Parse%s(string(text))
	if err != nil {
		return err
	}
	*id = parsed
	return nil
}
|}
      name name pattern (Text.quoted k.pattern) rule pattern name name name name
      rule name quoted pattern name name name name quoted pattern name name

let text kinds =
  {|// Code generated from protocol/specs/src/identifiers/kinds.json and each kind's schema — DO NOT EDIT.
//
// Regenerate: make generate (|}
  ^ Banner.writer __FILE__
  ^ {|)
// The TypeScript and Python kinds are generated from the same table, and Rust's
// by its SDK's build script.

package api

import (
	"fmt"
	"regexp"
)

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

|}
  ^ String.concat "\n" (List.map kind kinds)

let file ~root kinds =
  Result.map (fun () -> { Output.path; text = text kinds }) (held ~root kinds)
