(* Every object component the gateway's document names, as a record of the
   OCaml SDK (ocaml/sdk/lib/records.ml), and every one that is a
   discriminated union of them as a variant. An object composed by allOf is
   its parts' members together, a member two parts state being read raw; a
   string or a boolean member is read as one, and every other kept as its raw
   JSON, numbers exactly. A union's every branch is one of the records. *)

let string = Text.ocaml_quoted

let keywords =
  "and as assert begin class constraint do done downto effect else end \
   exception external false for fun function functor if in include inherit \
   initializer land lazy let lor lsl lsr lxor match method mod module mutable \
   new nonrec object of open or private rec sig struct then to true try type \
   val virtual when while with" |> String.split_on_char ' '

let module_name name = String.capitalize_ascii (Text.snake name)

let field_name name =
  let label =
    String.map
      (function ('a' .. 'z' | '0' .. '9' | '_') as c -> c | _ -> '_')
      (Text.snake name)
  in
  if List.mem label keywords || label = "extra" then label ^ "_"
  else match label.[0] with 'a' .. 'z' -> label | _ -> "field" ^ label

(* A member's schema as it is read: a string or a boolean, or raw. *)
type member = Text_member | Bool_member | Raw_member
type composed = { properties : (string * member) list; required : string list }

let member_of = function
  | Schema.Schema { type_ = Some [ String ]; nullable = None | Some false; _ }
    ->
      Text_member
  | Schema.Schema { type_ = Some [ Boolean ]; nullable = None | Some false; _ }
    ->
      Bool_member
  | _ -> Raw_member

exception Refused of Decode.error

(* The object a schema of [file] is, its references followed, or none. *)
let rec object_shape (spec : Spec.t) ~file ~seen (schema : Schema.t) =
  match schema with
  | Schema.Boolean_schema _ -> None
  | Schema.Schema ({ ref_ = Some reference; _ } : Schema.schema) ->
      let target, _ = Decode.resolve reference in
      if List.mem target seen then
        raise
          (Refused
             {
               Decode.file;
               pointer = reference.pointer;
               message = "is an object composed of itself";
             });
      object_shape spec ~file:target ~seen:(target :: seen)
        (List.assoc target spec.schemas)
  | Schema.Schema s -> (
      let own =
        if s.type_ = Some [ Object ] then
          Some
            {
              properties =
                List.map
                  (fun (n, m) -> (n, member_of m))
                  (Option.value ~default:[] s.properties);
              required = Option.value ~default:[] s.required;
            }
        else None
      in
      match s.all_of with
      | None -> own
      | Some parts ->
          let parts = List.map (object_shape spec ~file ~seen) parts in
          if List.mem None parts then None
          else
            let parts = List.filter_map Fun.id parts in
            let all = match own with None -> parts | Some o -> o :: parts in
            let properties =
              List.fold_left
                (fun acc part ->
                  List.fold_left
                    (fun acc (name, m) ->
                      if List.mem_assoc name acc then
                        List.map
                          (fun (n, v) ->
                            if n = name then (n, Raw_member) else (n, v))
                          acc
                      else acc @ [ (name, m) ])
                    acc part.properties)
                [] all
            in
            let required =
              List.fold_left
                (fun acc part ->
                  List.fold_left
                    (fun acc n -> if List.mem n acc then acc else acc @ [ n ])
                    acc part.required)
                [] all
            in
            Some { properties; required })

type record = { name : string; file : string; shape : composed }

type union = {
  name : string;
  property : string;
  variants : (string * string * string) list;
      (** Each tag, its constructor and its branch's module. *)
}

let derive (spec : Spec.t) =
  try
    let components =
      List.map
        (fun (name, reference) ->
          let file, _ = Decode.resolve reference in
          (name, file, List.assoc file spec.schemas))
        spec.gateway.components.schemas
    in
    let records =
      List.filter_map
        (fun (name, file, schema) ->
          match object_shape spec ~file ~seen:[ file ] schema with
          | Some shape when shape.properties <> [] -> Some { name; file; shape }
          | _ -> None)
        components
    in
    let module_of file =
      Option.map
        (fun (r : record) -> module_name r.name)
        (List.find_opt (fun (r : record) -> r.file = file) records)
    in
    let refuse file pointer message =
      raise (Refused { Decode.file; pointer; message })
    in
    let unions =
      List.filter_map
        (fun (name, file, schema) ->
          match schema with
          | Schema.Schema
              {
                discriminator = Some { property_name; mapping };
                one_of = Some branches;
                _;
              } ->
              List.iter
                (function
                  | Schema.Schema { ref_ = Some r; _ }
                    when Option.is_some (module_of (fst (Decode.resolve r))) ->
                      ()
                  | _ ->
                      refuse file "/oneOf"
                        "has a branch that is no record of the SDK's")
                branches;
              let variants =
                List.map
                  (fun (tag, target) ->
                    let branch, _ =
                      Decode.resolve
                        { Decode.target; file; pointer = "/discriminator" }
                    in
                    let parts =
                      String.split_on_char '_'
                        (String.map
                           (function
                             | ('a' .. 'z' | 'A' .. 'Z' | '0' .. '9') as c -> c
                             | _ -> '_')
                           tag)
                    in
                    let camel =
                      match parts with
                      | [] -> ""
                      | first :: rest ->
                          first
                          ^ String.concat ""
                              (List.map String.capitalize_ascii
                                 (List.filter (( <> ) "") rest))
                    in
                    match module_of branch with
                    | Some m when camel <> "" ->
                        (tag, String.capitalize_ascii camel, m)
                    | _ ->
                        refuse file
                          ("/discriminator/mapping/" ^ Decode.escape tag)
                          "names no record of the SDK's")
                  (Option.value ~default:[] mapping)
              in
              let constructors = List.map (fun (_, c, _) -> c) variants in
              if
                List.length (List.sort_uniq compare constructors)
                <> List.length constructors
              then
                refuse file "/discriminator/mapping" "names two variants alike";
              Some { name; property = property_name; variants }
          | _ -> None)
        components
    in
    List.iter
      (fun (r : record) ->
        let labels = List.map (fun (n, _) -> field_name n) r.shape.properties in
        if List.length (List.sort_uniq compare labels) <> List.length labels
        then refuse r.file "/properties" "has two members OCaml names alike")
      records;
    Ok (records, unions)
  with Refused e -> Error [ e ]

let helpers =
  [
    "let object_fields = function `Assoc fields -> fields | _ -> assert false";
    "let string = function";
    "  | `Stringlit literal -> (match Yojson.Safe.from_string literal with \
     `String text -> text | _ -> assert false)";
    "  | _ -> assert false";
    "let bool = function `Bool value -> value | _ -> assert false";
    "let required read name fields = read (List.assoc name fields)";
    "let optional read name fields =";
    "  match List.assoc_opt name fields with";
    "  | None -> Types.Absent | Some `Null -> Types.Null | Some value -> \
     Types.Present (read value)";
    "let identity value = value";
    "let extra names = List.filter (fun (name, _) -> not (List.mem name names))";
  ]

let files (records, unions) =
  let record (r : record) =
    let fields =
      List.map
        (fun (name, m) ->
          let type_, read =
            match m with
            | Text_member -> ("string", "string")
            | Bool_member -> ("bool", "bool")
            | Raw_member -> ("Yojson.Raw.t", "identity")
          in
          let optional = not (List.mem name r.shape.required) in
          ( name,
            field_name name,
            read,
            optional,
            if optional then type_ ^ " Types.presence" else type_ ))
        r.shape.properties
    in
    let m = module_name r.name in
    let type_ =
      "  type t = { "
      ^ String.concat "; "
          (List.map (fun (_, label, _, _, t) -> label ^ " : " ^ t) fields)
      ^ "; extra : (string * Yojson.Raw.t) list }"
    in
    let view =
      [ "  let project fields ="; "    {" ]
      @ List.map
          (fun (name, label, read, optional, _) ->
            "      " ^ label ^ " = "
            ^ (if optional then "optional" else "required")
            ^ " " ^ read ^ " " ^ string name ^ " fields;")
          fields
      @ [
          "      extra = extra ["
          ^ String.concat "; "
              (List.map (fun (n, _, _, _, _) -> string n) fields)
          ^ "] fields;";
          "    }";
          "  let of_model model = project (object_fields (Models.json model))";
        ]
    in
    ( [
        "module " ^ m ^ " : sig";
        type_;
        "  val of_model : [ `" ^ r.name ^ " ] Models.t -> t";
        "end";
      ],
      [ "module " ^ m ^ " = struct"; type_ ] @ view @ [ "end" ] )
  in
  let union u =
    let m = module_name u.name in
    let type_ =
      "  type t = "
      ^ String.concat " | "
          (List.map
             (fun (_, c, branch) -> c ^ " of " ^ branch ^ ".t")
             u.variants)
    in
    ( [
        "module " ^ m ^ " : sig";
        type_;
        "  val of_model : [ `" ^ u.name ^ " ] Models.t -> t option";
        "end";
      ],
      [
        "module " ^ m ^ " = struct";
        type_;
        "  let of_model model =";
        "    let fields = object_fields (Models.json model) in";
        "    match List.assoc_opt " ^ string u.property ^ " fields with";
        "    | Some (`Stringlit literal) -> (match string (`Stringlit literal) \
         with";
      ]
      @ List.map
          (fun (tag, c, branch) ->
            "      | " ^ string tag ^ " -> Some (" ^ c ^ " (" ^ branch
            ^ ".project fields))")
          u.variants
      @ [ "      | _ -> None)"; "    | _ -> None"; "end" ] )
  in
  let entries = List.map record records @ List.map union unions in
  let header =
    Banner.ocaml ~from_:"OpenAPI object components and discriminator mappings"
      __FILE__
    ^ "\n"
  in
  [
    {
      Output.path = "ocaml/sdk/lib/records.ml";
      text =
        header
        ^ String.concat "\n" (helpers @ List.concat_map snd entries)
        ^ "\n";
    };
    {
      Output.path = "ocaml/sdk/lib/records.mli";
      text = header ^ String.concat "\n" (List.concat_map fst entries) ^ "\n";
    };
  ]
