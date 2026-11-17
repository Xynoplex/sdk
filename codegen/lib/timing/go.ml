(* The timing as the Go SDK reads it (go/timing.go): one field of [Timing] per
   entry, and [DefaultTiming], the table's values. A duration is a
   time.Duration named without its unit ([reconnectMs] is [Reconnect]), a
   retry budget a RetryPolicy, and a count an int. *)

let path = "go/timing_gen.go"

let field (e : Table.entry) =
  let name =
    match e.value with
    | Duration _ -> String.sub e.name 0 (String.length e.name - 2)
    | Budget _ | Count _ -> e.name
  in
  String.capitalize_ascii name

let ms n = Printf.sprintf "%d * time.Millisecond" n

let text (t : Table.t) =
  let width =
    List.fold_left (fun width e -> max width (String.length (field e) + 1)) 0 t
  in
  String.concat ""
    [
      {|// Code generated from protocol/specs/src/client/timing.json; DO NOT EDIT.
//
// Regenerate: make generate (codegen/lib/timing/go.ml)
// The TypeScript and Python constants are generated from the same table, and
// Rust's by its SDK's build script.

package xynolog

import "time"

|};
      Text.go_comment ~indent:""
        "Timing is the timing a Xynolog client keeps: its deadlines, its retry \
         budgets, the cadence of its stream, and what it keeps count of, as \
         protocol/specs/src/client/timing.json states them for every SDK. It \
         holds one field per entry, under the entry's name. DefaultTiming is \
         the table's values; a caller that wants another sets that field.";
      "\ntype Timing struct {\n";
      String.concat ""
        (List.map
           (fun (e : Table.entry) ->
             Printf.sprintf "%s\n\t%s %s\n"
               (Text.go_comment ~indent:"\t"
                  (Printf.sprintf "%s is %s: %s" (field e) e.name e.docs))
               (field e)
               (match e.value with
               | Duration _ -> "time.Duration"
               | Budget _ -> "RetryPolicy"
               | Count _ -> "int"))
           t);
      "}\n\n\
       // DefaultTiming is the table's values.\n\
       func DefaultTiming() Timing {\n\
       \treturn Timing{\n";
      String.concat ""
        (List.map
           (fun (e : Table.entry) ->
             Printf.sprintf "\t\t%s%s,\n"
               (Text.pad (field e ^ ":") (width + 1))
               (match e.value with
               | Duration n -> ms n
               | Budget { attempts; initial_delay_ms; max_delay_ms } ->
                   Printf.sprintf
                     "RetryPolicy{Attempts: %d, InitialDelay: %s, MaxDelay: %s}"
                     attempts (ms initial_delay_ms) (ms max_delay_ms)
               | Count n -> string_of_int n))
           t);
      "\t}\n}\n";
    ]

let file t = { Output.path; text = text t }
