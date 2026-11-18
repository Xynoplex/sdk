(* Every object component the gateway's document names, as a record of the
   OCaml SDK (ocaml/sdk/lib/records.ml), and every one that is a
   discriminated union of them as a variant. An object composed by allOf is
   its parts' members together, a member two parts state being read raw; a
   string or a boolean member is read as one, and every other kept as its raw
   JSON, numbers exactly. A union's every branch is one of the records.
   Records are read through ocaml/sdk/lib/record_reader.ml, and the module
   has no interface, so each record's type is stated once. *)

module O = Ocaml_syntax

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
let object_shape (spec : Spec.t) =
  let rec shape schema : file:string -> seen:string list -> composed option =
    Schema.para
      ~boolean:(fun _ ~file:_ ~seen:_ -> None)
      ~schema:(fun s ~file ~seen ->
        match s.ref_ with
        | Some reference ->
            let target, _ = Decode.resolve reference in
            if List.mem target seen then
              raise
                (Refused
                   {
                     Decode.file;
                     pointer = reference.pointer;
                     message = "is an object composed of itself";
                   });
            shape
              (List.assoc target spec.schemas)
              ~file:target ~seen:(target :: seen)
        | None -> (
            let own =
              if s.type_ = Some [ Object ] then
                Some
                  {
                    properties =
                      List.map
                        (fun (n, (m, _)) -> (n, member_of m))
                        (Option.value ~default:[] s.properties);
                    required = Option.value ~default:[] s.required;
                  }
              else None
            in
            match s.all_of with
            | None -> own
            | Some parts ->
                let parts =
                  List.map (fun (_, part) -> part ~file ~seen) parts
                in
                if List.mem None parts then None
                else
                  let parts = List.filter_map Fun.id parts in
                  let all =
                    match own with None -> parts | Some o -> o :: parts
                  in
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
                          (fun acc n ->
                            if List.mem n acc then acc else acc @ [ n ])
                          acc part.required)
                      [] all
                  in
                  Some { properties; required }))
      schema
  in
  fun ~file ~seen schema -> shape schema ~file ~seen

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

(* [let of_model (model : [ `Kind ] Models.t) = body]. *)
let of_model kind body =
  O.let_ "of_model"
    (O.fun_
       [
         O.Pattern.constraint_ (O.Pattern.var "model")
           (O.type_ "Models.t" ~args:[ O.tags [ kind ] ]);
       ]
       body)

let model_fields =
  O.call "fields_of" [ O.call "Models.json" [ O.ident "model" ] ]

let files (records, unions) =
  let record (r : record) =
    let fields =
      List.map
        (fun (name, m) ->
          let type_, read =
            match m with
            | Text_member -> ("string", "string")
            | Bool_member -> ("bool", "bool")
            | Raw_member -> ("Yojson.Raw.t", "raw")
          in
          let optional = not (List.mem name r.shape.required) in
          ( name,
            field_name name,
            read,
            optional,
            if optional then O.type_ "Types.presence" ~args:[ O.type_ type_ ]
            else O.type_ type_ ))
        r.shape.properties
    in
    let m = module_name r.name in
    let t =
      O.type_declaration "t"
        (Record
           (List.map (fun (_, label, _, _, t) -> (label, t)) fields
           @ [
               ( "extra",
                 O.type_ "list"
                   ~args:
                     [
                       O.type_tuple [ O.type_ "string"; O.type_ "Yojson.Raw.t" ];
                     ] );
             ]))
    in
    (* A record's fields are evaluated in no stated order, so the members no
       read named are taken once the record is built. *)
    let project =
      O.define "project" [ "fields" ]
        (O.let_in "reader"
           (O.call "start" [ O.ident "fields" ])
           (O.let_in "record"
              (O.record
                 (List.map
                    (fun (name, label, read, optional, _) ->
                      ( label,
                        O.call
                          (if optional then "optional" else "required")
                          [ O.ident "reader"; O.ident read; O.string name ] ))
                    fields
                 @ [ ("extra", O.list []) ]))
              (O.record ~with_:(O.ident "record")
                 [ ("extra", O.call "rest" [ O.ident "reader" ]) ])))
    in
    O.module_ m
      [
        O.type_item t;
        project;
        of_model r.name (O.call "project" [ model_fields ]);
      ]
  in
  let union u =
    let m = module_name u.name in
    let t =
      O.type_declaration "t"
        (Variant
           (List.map
              (fun (_, c, branch) ->
                O.constructor c ~args:[ O.type_ (branch ^ ".t") ])
              u.variants))
    in
    let literal = O.variant "Stringlit" ~arg:(O.ident "literal") in
    let of_model =
      of_model u.name
        (O.let_in "fields" model_fields
           (O.match_
              (O.call "List.assoc_opt"
                 [ O.string u.property; O.ident "fields" ])
              [
                O.case
                  (O.Pattern.construct "Some"
                     ~arg:
                       (O.Pattern.variant "Stringlit"
                          ~arg:(O.Pattern.var "literal")))
                  (O.match_
                     (O.call "string" [ literal ])
                     (List.map
                        (fun (tag, c, branch) ->
                          O.case (O.Pattern.string tag)
                            (O.some
                               (O.construct c
                                  ~arg:
                                    (O.call (branch ^ ".project")
                                       [ O.ident "fields" ]))))
                        u.variants
                     @ [ O.case O.Pattern.any O.none ]));
                O.case O.Pattern.any O.none;
              ]))
    in
    O.module_ m [ O.type_item t; of_model ]
  in
  let entries = List.map record records @ List.map union unions in
  let banner =
    Banner.ocaml ~from_:"OpenAPI object components and discriminator mappings"
      __FILE__
  in
  [
    O.implementation ~path:"ocaml/sdk/lib/records.ml" ~banner
      (O.open_ "Record_reader" :: entries);
  ]
