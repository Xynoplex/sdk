(* The service-types group: the Rust types of the schemas only images'
   services read (packages/rust/core/src/types.rs), named by images' own
   table of them, with every schema they reach. A schema the Rust SDK
   declares is named there ([xynolog::types]), never written again: one home
   for each. *)

let table = "packages/rust/core/service-schemas.json"
let path = "packages/rust/core/src/generated/service_types.rs"
let refuse message = Documents.refuse table message

(* The table's schemas, by name. *)
let read ~root =
  match Decode.parse_file ~root table with
  | Error error -> raise (Documents.Refused error)
  | Ok json -> (
      match
        Decode.run ~file:table json
          (Decode.obj (fun o ->
               ignore (Decode.required o "$comment" Decode.non_empty_string);
               Decode.required o "schemas"
                 (Decode.non_empty_list Decode.non_empty_string)))
      with
      | Ok (names, _) -> names
      | Error error -> raise (Documents.Refused error))

let derive ~root (spec : Spec.t) =
  let roots = read ~root in
  let bundle = Definitions.bundle spec in
  List.iter
    (fun name ->
      if not (List.mem name bundle.definitions.names) then
        refuse (name ^ " is no schema a generation roots ([Roots])"))
    roots;
  (match List.sort_uniq String.compare roots with
  | unique when List.length unique <> List.length roots ->
      refuse "names a schema twice"
  | _ -> ());
  {
    Output.path;
    text =
      Rust_syntax.text
        ~header:
          [
            "Generated from the schemas in protocol/specs/src and " ^ table
            ^ "; do not edit.";
            "Regenerate: make generate (xynolog/sdk's " ^ Banner.writer __FILE__
            ^ ")";
          ]
        (Rust_types.Generate.items bundle.definitions
           {
             roots;
             identifiers = [];
             accessors = [];
             elsewhere = Rust_types.declared spec;
           });
  }

let files ~root spec =
  match derive ~root spec with
  | file -> Ok [ file ]
  | exception Documents.Refused error -> Error [ error ]
  | exception Definitions.Refused message ->
      Error [ { Decode.file = "openapi.json"; pointer = ""; message } ]
