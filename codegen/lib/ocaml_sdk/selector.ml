(* The selector (components/schemas/Selector.json) as the OCaml SDK reads and
   writes it (ocaml/sdk/lib/selector.ml): a variant per branch its
   discriminator maps, each a record of the branch's members and whatever
   else the object holds. A branch is an open object whose tag is its own
   name alone, and each other member a string or an integer, with at most a
   least value; the mapping and the branches are one to one. *)

let file = "components/schemas/Selector.json"

module O = Ocaml_syntax

type field = {
  name : string;
  label : string;
  reader : Parsetree.expression;
  type_ : Parsetree.core_type;
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
    | Some { property_name; mapping = Some mapping } ->
        Ok (property_name, mapping)
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
    let reference =
      { Decode.target; file; pointer = "/discriminator/mapping" }
    in
    let branch, _ = Decode.resolve reference in
    let refuse_branch pointer message = refuse ~file:branch pointer message in
    let valid_name =
      constructor <> ""
      && (match constructor.[0] with 'A' .. 'Z' -> true | _ -> false)
      && String.for_all
           (function
             | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' -> true | _ -> false)
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
                    not
                      (List.mem k
                         [ "type"; "minimum"; "description"; "example" ]))
                  (Schema.keywords s)
              in
              let label = if name = "end" then "end_" else Text.snake name in
              let optional = not (List.mem name required) in
              match (others, s.type_, s.minimum) with
              | [], Some [ String ], None ->
                  Ok
                    {
                      name;
                      label;
                      reader = O.ident "string";
                      type_ = O.type_ "string";
                      writer = "json_string";
                      optional;
                    }
              | [], Some [ Integer ], least
                when Option.fold ~none:true ~some:Float.is_integer least ->
                  Ok
                    {
                      name;
                      label;
                      reader =
                        (match least with
                        | None -> O.ident "integer"
                        | Some n ->
                            O.apply
                              (O.ident "integer_at_least")
                              [ O.integer (Printf.sprintf "%.0f" n) ]);
                      type_ = O.type_ "Z.t";
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
    | _ ->
        refuse_branch "" "is no open selector object tagged with its own name"
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

let ok value = O.construct "Ok" ~arg:value
let malformed member = O.call "malformed" [ member ]
let fault = O.type_declaration "fault" Required.Ocaml.fault

let helpers =
  let fails reason =
    O.construct "Error"
      ~arg:
        (O.record
           [ ("member", O.ident "member"); ("reason", O.variant reason) ])
  in
  let otherwise = O.case O.Pattern.any (malformed (O.ident "member")) in
  let integer_cases =
    [
      O.case
        (O.Pattern.variant "Int" ~arg:(O.Pattern.var "value"))
        (ok (O.call "Z.of_int" [ O.ident "value" ]));
      O.case
        (O.Pattern.variant "Intlit" ~arg:(O.Pattern.var "value"))
        (O.try_
           (O.let_in "number"
              (O.call "Z.of_string" [ O.ident "value" ])
              (O.if_
                 (O.infix "||"
                    (O.infix "="
                       (O.call "Z.to_string" [ O.ident "number" ])
                       (O.ident "value"))
                    (O.infix "=" (O.ident "value") (O.string "-0")))
                 (ok (O.ident "number"))
                 (malformed (O.ident "member"))))
           [
             O.case
               (O.Pattern.construct "Invalid_argument" ~arg:O.Pattern.any)
               (malformed (O.ident "member"));
           ]);
      otherwise;
    ]
  in
  let lookup = O.call "List.assoc_opt" [ O.ident "member"; O.ident "fields" ] in
  [
    O.let_ "let*" (O.ident "Result.bind");
    O.define "malformed" [ "member" ] (fails "Malformed");
    O.let_ "string"
      (O.fun_function
         [ O.Pattern.var "member" ]
         [
           O.case
             (O.Pattern.variant "String" ~arg:(O.Pattern.var "value"))
             (ok (O.ident "value"));
           otherwise;
         ]);
    O.let_ "integer" (O.fun_function [ O.Pattern.var "member" ] integer_cases);
    O.define "integer_at_least"
      [ "minimum"; "member"; "json" ]
      (O.let_star (O.Pattern.var "value")
         (O.call "integer" [ O.ident "member"; O.ident "json" ])
         (O.if_
            (O.call "Z.geq"
               [ O.ident "value"; O.call "Z.of_int" [ O.ident "minimum" ] ])
            (ok (O.ident "value"))
            (malformed (O.ident "member"))));
    O.define "required"
      [ "read"; "member"; "fields" ]
      (O.match_ lookup
         [
           O.case (O.Pattern.construct "None") (fails "Lacks");
           O.case
             (O.Pattern.construct "Some" ~arg:(O.Pattern.var "value"))
             (O.call "read" [ O.ident "member"; O.ident "value" ]);
         ]);
    O.define "optional"
      [ "read"; "member"; "fields" ]
      (O.match_ lookup
         [
           O.case (O.Pattern.construct "None") (ok O.none);
           O.case
             (O.Pattern.construct "Some" ~arg:(O.Pattern.var "value"))
             (O.call "Result.map"
                [
                  O.ident "Option.some";
                  O.call "read" [ O.ident "member"; O.ident "value" ];
                ]);
         ]);
    O.define "extra" [ "names" ]
      (O.call "List.filter"
         [
           O.fun_
             [ O.Pattern.tuple [ O.Pattern.var "name"; O.Pattern.any ] ]
             (O.call "not"
                [ O.call "List.mem" [ O.ident "name"; O.ident "names" ] ]);
         ]);
    O.define "json_string" [ "value" ]
      (O.variant "String" ~arg:(O.ident "value"));
    O.define "json_integer" [ "value" ]
      (O.if_
         (O.call "Z.fits_int" [ O.ident "value" ])
         (O.variant "Int" ~arg:(O.call "Z.to_int" [ O.ident "value" ]))
         (O.variant "Intlit" ~arg:(O.call "Z.to_string" [ O.ident "value" ])));
  ]

let files (tag, variants) =
  let extra_type =
    O.type_ "list"
      ~args:[ O.type_tuple [ O.type_ "string"; O.type_ "Yojson.Safe.t" ] ]
  in
  let types =
    List.map
      (fun v ->
        O.type_declaration v.record
          (Record
             (List.map
                (fun f ->
                  ( f.label,
                    if f.optional then O.type_ "option" ~args:[ f.type_ ]
                    else f.type_ ))
                v.fields
             @ [ ("extra", extra_type) ])))
      variants
    @ [
        O.type_declaration "t"
          (Variant
             (List.map
                (fun v ->
                  O.constructor v.constructor ~args:[ O.type_ v.record ])
                variants));
        fault;
      ]
  in
  let names fields =
    O.list (List.map O.string (tag :: List.map (fun f -> f.name) fields))
  in
  let branch v =
    let reading =
      List.filter (fun f -> not f.optional) v.fields
      @ List.filter (fun f -> f.optional) v.fields
    in
    O.case
      (O.Pattern.string v.constructor)
      (List.fold_right
         (fun f body ->
           O.let_star (O.Pattern.var f.label)
             (O.call
                (if f.optional then "optional" else "required")
                [ f.reader; O.string f.name; O.ident "fields" ])
             body)
         reading
         (ok
            (O.construct v.constructor
               ~arg:
                 (O.record
                    (List.map (fun f -> (f.label, O.ident f.label)) v.fields
                    @ [
                        ( "extra",
                          O.call "extra" [ names v.fields; O.ident "fields" ] );
                      ])))))
  in
  let of_json =
    O.let_ "of_json"
      (O.function_
         [
           O.case
             (O.Pattern.variant "Assoc" ~arg:(O.Pattern.var "fields"))
             (O.let_star (O.Pattern.var "tag")
                (O.call "required"
                   [ O.ident "string"; O.string tag; O.ident "fields" ])
                (O.match_ (O.ident "tag")
                   (List.map branch variants
                   @ [ O.case O.Pattern.any (malformed (O.string tag)) ])));
           O.case O.Pattern.any (malformed (O.string ""));
         ])
  in
  let encode v =
    let value = O.ident "value" in
    let pair f field = O.tuple [ O.string f.name; O.call f.writer [ field ] ] in
    O.case
      (O.Pattern.construct v.constructor ~arg:(O.Pattern.var "value"))
      (O.variant "Assoc"
         ~arg:
           (O.infix "@"
              (O.call "List.filter_map"
                 [
                   O.ident "Fun.id";
                   O.list
                     (O.some
                        (O.tuple
                           [
                             O.string tag;
                             O.variant "String" ~arg:(O.string v.constructor);
                           ])
                     :: List.map
                          (fun f ->
                            if f.optional then
                              O.call "Option.map"
                                [
                                  O.fun_
                                    [ O.Pattern.var "field" ]
                                    (pair f (O.ident "field"));
                                  O.field value f.label;
                                ]
                            else O.some (pair f (O.field value f.label)))
                          v.fields);
                 ])
              (O.call "extra" [ names v.fields; O.field value "extra" ])))
  in
  let to_json = O.let_ "to_json" (O.function_ (List.map encode variants)) in
  let json = O.type_ "Yojson.Safe.t" in
  let banner =
    Banner.ocaml ~from_:"Selector.json and its component branches" __FILE__
  in
  [
    O.implementation ~path:"ocaml/sdk/lib/selector.ml" ~banner
      (List.map O.type_item types @ helpers @ [ of_json; to_json ]);
    O.interface ~path:"ocaml/sdk/lib/selector.mli" ~banner
      (List.map O.type_spec types
      @ [
          O.val_ "of_json"
            (O.arrow json
               (O.type_ "result" ~args:[ O.type_ "t"; O.type_ "fault" ]));
          O.val_ "to_json" (O.arrow (O.type_ "t") json);
        ]);
  ]
