(* The archivist-waits group: how long a Python service waits for the
   Archivist, its document's x-xynolog-limits (protocol/specs/src/archivist/
   openapi.json), for shared/python/service's client of it. *)

module P = Python_syntax

let path = "shared/python/service/src/xynolog_service/_archivist_waits.py"

(* Each wait, by its limit's name, and what it is: the limit is named after
   the first clause. *)
let waits =
  [
    ( "CONNECT_SECONDS",
      "connectSeconds",
      "How long the Archivist is given to take a connection",
      "." );
    ( "READ_SECONDS",
      "readSeconds",
      "How long the Archivist is given for each part of an answer",
      ": for the answer to begin once its request is sent whole, and for each \
       next part. No bound is put on a whole answer." );
  ]

let derive ~root ~ids =
  let file = Bundles.archivist in
  let limits =
    match Bundle.document ~specs:(Documents.specs ~root) ~ids file with
    | Error error -> raise (Documents.Refused error)
    | Ok (`Assoc members) -> (
        match List.assoc_opt "x-xynolog-limits" members with
        | Some (`Assoc limits) -> limits
        | _ -> Documents.refuse file "states no x-xynolog-limits")
    | Ok _ -> Documents.refuse file "is no object"
  in
  let seconds name =
    match List.assoc_opt name limits with
    | Some (`Int n) when n > 0 -> n
    | _ ->
        Documents.refuse file
          ("states no x-xynolog-limits." ^ name ^ " of whole seconds")
  in
  {
    Output.path;
    text =
      P.text
        {
          header =
            [
              "Generated from protocol/specs/src/" ^ file ^ "; do not edit.";
              "Regenerate: make generate (xynolog/sdk's "
              ^ Banner.writer __FILE__ ^ ")";
              Banner.python_exempt;
            ];
          doc =
            As_is
              "How long a caller waits for the Archivist: its document's \
               `x-xynolog-limits`.";
          imports = [ [ P.From ("typing", [ "Final" ]) ] ];
          body =
            P.assign "__all__"
              ~value:
                (P.List
                   (P.items
                      (List.map (fun (n, _, _, _) -> P.item (P.Str n)) waits)))
            :: List.map
                 (fun (constant, limit, lead, rest) ->
                   P.assign
                     ~about:[ Prose (lead ^ " (`" ^ limit ^ "`)" ^ rest) ]
                     ~annotation:(P.Name "Final")
                     ~value:(P.Int (seconds limit))
                     constant)
                 waits;
        };
  }

let files ~root (spec : Spec.t) =
  match derive ~root ~ids:spec.ids with
  | file -> Ok [ file ]
  | exception Documents.Refused error -> Error [ error ]
