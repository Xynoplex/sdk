(* The C# SDK's models, in Xynolog.Types: a record of its properties per
   object schema, an enum per string enumeration, a closed record of a case
   per member per union, each with the converter System.Text.Json reads and
   writes it with; a schema of plain text is a string, and a kind of id is
   Xynolog.Identifiers'. What a schema states in place is a model of its own,
   named for its owner and its place. Every schema the models are made from,
   those made in place too, is what the SDK validates a value against
   (WireSchemas).

   An object's properties are its own, its allOf's and those of what it
   refers to, in order of name. One that is required is [required]; one that
   is required, not nullable and admits one string is that string, and is no
   property to set; one that is optional is nullable; and one that is
   optional and nullable is a [Stated]: absent, null or a value. An object
   that admits properties it does not name keeps them
   (AdditionalProperties). A union's value is read as the member
   [WireJson.Variant] says it is. *)

module C = Csharp_syntax

type definition = {
  schema : Schema.t;
  json : Yojson.Safe.t;  (** As Protocol writes it, for WireSchemas. *)
}

exception Refused of string

let refuse fmt = Printf.ksprintf (fun m -> raise (Refused m)) fmt
let types = "global::Xynolog.Types."
let json name = Csharp_converter.json name
let element = C.T (json "JsonElement")

let generic name args =
  C.Generic ("global::System.Collections.Generic." ^ name, args)

(* [in-process] and [subjectClaim] as [InProcess] and [SubjectClaim], each
   [+] spelled Plus; a name a digit would begin begins Value. *)
let pascal text =
  let b = Buffer.create (String.length text) in
  let start = ref true in
  String.iter
    (fun c ->
      match c with
      | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' ->
          Buffer.add_char b (if !start then Char.uppercase_ascii c else c);
          start := false
      | '+' ->
          Buffer.add_string b "Plus";
          start := true
      | _ -> start := true)
    text;
  let name = Buffer.contents b in
  if name = "" || match name.[0] with '0' .. '9' -> true | _ -> false then
    "Value" ^ name
  else name

(* The C# name of [owner]'s property [property]: no member is named as its
   type is. *)
let field_name owner property =
  let field = pascal property in
  if field = owner then field ^ "Value" else field

(* The schema a reference names, by its file's name. *)
let referenced (r : Decode.reference) =
  let file, fragment = Decode.resolve r in
  if fragment <> "" || not (Filename.check_suffix file ".json") then
    refuse "%s names a place within a file, which names no model" r.target
  else Filename.remove_extension (Filename.basename file)

let layer what = function
  | Schema.Schema s -> s
  | Boolean_schema _ -> refuse "%s is not a schema object." what

(* What a member of [json] is, as Protocol writes it. *)
let child key = function
  | `Assoc members -> (
      match List.assoc_opt key members with
      | Some v -> v
      | None -> refuse "a schema has no %s" key)
  | _ -> refuse "a schema is no object"

let nth i = function
  | `List items -> List.nth items i
  | _ -> refuse "a schema's composition is no list"

(* What the models read of a schema: every part a schema object, and a type
   one name, where the model of a schema reads a list of one type as that
   type. A schema of parts the models cannot read fails the run rather than
   making a model of less than it says. *)
let rec readable path ((schema : Schema.t), json) =
  let s = layer path schema in
  (match s.type_ with
  | Some _ when match child "type" json with `String _ -> false | _ -> true ->
      refuse "%s has an unsupported type." path
  | _ -> ());
  Option.iter
    (fun own ->
      let members = child "properties" json in
      List.iter
        (fun (name, p) -> readable (path ^ "." ^ name) (p, child name members))
        own)
    s.properties;
  Option.iter
    (fun items -> readable (path ^ "[]") (items, child "items" json))
    s.items;
  (match s.additional_properties with
  | Some (Schema _ as values) ->
      readable (path ^ ".*") (values, child "additionalProperties" json)
  | Some (Boolean_schema _) | None -> ());
  List.iter
    (fun (keyword, parts) ->
      Option.iter
        (List.iteri (fun i part ->
             readable (path ^ "." ^ keyword) (part, nth i (child keyword json))))
        parts)
    [ ("oneOf", s.one_of); ("anyOf", s.any_of); ("allOf", s.all_of) ]

(* A schema the SDK validates against states no keyword its validator does
   not read, as the Haskell SDK's states none of its: a model of one would
   accept what the schema refuses. *)
let validate path ((schema : Schema.t), json) =
  readable path (schema, json);
  match Haskell_sdk.Companions.unread schema with
  | [] -> ()
  | keyword :: _ -> refuse "%s uses unsupported schema keyword %s." path keyword

type state = {
  definitions : (string, definition) Hashtbl.t;
  mutable order : string list;  (** The definitions' names, last first. *)
  identifiers : string list;
  written : (string, C.decl list) Hashtbl.t;
  inlined : (string, string) Hashtbl.t;  (** [owner.property] → model. *)
}

let define state name definition =
  if Hashtbl.mem state.definitions name then
    refuse "%s is named twice among the schemas the models are made from" name;
  Hashtbl.replace state.definitions name definition;
  state.order <- name :: state.order

let definition state name =
  match Hashtbl.find_opt state.definitions name with
  | Some d -> d
  | None -> refuse "No component schema names %s." name

let rec plain_text state (s : Schema.schema) =
  match s.ref_ with
  | Some r ->
      let name = referenced r in
      plain_text state (layer name (definition state name).schema)
  | None -> s.type_ = Some [ String ] && s.enum = None

(* A schema's one string value, when it admits one. *)
let constant (s : Schema.schema) =
  match s.enum with Some [ String_literal c ] -> Some c | _ -> None

let nullable (s : Schema.schema) = s.nullable = Some true

type field = {
  wire : string;
  name : string;
  type_ : C.type_;
  required : bool;
  nullable : bool;
  constant : string option;
}

let rec named state name =
  if List.mem name state.identifiers then
    C.T ("global::Xynolog.Identifiers." ^ name)
  else
    let d = definition state name in
    if plain_text state (layer name d.schema) then C.T "string"
    else (
      if not (Hashtbl.mem state.written name) then (
        Hashtbl.replace state.written name [];
        Hashtbl.replace state.written name (declare state name d));
      C.T (types ^ name))

and inline state owner property (schema, json) =
  let key = owner ^ "." ^ property in
  match Hashtbl.find_opt state.inlined key with
  | Some known -> C.T (types ^ known)
  | None ->
      let rec free name =
        if Hashtbl.mem state.definitions name || Hashtbl.mem state.written name
        then free (name ^ "Value")
        else name
      in
      let name = free (owner ^ pascal property) in
      Hashtbl.replace state.inlined key name;
      let d = { schema; json } in
      define state name d;
      Hashtbl.replace state.written name [];
      Hashtbl.replace state.written name (declare state name d);
      C.T (types ^ name)

(* The type of a value of [owner]'s [property], whose schema is [schema]. *)
and type_of state owner property ((schema, json) as node) =
  let s = layer (owner ^ "." ^ property) schema in
  let inline () = inline state owner property node in
  match s with
  | { ref_ = Some r; _ } -> named state (referenced r)
  | { all_of = Some [ part ]; _ } ->
      type_of state owner property (part, nth 0 (child "allOf" json))
  | { all_of = Some _; _ } | { one_of = Some _; _ } | { any_of = Some _; _ } ->
      inline ()
  | { type_ = Some [ String ]; format = Some Binary; _ } -> C.Array (T "byte")
  | { type_ = Some [ String ]; enum = Some _; _ } -> inline ()
  | { type_ = Some [ String ]; _ } -> T "string"
  | { type_ = Some [ Integer ]; _ } -> T "long"
  | { type_ = Some [ Number ]; _ } -> T "double"
  | { type_ = Some [ Boolean ]; _ } -> T "bool"
  | { type_ = Some [ Array ]; items = Some items; _ } ->
      generic "IReadOnlyList"
        [ type_of state owner (property ^ "Item") (items, child "items" json) ]
  | { type_ = Some [ Object ]; properties = Some (_ :: _); _ }
  | { type_ = Some [ Object ]; max_properties = Some 0; _ }
  | {
      type_ = Some [ Object ];
      additional_properties = Some (Boolean_schema false);
      _;
    } ->
      inline ()
  | {
   type_ = Some [ Object ];
   additional_properties = Some (Schema _ as values);
   _;
  } ->
      generic "IReadOnlyDictionary"
        [
          T "string";
          type_of state owner (property ^ "Value")
            (values, child "additionalProperties" json);
        ]
  | { type_ = Some [ Object ]; _ } -> element
  | { type_ = None; _ } when Schema.keywords s = [] -> element
  | _ -> refuse "%s.%s has an unsupported type shape." owner property

(* A model as the record, union or enumeration it is, named to the
   hand-written converter that reads and writes it. *)
and declare state name d =
  let read_as attribute : C.attribute =
    { name = "global::Xynolog.Serialization." ^ attribute; args = [] }
  in
  match layer name d.schema with
  | { enum = Some values; _ } ->
      enum name ~attribute:(read_as "WireEnum") values
  | { one_of = Some members; _ } ->
      union state name (members, child "oneOf" d.json)
  | { any_of = Some members; _ } ->
      union state name (members, child "anyOf" d.json)
  | _ -> object_ state name ~attribute:(read_as "WireObject") d

and enum name ~attribute values =
  let members =
    List.map
      (function
        | Schema.String_literal v -> v
        | Int_literal _ | Bool_literal _ ->
            refuse "%s: an enumeration contains a non-string." name)
      values
  in
  let constants = List.map pascal members in
  if
    List.length (List.sort_uniq String.compare constants) <> List.length members
  then refuse "%s has colliding C# enumeration names." name;
  [
    C.Enum
      {
        attributes = [ attribute ];
        modifiers = [ Public ];
        name;
        members =
          List.map
            (fun member ->
              ( [
                  {
                    C.name = json "Serialization.JsonStringEnumMemberName";
                    args = [ Str member ];
                  };
                ],
                pascal member ))
            members;
      };
  ]

(* An object's properties, its requirements and whether it is open, gathered
   from it, its allOf's parts and what it refers to. *)
and collect state (schema, json) (properties, required, open_) =
  let s = layer "an object's part" schema in
  match s.ref_ with
  | Some r ->
      let name = referenced r in
      let d = definition state name in
      collect state (d.schema, d.json) (properties, required, open_)
  | None ->
      let gathered =
        match s.all_of with
        | Some parts ->
            List.fold_left
              (fun acc (i, part) ->
                collect state (part, nth i (child "allOf" json)) acc)
              (properties, required, open_)
              (List.mapi (fun i p -> (i, p)) parts)
        | None -> (properties, required, open_)
      in
      let properties, required, open_ = gathered in
      let properties =
        match s.properties with
        | Some own ->
            let members = child "properties" json in
            List.fold_left
              (fun acc (key, p) ->
                (key, (p, child key members)) :: List.remove_assoc key acc)
              properties own
        | None -> properties
      in
      let required =
        match s.required with
        | Some names ->
            List.fold_left
              (fun acc n -> if List.mem n acc then acc else acc @ [ n ])
              required names
        | None -> required
      in
      ( properties,
        required,
        open_ || s.additional_properties = Some (Boolean_schema true) )

and object_ state name ~attribute d =
  let properties, required, open_ =
    collect state (d.schema, d.json) ([], [], false)
  in
  let s = layer name d.schema in
  if s.type_ <> Some [ Object ] && s.all_of = None then
    refuse "%s is not an object schema." name;
  let owner =
    Inherited.of_schemas
      ~find:(fun n -> (definition state n).schema)
      ~referenced name d.schema
  in
  let fields =
    List.map
      (fun (wire, ((schema, _) as node)) ->
        let field = field_name name wire in
        let p = layer (name ^ "." ^ wire) schema in
        let required = List.mem wire required in
        let nullable = nullable p in
        let constant = if required && not nullable then constant p else None in
        let type_ =
          match constant with
          | Some _ -> C.T "string"
          | None -> type_of state (owner wire) field node
        in
        { wire; name = field; type_; required; nullable; constant })
      (List.sort (fun (a, _) (b, _) -> String.compare a b) properties)
  in
  let names = List.map (fun f -> f.name) fields in
  if
    List.length (List.sort_uniq String.compare names) <> List.length names
    || (open_ && List.mem "AdditionalProperties" names)
  then refuse "%s has colliding C# property names." name;
  let stated t = C.Generic (types ^ "Stated", [ Nullable t ]) in
  let extra = generic "IReadOnlyDictionary" [ T "string"; element ] in
  let wire_name f : C.attribute =
    { name = "global::Xynolog.Serialization.Wire"; args = [ Str f.wire ] }
  in
  let members =
    List.map
      (fun f ->
        match f.constant with
        | Some c ->
            C.Expression_property
              {
                attributes = [ wire_name f ];
                modifiers = [ Public ];
                type_ = T "string";
                name = f.name;
                value = Str c;
              }
        | None ->
            C.Property
              {
                attributes = [ wire_name f ];
                modifiers =
                  (if f.required then [ Public; Required ] else [ Public ]);
                type_ =
                  (if (not f.required) && f.nullable then stated f.type_
                   else if (not f.required) || f.nullable then Nullable f.type_
                   else f.type_);
                name = f.name;
                accessors = [ Get; Init ];
                value = None;
              })
      fields
    @
    if open_ then
      [
        C.Property
          {
            attributes =
              [ { name = "global::Xynolog.Serialization.WireRest"; args = [] } ];
            modifiers = [ Public ];
            type_ = extra;
            name = "AdditionalProperties";
            accessors = [ Get; Init ];
            value =
              Some
                (New
                   {
                     type_ = Some (generic "Dictionary" [ T "string"; element ]);
                     args = Some [];
                     init = None;
                   });
          };
      ]
    else []
  in
  [
    C.Type
      {
        attributes = [ attribute ];
        modifiers = [ Public; Sealed ];
        kind = Record;
        name;
        params = None;
        base = None;
        body = Some (Packed, members);
      };
  ]

(* The case a union's member is: what it refers to, Array, Text, or the one
   string its first property that admits one admits, else Object. *)
and union state name (members, written) =
  let variant (s : Schema.schema) =
    match s with
    | { ref_ = Some r; _ } -> referenced r
    | { type_ = Some [ Array ]; _ } -> "Array"
    | { type_ = Some [ String ]; _ } -> "Text"
    | { properties = Some properties; _ } -> (
        match
          List.find_map
            (fun (_, p) ->
              match p with
              | Schema.Schema p -> constant p
              | Boolean_schema _ -> None)
            properties
        with
        | Some tag -> tag
        | None -> "Object")
    | _ -> "Object"
  in
  let cases =
    List.mapi
      (fun i member ->
        let v = variant (layer name member) in
        (pascal v ^ "Case", type_of state name v (member, nth i written)))
      members
  in
  let names = List.map fst cases in
  if List.length (List.sort_uniq String.compare names) <> List.length names then
    refuse "%s has colliding C# union cases." name;
  let attribute : C.attribute =
    {
      name = "global::Xynolog.Serialization.WireUnion";
      args = List.map (fun case -> C.Typeof (C.T (name ^ "." ^ case))) names;
    }
  in
  [
    C.Type
      {
        attributes = [ attribute ];
        modifiers = [ Public; Closed ];
        kind = Record;
        name;
        params = None;
        base = None;
        body =
          Some
            ( Packed,
              List.map
                (fun (case, t) ->
                  C.Nested
                    (Type
                       {
                         attributes = [];
                         modifiers = [ Public; Sealed ];
                         kind = Record;
                         name = case;
                         params =
                           Some [ { by = `Value; type_ = t; name = "Value" } ];
                         base = Some (T name);
                         body = None;
                       }))
                cases );
      };
  ]

type t = {
  models : (string * definition * C.decl list) list;  (** By name. *)
  schemas : (string * Yojson.Safe.t) list;
      (** Every schema the models are made from, in the order each was named. *)
  member_type : string -> string -> string option;
      (** The model of its own a member of a model is made as. *)
}

(* [roots] are the schemas the models are made from, in order, each
   validated; [made] are the bus's payload types beside them. *)
let make ~identifiers ~roots ~made =
  let state =
    {
      definitions = Hashtbl.create 1024;
      order = [];
      identifiers;
      written = Hashtbl.create 1024;
      inlined = Hashtbl.create 256;
    }
  in
  try
    List.iter
      (fun (name, path, d) ->
        validate path (d.schema, d.json);
        define state name d)
      roots;
    List.iter (fun (name, d) -> define state name d) made;
    List.iter
      (fun name -> ignore (named state name))
      (List.sort String.compare (List.rev state.order));
    let models =
      Hashtbl.fold (fun name decls acc -> (name, decls) :: acc) state.written []
      |> List.sort (fun (a, _) (b, _) -> String.compare a b)
      |> List.map (fun (name, decls) -> (name, definition state name, decls))
    in
    Ok
      {
        models;
        schemas =
          List.rev_map
            (fun name -> (name, (definition state name).json))
            state.order;
        member_type =
          (fun owner property ->
            Hashtbl.find_opt state.inlined
              (owner ^ "." ^ field_name owner property));
      }
  with Refused message -> Error message
