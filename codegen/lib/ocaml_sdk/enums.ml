(* Every component that is a string enum (protocol/specs/src/components/
   schemas), as a module of the OCaml SDK (ocaml/sdk/lib/enums.ml): a variant
   per member, and its name both ways. A member is a letter and then letters,
   digits and . / + -, so it names a constructor; no two name the same one. *)

let source = "protocol/specs/src/components/schemas"
let prefix = "components/schemas/"
let string = Text.ocaml_quoted

type enum = { module_ : string; variants : (string * string) list }
(** Each variant: its constructor, and its member as an OCaml literal. *)

let is_member value =
  value <> ""
  && (match value.[0] with 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false)
  && String.for_all
       (function
         | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '.' | '/' | '+' | '-' -> true
         | _ -> false)
       value

let constructor value =
  String.capitalize_ascii
    (String.map
       (function '.' | '/' | '-' -> '_' | c -> c)
       (Text.replace_all ~sub:"+" ~by:"_plus" value))

let derive (spec : Spec.t) =
  let refusals = ref [] in
  let enums =
    List.filter_map
      (fun (file, schema) ->
        match schema with
        | Schema.Schema { type_ = Some [ String ]; enum = Some members; _ }
          when String.starts_with ~prefix file
               && not
                    (String.contains
                       (String.sub file (String.length prefix)
                          (String.length file - String.length prefix))
                       '/') ->
            let stem =
              Filename.remove_extension
                (String.sub file (String.length prefix)
                   (String.length file - String.length prefix))
            in
            let refuse pointer message =
              refusals := { Decode.file; pointer; message } :: !refusals
            in
            let variants =
              List.concat
                (List.mapi
                   (fun i (member : Schema.literal) ->
                     match member with
                     | String_literal value when is_member value ->
                         [ (constructor value, string value) ]
                     | _ ->
                         refuse
                           (Printf.sprintf "/enum/%d" i)
                           "is no member an OCaml constructor can name";
                         [])
                   members)
            in
            let constructors = List.map fst variants in
            if
              variants = []
              || List.length (List.sort_uniq compare constructors)
                 <> List.length constructors
            then refuse "/enum" "is empty, or two members name one constructor";
            Some
              { module_ = String.capitalize_ascii (Text.snake stem); variants }
        | _ -> None)
      (List.sort (fun (a, _) (b, _) -> compare a b) spec.schemas)
  in
  match List.rev !refusals with [] -> Ok enums | errors -> Error errors

let files enums =
  let header =
    Banner.ocaml ~from_:("string enums in " ^ source) __FILE__ ^ "\n"
  in
  let type_ e = "type t = " ^ String.concat " | " (List.map fst e.variants) in
  let impl e =
    String.concat "\n"
      ([
         "module " ^ e.module_ ^ " = struct";
         "  " ^ type_ e;
         "  let to_string = function";
       ]
      @ List.map (fun (c, l) -> "    | " ^ c ^ " -> " ^ l) e.variants
      @ [ "  let of_string = function" ]
      @ List.map (fun (c, l) -> "    | " ^ l ^ " -> Some " ^ c) e.variants
      @ [ "    | _ -> None"; "end" ])
  in
  let api e =
    String.concat "\n"
      [
        "module " ^ e.module_ ^ " : sig";
        "  " ^ type_ e;
        "  val to_string : t -> string";
        "  val of_string : string -> t option";
        "end";
      ]
  in
  let test e =
    String.concat "\n"
      (("  let module Model = Xynolog.Enums." ^ e.module_ ^ " in")
       :: List.concat_map
            (fun (c, l) ->
              [
                Printf.sprintf
                  "  Alcotest.(check string) \"%s encode\" %s (Model.to_string \
                   Model.%s);"
                  e.module_ l c;
                Printf.sprintf
                  "  Alcotest.(check bool) \"%s decode\" true (Model.of_string \
                   %s = Some Model.%s);"
                  e.module_ l c;
              ])
            e.variants
      @ [
          Printf.sprintf
            "  Alcotest.(check bool) \"%s rejects unknown values\" true \
             (Model.of_string \"\" = None);"
            e.module_;
        ])
  in
  let file path contents = { Output.path; text = header ^ contents ^ "\n" } in
  [
    file "ocaml/sdk/lib/enums.ml" (String.concat "\n\n" (List.map impl enums));
    file "ocaml/sdk/lib/enums.mli" (String.concat "\n\n" (List.map api enums));
    file "ocaml/sdk/test/enums_cases.ml"
      ("let () =\n" ^ String.concat "\n" (List.map test enums) ^ "\n  ()");
  ]
