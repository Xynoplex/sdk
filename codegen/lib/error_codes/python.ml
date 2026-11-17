(* The vocabularies as the Python SDK reads them (python/sdk/src/xynolog):
   each a [Literal] union, so a [match] over one that ends in [assert_never]
   is checked to name every code, and a tuple of the same codes to iterate. *)

let path = "python/sdk/src/xynolog/error_codes.py"
let comment ?(indent = "") = Text.comment ~marker:"# " ~indent ~width:96

(* The tuple of a vocabulary's codes. *)
let codes_constant (v : Table.vocabulary) = Text.upper_snake v.name ^ "S"

let union (v : Table.vocabulary) =
  String.concat ""
    [
      comment v.docs;
      Printf.sprintf "\ntype %s = Literal[\n" v.name;
      String.concat ""
        (List.map
           (fun (c : Table.code) ->
             Printf.sprintf "%s\n    %s,\n"
               (comment ~indent:"    " c.docs)
               (Text.quoted c.code))
           v.codes);
      Printf.sprintf "]\n\n%s: Final[tuple[%s, ...]] = (\n" (codes_constant v)
        v.name;
      String.concat ""
        (List.map
           (fun (c : Table.code) ->
             Printf.sprintf "    %s,\n" (Text.quoted c.code))
           v.codes);
      ")\n";
    ]

let cases ~indent pairs =
  String.concat ""
    (List.map
       (fun (case, result) ->
         Printf.sprintf "%scase %s:\n%s    return %s\n" indent case indent
           result)
       pairs)

let text (t : Table.t) =
  let vocabularies = t.bus :: t.transport :: t.others in
  let exported =
    List.sort compare
      (List.concat_map
         (fun (v : Table.vocabulary) -> [ v.name; codes_constant v ])
         vocabularies
      @ [ "bus_request_code_for_wire_code"; "transport_error_code_for_status" ]
      )
  in
  String.concat ""
    [
      {|# Generated from protocol/specs/src/errors/codes.json; do not edit.
# Regenerate: make generate (codegen/lib/error_codes/python.ml)

"""The codes a Xynolog client reports a failure under.

Each vocabulary is a closed set: a `Literal` union, so a `match` over one that
ends in `assert_never` is checked to name every code, and a tuple of the same
codes to iterate.
"""

from typing import Final, Literal, assert_never

from xynolog.types import CommandErrorCode

__all__ = [
|};
      String.concat ""
        (List.map
           (fun name -> Printf.sprintf "    %s,\n" (Text.quoted name))
           exported);
      "]\n\n";
      union t.bus;
      Printf.sprintf
        {|

def bus_request_code_for_wire_code(code: CommandErrorCode | None) -> %s:
    """The bus code a failure's own code (`CommandError.code`) becomes.

    A failure that states none is the unrecognized failure, and so is one
    whose code the wire does not list, which is read as stating none.
    """
    match code:
|}
        t.bus.name;
      cases ~indent:"        "
        (List.map
           (fun (wire, (c : Table.code)) ->
             (Text.quoted wire, Text.quoted c.code))
           t.wire
        @ [ ("None", Text.quoted t.unrecognized.code) ]);
      "        case _:\n            assert_never(code)\n\n\n";
      union t.transport;
      Printf.sprintf
        {|

def transport_error_code_for_status(status: int) -> %s:
    """The transport code an HTTP status becomes."""
    match status:
|}
        t.transport.name;
      cases ~indent:"        "
        (List.map
           (fun (status, (c : Table.code)) ->
             (string_of_int status, Text.quoted c.code))
           t.exact);
      "        case _:\n            pass\n";
      String.concat ""
        (List.map
           (fun (status, (c : Table.code)) ->
             Printf.sprintf "    if status >= %d:\n        return %s\n" status
               (Text.quoted c.code))
           (Option.to_list t.from));
      Printf.sprintf "    return %s\n\n\n" (Text.quoted t.unclassified.code);
      String.concat "\n" (List.map union t.others);
    ]

let file t = { Output.path; text = text t }
