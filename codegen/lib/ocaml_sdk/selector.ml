(* The selector (components/schemas/Selector.json) as the OCaml SDK reads and
   writes it (ocaml/sdk/lib/selector.ml): a variant per branch its
   discriminator maps, each a record of the branch's members and whatever
   else the object holds. A branch is an open object whose tag is its own
   name alone, and each other member a string or an integer, with at most a
   least value; the mapping and the branches are one to one. *)

let file = "components/schemas/Selector.json"
let string = Text.ocaml_quoted

type field = {
  name : string;
  label : string;
  reader : string;
  type_ : string;
  writer : string;
  optional : bool;
}

type variant = { constructor : string; fields : field list; record : string }

let derive (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let refuse ?(file = file) pointer message =
    Error [ { Decode.file; pointer; message } ]
  in
  let* schema =
    match List.assoc_opt file spec.schemas with
    | Some (Schema.Schema s) -> Ok s
    | _ -> refuse "" "is no schema"
  in
  let* tag, mapping =
    match schema.discriminator with
    | Some { property_name; mapping = Some mapping } -> Ok (property_name, mapping)
    | _ -> refuse "/discriminator" "maps no branch"
  in
  let branches =
    List.filter_map
      (function
        | Schema.Schema { ref_ = Some r; _ } -> Some r.target | _ -> None)
      (Option.value ~default:[] schema.one_of)
  in
  let* () =
    if
      List.length (List.sort_uniq compare branches) <> List.length branches
      || List.length branches
         <> List.length (Option.value ~default:[] schema.one_of)
      || List.sort compare branches <> List.sort compare (List.map snd mapping)
    then refuse "/discriminator/mapping" "does not map its branches one to one"
    else Ok ()
  in
  let variant (constructor, target) =
    let reference = { Decode.target; file; pointer = "/discriminator/mapping" } in
    let branch, _ = Decode.resolve reference in
    let refuse_branch pointer message = refuse ~file:branch pointer message in
    let valid_name =
      constructor <> ""
      && (match constructor.[0] with 'A' .. 'Z' -> true | _ -> false)
      && String.for_all
           (function 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' -> true | _ -> false)
           constructor
    in
    match List.assoc_opt branch spec.schemas with
    | Some
        (Schema.Schema
           {
             type_ = Some [ Object ];
             properties = Some properties;
             required = Some required;
             additional_properties = None | Some (Boolean_schema true);
             _;
           })
      when valid_name && List.mem tag required
           &&
           match List.assoc_opt tag properties with
           | Some (Schema.Schema { enum = Some [ String_literal c ]; _ }) ->
               c = constructor
           | _ -> false ->
        let field (name, declared) =
          match declared with
          | Schema.Schema s -> (
              let others =
                List.filter
                  (fun k ->
                    not (List.mem k [ "type"; "minimum"; "description"; "example" ]))
                  (Schema.keywords s)
              in
              let label = if name = "end" then "end_" else Text.snake name in
              let optional = not (List.mem name required) in
              match (others, s.type_, s.minimum) with
              | [], Some [ String ], None ->
                  Ok
                    {
                      name = string name;
                      label;
                      reader = "string";
                      type_ = "string";
                      writer = "json_string";
                      optional;
                    }
              | [], Some [ Integer ], least
                when Option.fold ~none:true ~some:Float.is_integer least ->
                  Ok
                    {
                      name = string name;
                      label;
                      reader =
                        (match least with
                        | None -> "integer"
                        | Some n -> Printf.sprintf "(integer_at_least %.0f)" n);
                      type_ = "Z.t";
                      writer = "json_integer";
                      optional;
                    }
              | _ ->
                  refuse_branch ("/properties/" ^ name)
                    "is neither a string nor an integer with at most a least \
                     value")
          | Schema.Boolean_schema _ ->
              refuse_branch ("/properties/" ^ name) "is no schema"
        in
        let* fields =
          List.fold_right
            (fun f rest ->
              let* f = field f in
              let* rest = rest in
              Ok (f :: rest))
            (List.filter (fun (n, _) -> n <> tag) properties)
            (Ok [])
        in
        Ok { constructor; fields; record = Text.snake constructor }
    | _ -> refuse_branch "" "is no open selector object tagged with its own name"
  in
  let* variants =
    List.fold_right
      (fun m rest ->
        let* v = variant m in
        let* rest = rest in
        Ok (v :: rest))
      mapping (Ok [])
  in
  Ok (tag, variants)

let helpers =
  {|let ( let* ) = Result.bind
let malformed member = Error { member; reason = `Malformed }
let string member = function `String value -> Ok value | _ -> malformed member
let integer member = function
  | `Int value -> Ok (Z.of_int value)
  | `Intlit value ->
      (try
         let number = Z.of_string value in
         if Z.to_string number = value || value = "-0" then Ok number else malformed member
       with Invalid_argument _ -> malformed member)
  | _ -> malformed member
let integer_at_least minimum member json =
  let* value = integer member json in
  if Z.geq value (Z.of_int minimum) then Ok value else malformed member
let required read member fields =
  match List.assoc_opt member fields with
  | None -> Error { member; reason = `Lacks }
  | Some value -> read member value
let optional read member fields =
  match List.assoc_opt member fields with
  | None -> Ok None
  | Some value -> Result.map Option.some (read member value)
let extra names = List.filter (fun (name, _) -> not (List.mem name names))
let json_string value = `String value
let json_integer value = if Z.fits_int value then `Int (Z.to_int value) else `Intlit (Z.to_string value)|}

let files (tag, variants) =
  let tag_name = string tag in
  let types =
    List.map
      (fun v ->
        "type " ^ v.record ^ " = { "
        ^ String.concat "; "
            (List.map
               (fun f ->
                 f.label ^ " : " ^ f.type_ ^ if f.optional then " option" else "")
               v.fields)
        ^ "; extra : (string * Yojson.Safe.t) list }")
      variants
    @ [
        "type t = "
        ^ String.concat " | "
            (List.map (fun v -> v.constructor ^ " of " ^ v.record) variants);
        "type fault = { member : string; reason : [ `Lacks | `Malformed ] }";
      ]
  in
  let names fields =
    "[" ^ String.concat "; " (tag_name :: List.map (fun f -> f.name) fields) ^ "]"
  in
  let labels fields = String.concat "; " (List.map (fun f -> f.label) fields) in
  let branches =
    List.concat_map
      (fun v ->
        let reading =
          List.filter (fun f -> not f.optional) v.fields
          @ List.filter (fun f -> f.optional) v.fields
        in
        (("    | " ^ string v.constructor ^ " ->")
        :: List.map
             (fun f ->
               "        let* " ^ f.label ^ " = "
               ^ (if f.optional then "optional" else "required")
               ^ " " ^ f.reader ^ " " ^ f.name ^ " fields in")
             reading)
        @ [
            "        Ok (" ^ v.constructor ^ " { " ^ labels v.fields
            ^ "; extra = extra " ^ names v.fields ^ " fields })";
          ])
      variants
  in
  let encoder =
    List.concat_map
      (fun v ->
        [
          "  | " ^ v.constructor ^ " value ->";
          "      `Assoc (List.filter_map Fun.id [Some (" ^ tag_name ^ ", `String "
          ^ string v.constructor ^ ");";
        ]
        @ List.map
            (fun f ->
              if f.optional then
                "        Option.map (fun field -> (" ^ f.name ^ ", " ^ f.writer
                ^ " field)) value." ^ f.label ^ ";"
              else
                "        Some (" ^ f.name ^ ", " ^ f.writer ^ " value." ^ f.label
                ^ ");")
            v.fields
        @ [ "      ] @ extra " ^ names v.fields ^ " value.extra)" ])
      variants
  in
  let impl =
    types @ [ helpers; "let of_json = function"; "  | `Assoc fields ->" ]
    @ [
        "      let* tag = required string " ^ tag_name ^ " fields in";
        "      (match tag with";
      ]
    @ branches
    @ [
        "    | _ -> malformed " ^ tag_name ^ ")";
        "  | _ -> malformed \"\"";
        "let to_json = function";
      ]
    @ encoder
  in
  let api =
    types
    @ [
        "val of_json : Yojson.Safe.t -> (t, fault) result";
        "val to_json : t -> Yojson.Safe.t";
      ]
  in
  let header =
    Banner.ocaml ~from_:"Selector.json and its component branches" __FILE__
    ^ "\n"
  in
  [
    { Output.path = "ocaml/sdk/lib/selector.ml"; text = header ^ String.concat "\n" impl ^ "\n" };
    { Output.path = "ocaml/sdk/lib/selector.mli"; text = header ^ String.concat "\n" api ^ "\n" };
  ]
