(* The kinds of id (protocol/specs/src/identifiers/kinds.json), each with its
   schema under components/schemas: a kind is named PascalCase ending in Id,
   and its schema is a string with a description and a pattern anchored at
   both ends, since Python asks the rule of the whole text and drops the
   anchors. Whether the pattern is a regular expression each SDK's own engine
   decides, when its build compiles it. *)

type kind = {
  name : string;
  description : string;
  pattern : string;
  whole : string;  (** The pattern without its anchors. *)
}

let file = "identifiers/kinds.json"

let is_name name =
  let n = String.length name in
  n > 2
  && (match name.[0] with 'A' .. 'Z' -> true | _ -> false)
  && String.ends_with ~suffix:"Id" name
  && String.for_all
       (function 'A' .. 'Z' | 'a' .. 'z' -> true | _ -> false)
       name

let anchored pattern =
  let n = String.length pattern in
  n >= 2
  && pattern.[0] = '^'
  && pattern.[n - 1] = '$'
  && not (n >= 3 && pattern.[n - 2] = '\\')

let derive (spec : Spec.t) =
  let table = spec.tables.identifiers_kinds in
  let kind i (k : Tables.Identifiers_kinds.kind) =
    let refuse message =
      Error
        {
          Decode.file;
          pointer = Printf.sprintf "/kinds/%d/schema" i;
          message = Printf.sprintf "is %s, %s" k.schema message;
        }
    in
    let schema_file = "components/schemas/" ^ k.schema ^ ".json" in
    if not (is_name k.schema) then
      refuse "which is not a kind's name: PascalCase, ending in Id"
    else
      match List.assoc_opt schema_file spec.schemas with
      | Some
          (Schema
             {
               type_ = Some [ String ];
               description = Some description;
               pattern = Some pattern;
               _;
             }) ->
          if anchored pattern then
            Ok
              {
                name = k.schema;
                description;
                pattern;
                whole = String.sub pattern 1 (String.length pattern - 2);
              }
          else
            refuse
              "whose pattern is not anchored at both ends (^…$), so Python \
               cannot ask it of the whole text"
      | Some _ ->
          refuse "whose schema is not a string with a description and a pattern"
      | None -> refuse ("and Protocol has no " ^ schema_file)
  in
  match table.kinds with
  | [] ->
      Error [ { Decode.file; pointer = "/kinds"; message = "lists no kinds" } ]
  | kinds -> Required.collect (List.mapi kind kinds)
