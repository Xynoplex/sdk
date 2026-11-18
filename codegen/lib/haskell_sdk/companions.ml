(* What the Haskell SDK's models come with: Xynolog.Types, which exports every
   model module; the schemas the SDK validates against at run time, each
   without what only describes it; and the dispatcher the round-trip tests
   decode and encode each model's examples by. *)

module H = Haskell_syntax

let rec value : Yojson.Safe.t -> H.expr = function
  | `Assoc members ->
      Apply
        ( Name "Object",
          [
            Apply
              ( Name "KM.fromList",
                [
                  List
                    (List.map
                       (fun (k, v) -> H.Tuple [ Str k; value v ])
                       (List.sort
                          (fun (a, _) (b, _) -> String.compare a b)
                          members));
                ] );
          ] )
  | `List items ->
      Apply
        ( Name "Array",
          [ Apply (Name "V.fromList", [ List (List.map value items) ]) ] )
  | `String s -> Apply (Name "String", [ Str s ])
  | `Int n ->
      Apply
        ( Name "Number",
          [ Apply (Name "read", [ Str (Models.scientific (Float.of_int n)) ]) ]
        )
  | `Float f ->
      Apply
        (Name "Number", [ Apply (Name "read", [ Str (Models.scientific f) ]) ])
  | `Bool b -> Apply (Name "Bool", [ Name (if b then "True" else "False") ])
  | `Null -> Name "Null"
  | `Intlit _ -> invalid_arg "Companions: no JSON value of this kind"

let literal : Schema.literal -> Yojson.Safe.t = function
  | String_literal s -> `String s
  | Int_literal n -> `Int n
  | Bool_literal b -> `Bool b

let type_word : Schema.type_name -> string = function
  | String -> "string"
  | Object -> "object"
  | Integer -> "integer"
  | Array -> "array"
  | Boolean -> "boolean"
  | Number -> "number"

let format_word : Schema.format -> string = function
  | Date_time -> "date-time"
  | Uri -> "uri"
  | Binary -> "binary"

(* A schema as the SDK validates against it: every keyword but those that
   only describe it. *)
let runtime : Schema.t -> Yojson.Safe.t =
  Schema.cata
    ~boolean:(fun b -> `Bool b)
    ~schema:(fun s ->
      let some name f = Option.map (fun v -> (name, f v)) in
      let int n = `Int n in
      let schemas = Option.map (fun xs -> `List xs) in
      `Assoc
        (List.filter_map Fun.id
           [
             some "$ref" (fun (r : Decode.reference) -> `String r.target) s.ref_;
             some "type"
               (function
                 | [ t ] -> `String (type_word t)
                 | ts -> `List (List.map (fun t -> `String (type_word t)) ts))
               s.type_;
             some "format" (fun f -> `String (format_word f)) s.format;
             some "enum" (fun vs -> `List (List.map literal vs)) s.enum;
             some "nullable" (fun b -> `Bool b) s.nullable;
             some "properties" (fun ps -> `Assoc ps) s.properties;
             some "required"
               (fun rs -> `List (List.map (fun r -> `String r) rs))
               s.required;
             some "additionalProperties" Fun.id s.additional_properties;
             some "maxProperties" int s.max_properties;
             some "items" Fun.id s.items;
             some "minItems" int s.min_items;
             some "maxItems" int s.max_items;
             some "uniqueItems" (fun b -> `Bool b) s.unique_items;
             some "minLength" int s.min_length;
             some "maxLength" int s.max_length;
             some "pattern" (fun p -> `String p) s.pattern;
             some "minimum" (fun f -> `Float f) s.minimum;
             some "maximum" (fun f -> `Float f) s.maximum;
             Option.map (fun v -> ("allOf", v)) (schemas s.all_of);
             Option.map (fun v -> ("anyOf", v)) (schemas s.any_of);
             Option.map (fun v -> ("oneOf", v)) (schemas s.one_of);
           ]))

let schemas_module ~banner definitions =
  let body =
    [
      H.value "schemas" (T_name "Schemas")
        (Apply
           ( Name "Map.fromList",
             [
               List
                 (List.map
                    (fun (name, schema) ->
                      H.Tuple [ Str name; value (runtime schema) ])
                    definitions);
             ] ));
    ]
  in
  let used = H.uses body in
  {
    H.banner;
    extensions = [ "OverloadedStrings" ];
    name = "Xynolog.Internal.Generated.Schemas";
    imports =
      [
        H.import "Data.Aeson" ~items:[ All "Value" ];
        H.import "Data.Aeson.KeyMap" ~qualified:"KM";
      ]
      @ [ H.import "Data.Map.Strict" ~qualified:"Map" ]
      @ (if List.mem "V.fromList" used.values then
           [ H.import "Data.Vector" ~qualified:"V" ]
         else [])
      @ [ H.import "Xynolog.Internal.Schema" ~items:[ Plain "Schemas" ] ];
    body;
  }

let types_module ~banner module_names =
  {
    H.banner;
    extensions = [ "OverloadedStrings" ];
    name = "Xynolog.Types";
    imports = List.map (fun m -> H.import m) module_names;
    body = List.map (fun m -> H.Reexport m) module_names;
  }

let round_trip_module ~banner names =
  {
    H.banner;
    extensions = [ "OverloadedStrings" ];
    name = "Xynolog.Internal.Generated.RoundTrip";
    imports =
      [
        H.import "Data.Aeson"
          ~items:[ Plain "Value"; Plain "parseJSON"; Plain "toJSON" ];
        H.import "Data.Aeson.Types" ~items:[ Plain "parseEither" ];
        H.import "Data.Text" ~items:[ Plain "Text" ];
        H.import "Xynolog.Types";
      ];
    body =
      [
        Value
          {
            about = [];
            name = "roundTrip";
            type_ =
              T_fun
                ( T_name "Text",
                  T_fun
                    ( T_name "Value",
                      T_apply ("Either", [ T_name "String"; T_name "Value" ]) )
                );
            clauses =
              [
                {
                  patterns = [ Var "name"; Var "value" ];
                  body =
                    Case
                      ( Name "name",
                        List.map
                          (fun n ->
                            ( H.Literal n,
                              H.Infix
                                ( Name "toJSON",
                                  [
                                    ( "<$>",
                                      Typed
                                        ( Apply
                                            ( Name "parseEither",
                                              [ Name "parseJSON"; Name "value" ]
                                            ),
                                          T_apply
                                            ( "Either",
                                              [ T_name "String"; T_name n ] ) )
                                    );
                                  ] ) ))
                          names
                        @ [
                            ( Otherwise,
                              Apply
                                ( Name "Left",
                                  [
                                    Str
                                      "unknown schema in round-trip dispatcher";
                                  ] ) );
                          ] );
                };
              ];
          };
      ];
  }
