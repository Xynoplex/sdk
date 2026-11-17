(* The kinds of id as the OCaml SDK holds them (ocaml/sdk/lib/identifiers.ml):
   a module per kind whose of_string asks the kind's pattern, compiled to the
   steps its required shape states, and a test of each case kinds.json
   accepts or refuses. A kind's required shape is a string and its pattern,
   and nothing else, or the module would not hold all its schema says. *)

let string = Text.ocaml_quoted

let header =
  Banner.ocaml
    ~from_:
      "protocol/specs/src/identifiers/kinds.json and the kinds' required shapes"
    __FILE__

let files (spec : Spec.t) (shapes : (string * Required.Shape.shape) list) =
  let kinds = spec.tables.identifiers_kinds.kinds in
  let refusals = ref [] in
  let modules =
    List.mapi
      (fun i (k : Tables.Identifiers_kinds.kind) ->
        let steps =
          match List.assoc_opt k.schema shapes with
          | Some
              (Shape
                 {
                   kinds = Some [ String ];
                   pattern = Some steps;
                   recognized = None;
                   enum = None;
                   min_length = None;
                   max_length = None;
                   minimum = None;
                   maximum = None;
                   min_items = None;
                   max_items = None;
                   required = None;
                   members = [];
                   closed = None;
                   items = None;
                   values = None;
                   one_of = [];
                   discriminator = None;
                   all_of = [];
                 }) ->
              steps
          | _ ->
              refusals :=
                {
                  Decode.file = "identifiers/kinds.json";
                  pointer = Printf.sprintf "/kinds/%d/schema" i;
                  message =
                    Printf.sprintf
                      "is %s, whose required shape is not a string and its \
                       pattern alone"
                      k.schema;
                }
                :: !refusals;
              []
        in
        (k, String.capitalize_ascii (Text.snake k.schema), steps))
      kinds
  in
  let step (s : Required.Shape.step) =
    Printf.sprintf "([%s], %d, %s)"
      (String.concat "; "
         (List.map (fun (a, b) -> Printf.sprintf "(%d, %d)" a b) s.of_))
      s.min
      (match s.max with None -> "None" | Some m -> Printf.sprintf "Some %d" m)
  in
  let implementation ((k : Tables.Identifiers_kinds.kind), name, steps) =
    Printf.sprintf
      "module %s = struct\n\
      \  type t = string\n\
      \  let of_string value =\n\
      \    if Pattern.matches [%s] value then Ok value\n\
      \    else Error %s\n\
      \  let to_string value = value\n\
      \  let compare = String.compare\n\
      \  let equal = String.equal\n\
       end\n"
      name
      (String.concat "; " (List.map step steps))
      (string ("Invalid " ^ k.schema))
  in
  let signature (_, name, _) =
    Printf.sprintf
      "module %s : sig\n\
      \  type t\n\
      \  val of_string : string -> (t, string) result\n\
      \  val to_string : t -> string\n\
      \  val compare : t -> t -> int\n\
      \  val equal : t -> t -> bool\n\
       end\n"
      name
  in
  let tests ((k : Tables.Identifiers_kinds.kind), name, _) =
    let case accepted (id, why) =
      Printf.sprintf
        "  Alcotest.(check bool) %s %b\n\
        \    (Result.is_ok (Xynolog.Identifiers.%s.of_string %s));"
        (string (k.schema ^ ": " ^ why))
        accepted name (string id)
    in
    List.map (case true)
      (List.map
         (fun (a : Tables.Identifiers_kinds.accept) -> (a.id, a.why))
         k.accepts)
    @ List.map (case false)
        (List.map
           (fun (r : Tables.Identifiers_kinds.refuse) -> (r.id, r.why))
           k.refuses)
  in
  match !refusals with
  | [] ->
      Ok
        [
          {
            Output.path = "ocaml/sdk/lib/identifiers.ml";
            text = header ^ String.concat "\n" (List.map implementation modules);
          };
          {
            Output.path = "ocaml/sdk/lib/identifiers.mli";
            text = header ^ String.concat "\n" (List.map signature modules);
          };
          {
            Output.path = "ocaml/sdk/test/identifiers.ml";
            text =
              header ^ "let () =\n"
              ^ String.concat "\n" (List.concat_map tests modules)
              ^ "\n  ()\n";
          };
        ]
  | errors -> Error (List.rev errors)
