(* A JSON Schema as Protocol writes them: OpenAPI 3.0's dialect, and only the
   keywords, types and formats Protocol uses. A keyword outside that set is
   refused, so a spec that starts using one stops the run until the model
   knows it. *)

type type_name = String | Object | Integer | Array | Boolean | Number
type format = Date_time | Uri | Binary

type literal =
  | String_literal of string
  | Int_literal of int
  | Bool_literal of bool

type discriminator = {
  property_name : string;
  mapping : (string * string) list option;
}

(* One schema's keywords, with ['a] wherever a keyword holds schemas: a
   schema is a layer whose children are schemas, and [map] rewrites a layer's
   children with nothing else of it changed. *)
type 'a layer = {
  ref_ : Decode.reference option;
  comment : string option;
  title : string option;
  description : string option;
  type_ : type_name list option;
  format : format option;
  enum : literal list option;
  const : literal option;
  default : literal option;
  example : Yojson.Safe.t option;
  nullable : bool option;
  properties : (string * 'a) list option;
  required : string list option;
  additional_properties : 'a option;
  property_names : 'a option;
  min_properties : int option;
  max_properties : int option;
  items : 'a option;
  min_items : int option;
  max_items : int option;
  unique_items : bool option;
  min_length : int option;
  max_length : int option;
  pattern : string option;
  minimum : float option;
  maximum : float option;
  all_of : 'a list option;
  any_of : 'a list option;
  one_of : 'a list option;
  not_ : 'a option;
  discriminator : discriminator option;
}

type t = Boolean_schema of bool | Schema of schema
and schema = t layer

(* A schema that states nothing. *)
let empty : schema =
  {
    ref_ = None;
    comment = None;
    title = None;
    description = None;
    type_ = None;
    format = None;
    enum = None;
    const = None;
    default = None;
    example = None;
    nullable = None;
    properties = None;
    required = None;
    additional_properties = None;
    property_names = None;
    min_properties = None;
    max_properties = None;
    items = None;
    min_items = None;
    max_items = None;
    unique_items = None;
    min_length = None;
    max_length = None;
    pattern = None;
    minimum = None;
    maximum = None;
    all_of = None;
    any_of = None;
    one_of = None;
    not_ = None;
    discriminator = None;
  }

(* The schemas [layer] holds, in the order its keywords are written here. A
   [$ref] holds none: it names a schema, and what that is is the reader's to
   resolve. The pattern names every field, so a keyword the model learns is
   one this must place. *)
let children
    {
      ref_ = _;
      comment = _;
      title = _;
      description = _;
      type_ = _;
      format = _;
      enum = _;
      const = _;
      default = _;
      example = _;
      nullable = _;
      properties;
      required = _;
      additional_properties;
      property_names;
      min_properties = _;
      max_properties = _;
      items;
      min_items = _;
      max_items = _;
      unique_items = _;
      min_length = _;
      max_length = _;
      pattern = _;
      minimum = _;
      maximum = _;
      all_of;
      any_of;
      one_of;
      not_;
      discriminator = _;
    } =
  let one = Option.to_list and each = Option.value ~default:[] in
  List.concat
    [
      List.map snd (each properties);
      one additional_properties;
      one property_names;
      one items;
      each all_of;
      each any_of;
      each one_of;
      one not_;
    ]

(* [layer] with [f] applied to each schema it holds, in the order [children]
   names them. *)
let map f layer =
  let one = Option.map f and each = Option.map (List.map f) in
  let properties =
    Option.map (List.map (fun (name, s) -> (name, f s))) layer.properties
  in
  let additional_properties = one layer.additional_properties in
  let property_names = one layer.property_names in
  let items = one layer.items in
  let all_of = each layer.all_of in
  let any_of = each layer.any_of in
  let one_of = each layer.one_of in
  let not_ = one layer.not_ in
  {
    layer with
    properties;
    additional_properties;
    property_names;
    items;
    all_of;
    any_of;
    one_of;
    not_;
  }

(* [map], for an [f] that may refuse: the layer of its results, or its first
   refusal in [children]'s order. *)
let traverse f layer =
  let ( let* ) = Result.bind in
  let one = function
    | None -> Ok None
    | Some s -> Result.map Option.some (f s)
  in
  let list g xs =
    Result.map List.rev
      (List.fold_left
         (fun found x ->
           let* found = found in
           let* y = g x in
           Ok (y :: found))
         (Ok []) xs)
  in
  let each = function
    | None -> Ok None
    | Some xs -> Result.map Option.some (list f xs)
  in
  let* properties =
    match layer.properties with
    | None -> Ok None
    | Some ps ->
        Result.map Option.some
          (list
             (fun (name, s) ->
               let* s = f s in
               Ok (name, s))
             ps)
  in
  let* additional_properties = one layer.additional_properties in
  let* property_names = one layer.property_names in
  let* items = one layer.items in
  let* all_of = each layer.all_of in
  let* any_of = each layer.any_of in
  let* one_of = each layer.one_of in
  let* not_ = one layer.not_ in
  Ok
    {
      layer with
      properties;
      additional_properties;
      property_names;
      items;
      all_of;
      any_of;
      one_of;
      not_;
    }

(* The one recursion over a schema: each schema it holds is folded first, in
   [children]'s order, and [schema] is given the layer of their results. It
   stops at a [$ref]: a walk that follows one is given what resolves it, and
   folds the schema it names itself. *)
let rec cata ~boolean ~schema = function
  | Boolean_schema b -> boolean b
  | Schema layer -> schema (map (cata ~boolean ~schema) layer)

(* [cata], with each schema held beside its result: for a walk that reads
   what a child states as well as what the walk made of it. A walk whose
   result is a function of its context (a file, a pointer, a trail) calls
   only the children it means to, in its own order. *)
let rec para ~boolean ~schema = function
  | Boolean_schema b -> boolean b
  | Schema layer ->
      schema (map (fun child -> (child, para ~boolean ~schema child)) layer)

(* The keywords [schema] states, by their names in the spec. The pattern
   names every field, so a keyword the model learns is one this must name. *)
let keywords
    {
      ref_;
      comment;
      title;
      description;
      type_;
      format;
      enum;
      const;
      default;
      example;
      nullable;
      properties;
      required;
      additional_properties;
      property_names;
      min_properties;
      max_properties;
      items;
      min_items;
      max_items;
      unique_items;
      min_length;
      max_length;
      pattern;
      minimum;
      maximum;
      all_of;
      any_of;
      one_of;
      not_;
      discriminator;
    } =
  let is name value = if Option.is_some value then [ name ] else [] in
  List.concat
    [
      is "$ref" ref_;
      is "$comment" comment;
      is "title" title;
      is "description" description;
      is "type" type_;
      is "format" format;
      is "enum" enum;
      is "const" const;
      is "default" default;
      is "example" example;
      is "nullable" nullable;
      is "properties" properties;
      is "required" required;
      is "additionalProperties" additional_properties;
      is "propertyNames" property_names;
      is "minProperties" min_properties;
      is "maxProperties" max_properties;
      is "items" items;
      is "minItems" min_items;
      is "maxItems" max_items;
      is "uniqueItems" unique_items;
      is "minLength" min_length;
      is "maxLength" max_length;
      is "pattern" pattern;
      is "minimum" minimum;
      is "maximum" maximum;
      is "allOf" all_of;
      is "anyOf" any_of;
      is "oneOf" one_of;
      is "not" not_;
      is "discriminator" discriminator;
    ]

(* The keywords [schema] states that no SDK reads, in the order [keywords]
   names them. An SDK that dropped one would accept what the schema refuses,
   so a schema an SDK validates by states none. *)
let unread schema =
  List.filter
    (fun keyword ->
      List.mem keyword [ "const"; "propertyNames"; "minProperties"; "not" ])
    (keywords schema)

(* [unread] of a schema and of every schema it holds, at any depth. *)
let unread_anywhere : t -> string list =
  cata
    ~boolean:(fun _ -> [])
    ~schema:(fun s -> unread s @ List.concat (children s))

let type_name =
  Decode.enum
    [
      ("string", String);
      ("object", Object);
      ("integer", Integer);
      ("array", Array);
      ("boolean", Boolean);
      ("number", Number);
    ]

let types cursor =
  match Decode.kind cursor with
  | Decode.Array -> Decode.non_empty_list type_name cursor
  | _ -> [ type_name cursor ]

let format =
  Decode.enum [ ("date-time", Date_time); ("uri", Uri); ("binary", Binary) ]

let literal cursor =
  match Decode.kind cursor with
  | Decode.String -> String_literal (Decode.string cursor)
  | Decode.Int -> Int_literal (Decode.int cursor)
  | Decode.Bool -> Bool_literal (Decode.bool cursor)
  | _ -> Decode.refuse cursor "expected a string, integer or boolean literal"

let discriminator =
  Decode.obj (fun o ->
      let property_name = Decode.required o "propertyName" Decode.string in
      let mapping = Decode.optional o "mapping" (Decode.map Decode.string) in
      { property_name; mapping })

let rec decode cursor =
  match Decode.kind cursor with
  | Decode.Bool -> Boolean_schema (Decode.bool cursor)
  | _ -> Schema (schema cursor)

and schema cursor =
  Decode.obj
    (fun o ->
      let ref_ = Decode.optional o "$ref" Decode.reference in
      let comment = Decode.optional o "$comment" Decode.string in
      let title = Decode.optional o "title" Decode.string in
      let description = Decode.optional o "description" Decode.string in
      let type_ = Decode.optional o "type" types in
      let format = Decode.optional o "format" format in
      let enum = Decode.optional o "enum" (Decode.non_empty_list literal) in
      let const = Decode.optional o "const" literal in
      let default = Decode.optional o "default" literal in
      let example = Decode.optional o "example" Decode.json in
      let nullable = Decode.optional o "nullable" Decode.bool in
      let properties = Decode.optional o "properties" (Decode.map decode) in
      let required = Decode.optional o "required" (Decode.list Decode.string) in
      let additional_properties =
        Decode.optional o "additionalProperties" decode
      in
      let property_names = Decode.optional o "propertyNames" decode in
      let min_properties = Decode.optional o "minProperties" Decode.int in
      let max_properties = Decode.optional o "maxProperties" Decode.int in
      let items = Decode.optional o "items" decode in
      let min_items = Decode.optional o "minItems" Decode.int in
      let max_items = Decode.optional o "maxItems" Decode.int in
      let unique_items = Decode.optional o "uniqueItems" Decode.bool in
      let min_length = Decode.optional o "minLength" Decode.int in
      let max_length = Decode.optional o "maxLength" Decode.int in
      let pattern = Decode.optional o "pattern" Decode.string in
      let minimum = Decode.optional o "minimum" Decode.number in
      let maximum = Decode.optional o "maximum" Decode.number in
      let all_of = Decode.optional o "allOf" (Decode.non_empty_list decode) in
      let any_of = Decode.optional o "anyOf" (Decode.non_empty_list decode) in
      let one_of = Decode.optional o "oneOf" (Decode.non_empty_list decode) in
      let not_ = Decode.optional o "not" decode in
      let discriminator = Decode.optional o "discriminator" discriminator in
      {
        ref_;
        comment;
        title;
        description;
        type_;
        format;
        enum;
        const;
        default;
        example;
        nullable;
        properties;
        required;
        additional_properties;
        property_names;
        min_properties;
        max_properties;
        items;
        min_items;
        max_items;
        unique_items;
        min_length;
        max_length;
        pattern;
        minimum;
        maximum;
        all_of;
        any_of;
        one_of;
        not_;
        discriminator;
      })
    cursor
