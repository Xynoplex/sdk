(* The telemetry group: every span and metric an SDK's transports export
   (protocol/specs/src/sdk-telemetry/telemetry.json), its kind or instrument,
   what it means, and its attributes, for the Go and Python SDKs.

   A span's kind is one of OTLP's, a metric's instrument a counter, and a
   span's name holds no placeholder but {channel}. A row says what it means
   and lists each attribute once; those not marked `only` are the ones every
   one carries. No two rows, nor two attribute keys, are the same Go or Python
   name. *)

module T = Tables.Sdk_telemetry_telemetry

let file = "sdk-telemetry/telemetry.json"
let channel = "{channel}"

type row = {
  name : string;
  kind : string;  (** A span's kind, or a metric's instrument. *)
  meaning : string;
  all : string list;
  always : string list;
}

type t = { spans : row list; metrics : row list }

let span_kinds = [ "internal"; "server"; "client"; "producer"; "consumer" ]
let instruments = [ "counter" ]
let without_channel = Text.replace_all ~sub:(":" ^ channel) ~by:""

(* A dotted, underscored name as a Go identifier behind [prefix]:
   content.size_bytes is keyContentSizeBytes. *)
let go_identifier prefix name =
  prefix
  ^ String.concat ""
      (List.map
         (fun word ->
           if word = "id" then "ID" else String.capitalize_ascii word)
         (String.split_on_char '_'
            (String.map (function '.' -> '_' | c -> c) (without_channel name))))

(* A row's Python constant: its name, without what stands for the channel, in
   upper snake case, each run of what is not a letter or digit an
   underscore. *)
let python_constant name =
  let out = Buffer.create 32 in
  String.iter
    (fun c ->
      match c with
      | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' -> Buffer.add_char out c
      | _ ->
          if
            Buffer.length out = 0
            || Buffer.nth out (Buffer.length out - 1) <> '_'
          then Buffer.add_char out '_')
    (Text.upper_snake (without_channel name));
  Buffer.contents out

let derive (table : T.t) =
  let refusals = ref [] in
  let refuse pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  let row at ~name ~kind_member ~kind ~kinds ~meaning keys =
    if name = "" then refuse (at ^ "/name") "is empty";
    if meaning = "" then refuse (at ^ "/meaning") "is empty";
    if not (List.mem kind kinds) then
      refuse
        (at ^ "/" ^ kind_member)
        (Printf.sprintf "is %S, which is none of %s" kind
           (String.concat ", " kinds));
    List.iteri
      (fun i (key, _) ->
        if key = "" then
          refuse (Printf.sprintf "%s/attributes/%d/key" at i) "is empty"
        else
          match List.find_index (fun (k, _) -> k = key) keys with
          | Some j when j < i ->
              refuse
                (Printf.sprintf "%s/attributes/%d/key" at i)
                (Printf.sprintf "is %s, which /attributes/%d states already" key
                   j)
          | _ -> ())
      keys;
    {
      name;
      kind;
      meaning;
      all = List.map fst keys;
      always =
        List.filter_map (fun (k, only) -> if only then None else Some k) keys;
    }
  in
  let spans =
    List.mapi
      (fun i (s : T.span) ->
        let at = Printf.sprintf "/spans/%d" i in
        if String.contains (without_channel s.name) '{' then
          refuse (at ^ "/name")
            (Printf.sprintf "is %s, which has a placeholder but %s" s.name
               channel);
        row at ~name:s.name ~kind_member:"kind" ~kind:s.kind ~kinds:span_kinds
          ~meaning:s.meaning
          (List.map
             (fun (a : T.attribute) -> (a.key, Option.is_some a.only))
             s.attributes))
      table.spans
  in
  let metrics =
    List.mapi
      (fun i (m : T.metric) ->
        row
          (Printf.sprintf "/metrics/%d" i)
          ~name:m.name ~kind_member:"instrument" ~kind:m.instrument
          ~kinds:instruments ~meaning:m.meaning
          (List.map
             (fun (a : T.metric_attribute) -> (a.key, Option.is_some a.only))
             m.attributes))
      table.metrics
  in
  let distinct what names =
    let rec go seen = function
      | [] -> ()
      | n :: rest ->
          if List.mem n seen then
            refuse ""
              (Printf.sprintf "two of its names would be the %s %s" what n);
          go (n :: seen) rest
    in
    go [] names
  in
  let keys =
    List.sort_uniq compare (List.concat_map (fun r -> r.all) (spans @ metrics))
  in
  distinct "Go identifier"
    (List.map (fun r -> go_identifier "span" r.name) spans
    @ List.map (fun r -> go_identifier "metric" r.name) metrics
    @ List.map (go_identifier "key") keys);
  distinct "Python constant"
    (List.map (fun r -> python_constant r.name) (spans @ metrics));
  match List.rev !refusals with
  | [] -> Ok { spans; metrics }
  | errors -> Error errors

let quoted = Text.quoted

let go (t : t) =
  let span_kind = function
    | "internal" -> "trace.SpanKindInternal"
    | "server" -> "trace.SpanKindServer"
    | "client" -> "trace.SpanKindClient"
    | "producer" -> "trace.SpanKindProducer"
    | _ -> "trace.SpanKindConsumer"
  in
  let keys =
    List.sort_uniq compare
      (List.concat_map (fun r -> r.all) (t.spans @ t.metrics))
  in
  {
    Output.path = "go/telemetry_gen.go";
    text =
      String.concat ""
        [
          {|// Code generated from protocol/specs/src/sdk-telemetry/telemetry.json — DO NOT EDIT.
//
// Regenerate: make generate (|};
          Banner.writer __FILE__;
          {|)
// The Python table is generated from the same table.

package xynolog

import (
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/trace"
)

// telemetryChannel stands for the bus channel in a span's name.
const telemetryChannel = |};
          quoted channel;
          {|

// telemetrySpan is a span the SDK's transports export: its name, in which
// telemetryChannel stands for the bus channel, and its kind.
type telemetrySpan struct {
	name string
	kind trace.SpanKind
}

// telemetryMetric is a metric the SDK's transports export: its name, and
// what it means, which is its description.
type telemetryMetric struct {
	name    string
	meaning string
}

|};
          String.concat "\n"
            (List.map
               (fun r ->
                 Text.go_comment ~indent:"" r.meaning
                 ^ "\nvar "
                 ^ go_identifier "span" r.name
                 ^ " = telemetrySpan{name: " ^ quoted r.name ^ ", kind: "
                 ^ span_kind r.kind ^ "}\n")
               t.spans);
          "\n";
          String.concat "\n"
            (List.map
               (fun r ->
                 Text.go_comment ~indent:"" (r.meaning ^ " A " ^ r.kind ^ ".")
                 ^ "\nvar "
                 ^ go_identifier "metric" r.name
                 ^ " = telemetryMetric{name: " ^ quoted r.name ^ ", meaning: "
                 ^ quoted r.meaning ^ "}\n")
               t.metrics);
          "\n// The attributes the rows carry.\n\n";
          String.concat "\n"
            (List.map
               (fun k ->
                 "const " ^ go_identifier "key" k ^ " attribute.Key = "
                 ^ quoted k)
               keys);
          "\n";
        ];
  }

let python (t : t) =
  let module L = Python_layout in
  let tuple = function
    | [ one ] -> "(" ^ quoted one ^ ",)"
    | keys -> "(" ^ String.concat ", " (List.map quoted keys) ^ ")"
  in
  let literal values =
    "Literal["
    ^ String.concat ", " (List.map quoted (List.sort_uniq compare values))
    ^ "]"
  in
  let constant r = python_constant r.name in
  let row type_ field r =
    Text.python_comment ~indent:"" r.meaning
    ^ "\n" ^ constant r ^ ": Final = " ^ type_ ^ "(\n    name=" ^ quoted r.name
    ^ ",\n    " ^ field ^ "=" ^ quoted r.kind ^ ",\n    attributes="
    ^ tuple r.all ^ ",\n    always=" ^ tuple r.always ^ ",\n)\n"
  in
  let constants rows = L.Rows (List.map (fun r -> L.Atom (constant r)) rows) in
  {
    Output.path = "python/sdk/src/xynolog/telemetry_table.py";
    text =
      String.concat ""
        [
          Banner.python ~from_:"protocol/specs/src/sdk-telemetry/telemetry.json"
            __FILE__;
          {|
"""The telemetry a Xynolog SDK's transports export, when the process they run
in exports at all: every span and metric, its kind, and the attributes it
carries.

The table is every SDK's: the conformance suite holds each to it from outside.
A span's name may hold `{channel}`, which stands for the bus channel.
"""

from dataclasses import dataclass
from typing import Final, Literal, final

__all__ = [
|};
          String.concat ""
            (List.map
               (fun n -> "    " ^ quoted n ^ ",\n")
               (List.sort compare
                  ([
                     "METRICS";
                     "SPANS";
                     "Instrument";
                     "MetricRow";
                     "SpanKindName";
                     "SpanRow";
                   ]
                  @ List.map constant (t.spans @ t.metrics))));
          "]\n\n\
           # The kinds of span the table states, by OTLP's names for them.\n\
           type SpanKindName = ";
          literal (List.map (fun r -> r.kind) t.spans);
          "\n\n# The instruments the table states.\ntype Instrument = ";
          literal (List.map (fun r -> r.kind) t.metrics);
          {|


@final
@dataclass(frozen=True, slots=True, kw_only=True)
class SpanRow:
    """A span an SDK exports."""

    name: str
    kind: SpanKindName
    attributes: tuple[str, ...]
    """Every attribute it may carry. It carries no other."""
    always: tuple[str, ...]
    """The attributes every one of them carries."""


@final
@dataclass(frozen=True, slots=True, kw_only=True)
class MetricRow:
    """A metric an SDK exports."""

    name: str
    instrument: Instrument
    attributes: tuple[str, ...]
    """Every attribute a data point of it may carry. It carries no other."""
    always: tuple[str, ...]
    """The attributes every data point of it carries."""


|};
          String.concat "\n" (List.map (row "SpanRow" "kind") t.spans);
          "\n";
          String.concat "\n" (List.map (row "MetricRow" "instrument") t.metrics);
          "\n";
          L.statement ~indent:0 ~prefix:"SPANS: Final[tuple[SpanRow, ...]] = "
            ~suffix:"" (constants t.spans);
          "\n\n";
          L.statement ~indent:0
            ~prefix:"METRICS: Final[tuple[MetricRow, ...]] = " ~suffix:""
            (constants t.metrics);
          "\n";
        ];
  }

let files ~root:_ (spec : Spec.t) =
  Result.map
    (fun t -> [ go t; python t ])
    (derive spec.tables.sdk_telemetry_telemetry)
