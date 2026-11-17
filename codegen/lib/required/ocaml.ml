(* What each component requires, as the OCaml SDK holds it: each shape built
   as a Schema_shape value (ocaml/sdk/lib/schema_shapes.ml), with its keywords
   in the order the table states them, and a descriptor per component
   (ocaml/sdk/lib/models.ml). *)

let string = Text.ocaml_quoted
let list write values = "[" ^ String.concat "; " (List.map write values) ^ "]"
let option write = function None -> "None" | Some v -> "Some (" ^ write v ^ ")"

(* A number as JavaScript's String writes one. *)
let number value =
  if Float.is_integer value then Printf.sprintf "%.0f" value
  else
    List.find
      (fun s -> float_of_string s = value)
      (List.map (fun digits -> Printf.sprintf "%.*g" digits value) [ 15; 16; 17 ])

let literal : Schema.literal -> string = function
  | String_literal s -> "`Stringlit " ^ string (Text.quoted s)
  | Int_literal n -> "`Intlit " ^ string (string_of_int n)
  | Bool_literal b -> "`Bool " ^ string_of_bool b

let rec shape : Shape.shape -> string = function
  | Ref name -> "{ any with reference = Some (" ^ string name ^ ") }"
  | Shape b ->
      let part name write = Option.map (fun v -> name ^ " = " ^ write v) in
      let some write v = "Some (" ^ write v ^ ")" in
      let nonempty name write = function
        | [] -> None
        | items -> Some (name ^ " = " ^ write items)
      in
      let updates =
        List.filter_map Fun.id
          [
            part "kinds"
              (some (list (fun k -> String.capitalize_ascii (Shape.kind_name k))))
              b.kinds;
            part "recognized" (some (list string)) b.recognized;
            part "enum" (some (list literal)) b.enum;
            part "pattern"
              (some
                 (list (fun (step : Shape.step) ->
                      Printf.sprintf "(%s, %d, %s)"
                        (list (fun (lo, hi) -> Printf.sprintf "(%d, %d)" lo hi)
                           step.of_)
                        step.min
                        (option string_of_int step.max))))
              b.pattern;
            part "min_length" (some string_of_int) b.min_length;
            part "max_length" (some string_of_int) b.max_length;
            part "minimum" (some (fun n -> string (number n))) b.minimum;
            part "maximum" (some (fun n -> string (number n))) b.maximum;
            part "min_items" (some string_of_int) b.min_items;
            part "max_items" (some string_of_int) b.max_items;
            part "required" (list string) b.required;
            nonempty "members"
              (list (fun (name, s) -> "(" ^ string name ^ ", " ^ shape s ^ ")"))
              b.members;
            part "closed" (some (list string)) b.closed;
            part "items" (some shape) b.items;
            part "values" (some shape) b.values;
            nonempty "variants" (list shape) b.one_of;
            part "discriminator"
              (some (fun (d : Shape.discriminator) ->
                   "(" ^ string d.property ^ ", "
                   ^ list
                       (fun (v, i) ->
                         "(" ^ string v ^ ", " ^ string_of_int i ^ ")")
                       d.mapping
                   ^ ")"))
              b.discriminator;
            nonempty "all_of" (list shape) b.all_of;
          ]
      in
      if updates = [] then "any"
      else "{ any with " ^ String.concat "; " updates ^ " }"

let header =
  Banner.ocaml
    ~from_:"OpenAPI component schemas through codegen/lib/required/shape.ml"
    __FILE__
  ^ "\n"

let files shapes =
  let names = List.map fst shapes in
  (* Each shape is built by a function of its own: built in the module's
     initializer, the table is more than the native compiler can allocate
     registers for. *)
  let definitions =
    List.mapi (fun i (_, s) -> Printf.sprintf "let shape_%d () = %s" i (shape s))
      shapes
  in
  let entries =
    List.mapi (fun i name -> Printf.sprintf "  (%s, shape_%d);" (string name) i)
      names
  in
  let value_name = Text.snake in
  let api =
    [
      "type 'schema t";
      "type 'schema descriptor";
      "type fault = { member : string; reason : [ `Lacks | `Malformed ] }";
      "type decode_error = Invalid_json of string | Invalid_payload of fault";
      "val decode : 'schema descriptor -> string -> ('schema t, decode_error) \
       result";
      "val encode : 'schema t -> string";
      "val json : 'schema t -> Yojson.Raw.t";
    ]
    @ List.map
        (fun name -> "val " ^ value_name name ^ " : [ `" ^ name ^ " ] descriptor")
        names
  in
  let impl =
    [
      "type 'schema t = Yojson.Raw.t";
      "type 'schema descriptor = string";
      "type fault = Schema_codec.fault = { member : string; reason : [ `Lacks \
       | `Malformed ] }";
      "type decode_error = Schema_codec.error = Invalid_json of string | \
       Invalid_payload of fault";
      "let decode name = Schema_codec.decode (Schema_shape.reference name)";
      "let encode value = Yojson.Raw.to_string value";
      "let json value = value";
    ]
    @ List.map (fun name -> "let " ^ value_name name ^ " = " ^ string name) names
  in
  [
    {
      Output.path = "ocaml/sdk/lib/schema_shapes.ml";
      text =
        header ^ "open Schema_shape\n\n"
        ^ String.concat "\n" definitions
        ^ "\n\nlet all = [\n" ^ String.concat "\n" entries ^ "\n]\n";
    };
    {
      Output.path = "ocaml/sdk/lib/models.mli";
      text = header ^ String.concat "\n" api ^ "\n";
    };
    {
      Output.path = "ocaml/sdk/lib/models.ml";
      text = header ^ String.concat "\n" impl ^ "\n";
    };
  ]
