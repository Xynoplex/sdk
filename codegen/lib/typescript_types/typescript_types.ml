(* The TypeScript SDK's protocol types (typescript/core/src/types.ts): every
   component schema of the gateway's document as a member of
   [components['schemas']], written as the schema states it, and each kind of
   id branded, so that a property of one kind is of no other. *)

module D = Definitions
module T = Typescript_syntax

let path = "typescript/core/src/types.ts"
let unknown = T.T_name "unknown"

(* A description as a doc comment: its paragraphs, each a run of words. *)
let about description =
  match description with
  | None -> []
  | Some d ->
      let paragraphs =
        List.filter_map
          (fun p ->
            match String.trim p with "" -> None | p -> Some (Text.Words p))
          (Text.split ~sub:"\n\n" d)
      in
      [ T.Doc_prose paragraphs ]

let key name = if T.identifier name then T.Ident name else T.Quoted name

(* [t] where it is an operand of [&] or of [[]], parenthesized when it is
   itself one of [|] or [&]. *)
let operand (t : T.type_) =
  match t with T_union _ | T_intersection _ -> T.T_paren t | _ -> t

let union ts =
  let flat = List.concat_map (function T.T_union ts -> ts | t -> [ t ]) ts in
  let null = T.T_name "null" in
  match
    List.filter (fun t -> t <> null) flat @ List.filter (( = ) null) flat
  with
  | [ only ] -> only
  | ts -> T_union ts

let intersection = function
  | [ only ] -> only
  | ts -> T.T_intersection (List.map operand ts)

let literal (l : Schema.literal) : T.type_ =
  match l with
  | String_literal v -> T_str v
  | Int_literal n -> T_int n
  | Bool_literal b -> T_bool b

let rec type_of (s : D.t) : T.type_ =
  match s with
  | D.Ref name -> T.schema name
  | D.Null -> T_name "null"
  | D.Bool true -> unknown
  | D.Bool false -> T_name "never"
  | D.Node n -> (
      View.refuse_const "a component schema" s;
      match (n.all_of, View.union s, n.enum, n.type_) with
      | Some members, _, _, _ ->
          let own =
            match n.properties with
            | None | Some [] -> []
            | Some _ -> [ object_of n ]
          in
          intersection (List.map type_of members @ own)
      | None, Some members, _, _ -> union (List.map type_of members)
      | None, None, Some values, types ->
          let values = List.map literal values in
          union
            (match types with
            | Some (D.Or_null _) -> values @ [ T_name "null" ]
            | _ -> values)
      | None, None, None, Some (D.One t) -> base n t
      | None, None, None, Some (D.Or_null t) ->
          union [ base n t; T_name "null" ]
      | None, None, None, None ->
          if Option.is_some n.properties then object_of n else unknown)

and base (n : D.node) (t : Schema.type_name) : T.type_ =
  match t with
  | String -> T_name "string"
  | Integer | Number -> T_name "number"
  | Boolean -> T_name "boolean"
  | Array -> T_array (operand (Option.fold ~none:unknown ~some:type_of n.items))
  | Object -> object_of n

(* An object's properties, and what it holds beside them: an open object
   holds any member, and one whose [additionalProperties] is a schema holds
   members of it. An object that states neither holds no member. *)
and object_of (n : D.node) : T.type_ =
  let required = Option.value n.required ~default:[] in
  let members =
    List.map
      (fun (name, s) ->
        T.member (key name) (type_of s)
          ~about:(about (View.description s))
          ~optional:(not (List.mem name required)))
      (Option.value n.properties ~default:[])
  in
  let beside =
    match n.additional_properties with
    | None | Some (D.Bool false) -> []
    | Some s -> [ T.T_index_signature (type_of s) ]
  in
  match (members, beside) with
  | [], [] -> T_generic ("Record", [ T_name "string"; T_name "never" ])
  | [], [ signature ] -> signature
  | members, beside -> intersection (T_object (Rows, members) :: beside)

(* A kind of id: text, and a type of its own. *)
let branded definitions name =
  if not (View.is_string definitions (definitions.D.schema name)) then
    D.refuse "%s: a kind of id whose schema is not a string" name;
  T.T_intersection
    [
      T_name "string";
      T_object
        (Inline, [ T.member ~readonly:true (Ident "__brand") (T_str name) ]);
    ]

let text (spec : Spec.t) =
  let definitions = (Definitions.bundle spec).definitions in
  let kinds =
    List.map
      (fun (k : Tables.Identifiers_kinds.kind) -> k.schema)
      spec.tables.identifiers_kinds.kinds
  in
  let schema name =
    let s = definitions.schema name in
    T.member (key name)
      (if List.mem name kinds then branded definitions name else type_of s)
      ~about:(about (View.description s))
  in
  T.text
    {
      banner =
        Banner.typescript_lines
          ~authority:
            [
              "the component schemas of protocol/specs/src/openapi.json";
              "protocol/specs/src/identifiers/kinds.json, for the brands";
            ]
          __FILE__;
      body =
        [
          T.Interface
            {
              about = [];
              export = true;
              name = "components";
              members =
                [
                  T.member (Ident "schemas")
                    (T_object (Rows, List.map schema definitions.names));
                ];
            };
        ];
    }

let files ~root:_ (spec : Spec.t) =
  match text spec with
  | text -> Ok [ { Output.path; text } ]
  | exception Definitions.Refused message ->
      Error [ { Decode.file = "openapi.json"; pointer = ""; message } ]
