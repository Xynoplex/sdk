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

let map f layer =
  let each = Option.map (List.map f) in
  {
    layer with
    properties =
      Option.map (List.map (fun (name, s) -> (name, f s))) layer.properties;
    additional_properties = Option.map f layer.additional_properties;
    property_names = Option.map f layer.property_names;
    items = Option.map f layer.items;
    all_of = each layer.all_of;
    any_of = each layer.any_of;
    one_of = each layer.one_of;
    not_ = Option.map f layer.not_;
  }

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
