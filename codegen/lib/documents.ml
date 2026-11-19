(* What sdk makes of the OpenAPI documents the reader bundles
   ([Bundle]) from protocol/specs/src: their component schemas as JSON
   Schema draft 7 ([definitions]), and JSON as a reader reviews it
   ([text]). *)

exception Refused of Decode.error

let refuse file message = raise (Refused { Decode.file; pointer = ""; message })
let specs ~root = Filename.concat root "protocol/specs/src"

let object_ file what = function
  | `Assoc members -> members
  | _ -> refuse file (what ^ " is no object")

(* The component schemas of bundles, each a document by its file, as JSON
   Schema draft 7, under [definitions], where a reference names its schema,
   as a discriminator's mapping does. A schema two bundles hold is one
   schema, the same in each. The forms Protocol writes in 2020-12 mean the
   same in draft 7: null is a second [type], an [anyOf] or a [oneOf] member,
   and nothing but an annotation stands beside a [$ref]. *)
let definitions bundles : Yojson.Safe.t =
  let prefix = "#/components/schemas/" in
  let definition = function
    | `String r when String.starts_with ~prefix r ->
        `String
          ("#/definitions/"
          ^ String.sub r (String.length prefix)
              (String.length r - String.length prefix))
    | other -> other
  in
  let rec convert (json : Yojson.Safe.t) : Yojson.Safe.t =
    match json with
    | `List items -> `List (List.map convert items)
    | `Assoc members ->
        `Assoc
          (List.map
             (function
               | "$ref", target -> ("$ref", definition target)
               | "discriminator", `Assoc discriminator ->
                   ( "discriminator",
                     `Assoc
                       (List.map
                          (function
                            | "mapping", `Assoc mapping ->
                                ( "mapping",
                                  `Assoc
                                    (List.map
                                       (fun (value, target) ->
                                         (value, definition target))
                                       mapping) )
                            | member -> member)
                          discriminator) )
               | key, value -> (key, convert value))
             members)
    | other -> other
  in
  let schemas (file, document) =
    let components =
      match
        List.assoc_opt "components" (object_ file "the bundle" document)
      with
      | Some components -> object_ file "components" components
      | None -> refuse file "states no components"
    in
    match List.assoc_opt "schemas" components with
    | Some schemas ->
        List.map
          (fun (name, schema) -> (file, name, schema))
          (object_ file "components/schemas" schemas)
    | None -> refuse file "states no component schema"
  in
  let held = Hashtbl.create 1024 in
  List.iter
    (fun (file, name, schema) ->
      match Hashtbl.find_opt held name with
      | Some (other, written) when written <> schema ->
          refuse file
            (Printf.sprintf "holds a schema %s other than %s's" name other)
      | Some _ -> ()
      | None -> Hashtbl.replace held name (file, schema))
    (List.concat_map schemas bundles);
  `Assoc
    [
      ("$schema", `String "http://json-schema.org/draft-07/schema#");
      ( "definitions",
        `Assoc
          (List.sort compare
             (Hashtbl.fold
                (fun name (_, schema) all -> (name, convert schema) :: all)
                held [])) );
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
