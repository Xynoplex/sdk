(* Whole OpenAPI documents, bundled from protocol/specs/src as their files
   write them: what a service embeds, serves and reads at run time. Every
   file a $ref names is followed. A file the root document lists under
   [components], or one in a directory named [schemas] or [responses], is a
   component, by the name the root lists or by its stem, and a reference
   names it there; any other file is written in its place. A description
   written beside a reference is kept: beside a component's reference, and
   over the description of a file written in its place.

   The files are read as JSON, not through the model, so a document keeps
   every member Protocol writes. And the component schemas as JSON Schema
   draft 7 ([definitions]). *)

exception Refused of Decode.error

let refuse file message = raise (Refused { Decode.file; pointer = ""; message })
let specs ~root = Filename.concat root "protocol/specs/src"

type st = {
  root : string;
  named : (string, string * string) Hashtbl.t;
      (** Each file that is a component, by its file: its kind and name. *)
  components : (string * string, Yojson.Safe.t) Hashtbl.t;
}

let parse st file =
  match Decode.parse_file ~root:st.root file with
  | Ok json -> json
  | Error error -> raise (Refused error)

let name st file named =
  match Hashtbl.find_opt st.named file with
  | Some (kind, n) when (kind, n) <> named ->
      refuse file
        (Printf.sprintf "is named both %s/%s and %s/%s" kind n (fst named)
           (snd named))
  | _ -> Hashtbl.replace st.named file named

(* The component a file is when the root lists none: one in a directory of
   schemas or of responses, by its stem. *)
let by_directory file =
  match Filename.basename (Filename.dirname file) with
  | ("schemas" | "responses") as kind ->
      Some (kind, Filename.remove_extension (Filename.basename file))
  | _ -> None

let rec load st file = resolve st file (parse st file)

(* [json], written in [file], with every reference resolved. *)
and resolve st file (json : Yojson.Safe.t) : Yojson.Safe.t =
  match json with
  | `List items -> `List (List.map (resolve st file) items)
  | `Assoc members -> (
      match List.assoc_opt "$ref" members with
      | Some (`String target) -> reference st file target members
      | Some _ -> refuse file "states a $ref that is no text"
      | None -> `Assoc (List.map (fun (k, v) -> (k, resolve st file v)) members)
      )
  | other -> other

and reference st file target members =
  if String.starts_with ~prefix:"#" target then
    refuse file
      (target ^ " refers within its file: protocol/specs/src refers by file");
  let target_file, pointer =
    Decode.resolve { Decode.target; file; pointer = "" }
  in
  if pointer <> "" then
    refuse file
      (target ^ " points into a file: protocol/specs/src refers to whole files");
  let beside = List.remove_assoc "$ref" members in
  List.iter
    (fun (key, _) ->
      if key <> "description" then
        refuse file
          (Printf.sprintf "states %s beside its reference to %s" key target))
    beside;
  let named =
    match Hashtbl.find_opt st.named target_file with
    | Some named -> Some named
    | None -> by_directory target_file
  in
  match named with
  | Some ((kind, n) as named) ->
      if not (Hashtbl.mem st.named target_file) then (
        name st target_file named;
        Hashtbl.replace st.components named (load st target_file));
      `Assoc (("$ref", `String ("#/components/" ^ kind ^ "/" ^ n)) :: beside)
  | None -> (
      match (load st target_file, beside) with
      | written, [] -> written
      | `Assoc written, [ said ] ->
          `Assoc (said :: List.remove_assoc "description" written)
      | _ -> refuse target_file "is no object, and a description is beside it")

let object_ file what = function
  | `Assoc members -> members
  | _ -> refuse file (what ^ " is no object")

(* The document whose root is [file] under protocol/specs/src of [root]. *)
let document ~root file =
  let st =
    {
      root = specs ~root;
      named = Hashtbl.create 64;
      components = Hashtbl.create 512;
    }
  in
  let members = object_ file "the document" (parse st file) in
  let declared =
    match List.assoc_opt "components" members with
    | Some kinds ->
        List.map
          (fun (kind, entries) ->
            (kind, object_ file ("components/" ^ kind) entries))
          (object_ file "components" kinds)
    | None -> []
  in
  (* A component the root lists by its file, as its file. *)
  let listed = function
    | `Assoc [ ("$ref", `String target) ] ->
        Some (fst (Decode.resolve { Decode.target; file; pointer = "" }))
    | _ -> None
  in
  let each f =
    List.iter
      (fun (kind, entries) ->
        List.iter (fun (n, entry) -> f kind n entry) entries)
      declared
  in
  each (fun kind n entry ->
      Option.iter (fun target -> name st target (kind, n)) (listed entry));
  each (fun kind n entry ->
      Hashtbl.replace st.components (kind, n)
        (match listed entry with
        | Some target -> load st target
        | None -> resolve st file entry));
  let rest =
    List.filter_map
      (fun (key, value) ->
        if key = "components" then None else Some (key, resolve st file value))
      members
  in
  let entries =
    List.sort compare
      (Hashtbl.fold
         (fun (kind, n) json all -> (kind, n, json) :: all)
         st.components [])
  in
  let kinds =
    List.sort_uniq String.compare (List.map (fun (k, _, _) -> k) entries)
  in
  `Assoc
    (rest
    @ [
        ( "components",
          `Assoc
            (List.map
               (fun kind ->
                 ( kind,
                   `Assoc
                     (List.filter_map
                        (fun (k, n, json) ->
                          if k = kind then Some (n, json) else None)
                        entries) ))
               kinds) );
      ])

(* A document's component schemas as JSON Schema draft 7, under
   [definitions], where a reference names its schema. The forms Protocol
   writes in 2020-12 mean the same in draft 7: null is a second [type], an
   [anyOf] or a [oneOf] member, and nothing but an annotation stands beside a
   [$ref]. *)
let definitions file (document : Yojson.Safe.t) : Yojson.Safe.t =
  let prefix = "#/components/schemas/" in
  let rec convert (json : Yojson.Safe.t) : Yojson.Safe.t =
    match json with
    | `List items -> `List (List.map convert items)
    | `Assoc members ->
        let members =
          List.map
            (function
              | "$ref", `String r when String.starts_with ~prefix r ->
                  ( "$ref",
                    `String
                      ("#/definitions/"
                      ^ String.sub r (String.length prefix)
                          (String.length r - String.length prefix)) )
              | member -> member)
            members
        in
        `Assoc (List.map (fun (k, v) -> (k, convert v)) members)
    | other -> other
  in
  let components =
    object_ file "components"
      (Option.value ~default:(`Assoc [])
         (List.assoc_opt "components" (object_ file "the document" document)))
  in
  match List.assoc_opt "schemas" components with
  | None -> refuse file "states no component schema"
  | Some schemas ->
      `Assoc
        [
          ("$schema", `String "http://json-schema.org/draft-07/schema#");
          ("definitions", convert schemas);
        ]

(* JSON as a reader reviews it: two spaces a level, a member a line, and an
   empty object or list on one. *)
let text (json : Yojson.Safe.t) =
  let b = Buffer.create 65536 in
  let indent d = Buffer.add_string b (String.make (2 * d) ' ') in
  let rec value depth (json : Yojson.Safe.t) =
    let each items f =
      List.iteri
        (fun i item ->
          if i > 0 then Buffer.add_string b ",\n";
          indent (depth + 1);
          f item)
        items;
      Buffer.add_char b '\n';
      indent depth
    in
    match json with
    | `Assoc [] -> Buffer.add_string b "{}"
    | `List [] -> Buffer.add_string b "[]"
    | `Assoc members ->
        Buffer.add_string b "{\n";
        each members (fun (k, v) ->
            Buffer.add_string b (Yojson.Safe.to_string (`String k));
            Buffer.add_string b ": ";
            value (depth + 1) v);
        Buffer.add_char b '}'
    | `List items ->
        Buffer.add_string b "[\n";
        each items (value (depth + 1));
        Buffer.add_char b ']'
    | scalar -> Buffer.add_string b (Yojson.Safe.to_string scalar)
  in
  value 0 json;
  Buffer.add_char b '\n';
  Buffer.contents b
