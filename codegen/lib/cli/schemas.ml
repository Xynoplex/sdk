(* What cli's groups read of Protocol's schemas: a schema by its file, a
   [$ref] resolved to the schema it names, the files a set of schemas reaches,
   and a file's text as the launcher embeds it. The launcher validates a
   document or a message against the schema's own text and only then reads
   it, so its types state a schema's shape and none of its rules. *)

exception Refused of Decode.error

let refuse file message = raise (Refused { Decode.file; pointer = ""; message })

(* A file of protocol/specs/src as the launcher names it, from its root. *)
let repository file = "protocol/specs/src/" ^ file

let schema (spec : Spec.t) file =
  match List.assoc_opt file spec.schemas with
  | Some s -> s
  | None -> refuse file "is no JSON Schema of Protocol's"

let layer file = function
  | Schema.Schema s -> s
  | Schema.Boolean_schema _ -> refuse file "is a boolean schema"

(* The schema [pointer] names within [s]: its properties' and items' only. *)
let rec within file (s : Schema.t) = function
  | [] -> s
  | "properties" :: name :: rest -> (
      match (layer file s).properties with
      | Some properties when List.mem_assoc name properties ->
          within file (List.assoc name properties) rest
      | _ -> refuse file ("has no property " ^ name))
  | "items" :: rest -> (
      match (layer file s).items with
      | Some items -> within file items rest
      | None -> refuse file "has no items")
  | step :: _ -> refuse file ("names " ^ step ^ ", which no group follows")

let steps fragment =
  match String.split_on_char '/' fragment with "" :: steps -> steps | _ -> []

(* The file and fragment [reference] names, and the schema there. *)
let resolve spec (reference : Decode.reference) =
  let file, fragment = Decode.resolve reference in
  (file, fragment, within file (schema spec file) (steps fragment))

let references : Schema.t -> Decode.reference list =
  Schema.cata
    ~boolean:(fun _ -> [])
    ~schema:(fun s -> Option.to_list s.ref_ @ List.concat (Schema.children s))

(* Every file the schemas of [files] refer to, and those, sorted. *)
let reach spec files =
  let rec visit reached file =
    if List.mem file reached then reached
    else
      List.fold_left visit (file :: reached)
        (List.map
           (fun r -> fst (Decode.resolve r))
           (references (schema spec file)))
  in
  List.sort String.compare (List.fold_left visit [] files)

(* A file's JSON, compact, as the launcher embeds it. *)
let text ~root file =
  match
    Decode.parse_file ~root:(Filename.concat root "protocol/specs/src") file
  with
  | Ok json -> Yojson.Safe.to_string json
  | Error error -> raise (Refused error)

(* A schema's description, or else the description of the schema its [$ref]
   names. *)
let describe spec (s : Schema.t) =
  match s with
  | Schema.Schema { description = Some d; _ } -> Some d
  | Schema.Schema { ref_ = Some r; _ } -> (
      match resolve spec r with
      | _, _, Schema.Schema { description; _ } -> description
      | _ -> None)
  | _ -> None

(* The keywords [s] states that [known] does not name. *)
let unknown ~known (s : Schema.schema) =
  List.filter (fun k -> not (List.mem k known)) (Schema.keywords s)

(* The Go SDK's package api, as the launcher's types name its types: every
   type it declares, the component schema each file is, and which names are
   component schemas'. *)
type api = {
  declared : string list;
  components : (string * string) list;  (** Each file's component name. *)
  defined : string -> bool;
}

let api (spec : Spec.t) =
  let names = (Definitions.bundle spec).definitions.names in
  {
    declared = List.map fst (Go_types.declared spec);
    components =
      List.map
        (fun (name, r) -> (fst (Decode.resolve r), name))
        spec.gateway.components.schemas;
    defined = (fun name -> List.mem name names);
  }

(* The Go SDK's type of the schema at [fragment] of [file]: a component
   schema's, or a property's written in place, named as the Go SDK's types
   name it. A schema the Go SDK declares no type for is refused. *)
let api_type api ~from_ file fragment =
  let name =
    match (List.assoc_opt file api.components, steps fragment) with
    | Some component, [] -> component
    | Some component, [ "properties"; property ] ->
        Naming.inline ~defined:api.defined component property
    | Some _, _ ->
        refuse from_
          (Printf.sprintf "refers to %s#%s, which no group renders" file
             fragment)
    | None, _ ->
        refuse from_
          (Printf.sprintf "refers to %s, which is no component schema" file)
  in
  if List.mem name api.declared then "api." ^ name
  else
    refuse from_
      (Printf.sprintf "refers to %s#%s, for which the Go SDK declares no type"
         file fragment)

(* A group's files, or the refusal its derivation raised. *)
let files f =
  match f () with
  | files -> Ok files
  | exception Refused error -> Error [ error ]
