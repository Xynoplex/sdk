(* The vocabularies as the Go SDK reads them (go/errors.go): a named type per
   vocabulary with a constant per code, the bus code a wire code becomes, and
   the transport code an HTTP status becomes. A wire code's constant,
   api.CommandErrorCode and the code in Pascal case, is the name oapi-codegen
   gives it in package api, and the Go build is what holds the two together. *)

let path = "go/errorcodes_gen.go"
let wire_constant wire = "api.CommandErrorCode" ^ Table.pascal wire

(* A vocabulary: its type, and a constant per code in the table's order, each
   under its comment, as gofmt leaves it. *)
let vocabulary (v : Table.vocabulary) =
  String.concat ""
    [
      Text.go_comment ~indent:"" v.docs;
      Printf.sprintf "\ntype %s string\n\nconst (\n" v.go_name;
      String.concat ""
        (List.map
           (fun (c : Table.code) ->
             Printf.sprintf "%s\n\t%s %s = %s\n"
               (Text.go_comment ~indent:"\t" c.docs)
               c.go v.go_name (Text.quoted c.code))
           v.codes);
      ")\n";
    ]

let cases pairs =
  String.concat ""
    (List.map
       (fun (case, result) ->
         Printf.sprintf "\tcase %s:\n\t\treturn %s\n" case result)
       pairs)

let text (t : Table.t) =
  String.concat ""
    [
      "// Code generated from protocol/specs/src/errors/codes.json; DO NOT EDIT.\n\
       //\n\
       // Regenerate: make generate (codegen/lib/error_codes/go.ml)\n\
       // The TypeScript and Python vocabularies are generated from the same \
       table,\n\
       // and Rust's by its SDK's build script.\n\n\
       package xynolog\n\n\
       import \"github.com/xynolog/sdk/go/api\"\n\n";
      vocabulary t.bus;
      "\n";
      Text.go_comment ~indent:""
        (Printf.sprintf
           "%sOfWire is the code a failure's own code (CommandError.code) \
            becomes, a case for each of CommandErrorCode's codes. A failure \
            that states none is %s. A reader leaves a code the required table \
            does not recognize out of the failure before it decodes it, so a \
            code CommandErrorCode does not name is none a failure is read \
            with: given one, it panics."
           t.bus.go_name t.unrecognized.go);
      Printf.sprintf
        "\n\
         func %sOfWire(code *api.CommandErrorCode) %s {\n\
         \tif code == nil {\n\
         \t\treturn %s\n\
         \t}\n\
         \tswitch *code {\n"
        t.bus.go_name t.bus.go_name t.unrecognized.go;
      cases
        (List.map
           (fun (wire, (c : Table.code)) -> (wire_constant wire, c.go))
           t.wire);
      "\tdefault:\n\
       \t\tpanic(\"a failure's code \\\"\" + string(*code) + \"\\\" is none of \
       CommandErrorCode's: the required table recognizes a code CommandError \
       does not list\")\n\
       \t}\n\
       }\n\n";
      Text.go_comment ~indent:""
        "Wire is the wire code a peer stated, when this code restates one: \
         what a service answers its own caller with. A failure only this side \
         knows states none, and ok is false.";
      Printf.sprintf
        "\n\
         func (c %s) Wire() (code api.CommandErrorCode, ok bool) {\n\
         \tswitch c {\n"
        t.bus.go_name;
      cases
        (List.map
           (fun (wire, (c : Table.code)) ->
             (c.go, wire_constant wire ^ ", true"))
           t.wire);
      "\tdefault:\n\t\treturn \"\", false\n\t}\n}\n\n";
      vocabulary t.transport;
      "\n";
      Text.go_comment ~indent:""
        (Printf.sprintf "%sOfStatus is the code an HTTP status becomes."
           t.transport.go_name);
      Printf.sprintf "\nfunc %sOfStatus(status int) %s {\n\tswitch {\n"
        t.transport.go_name t.transport.go_name;
      cases
        (List.map
           (fun (status, (c : Table.code)) ->
             (Printf.sprintf "status == %d" status, c.go))
           t.exact
        @ List.map
            (fun (status, (c : Table.code)) ->
              (Printf.sprintf "status >= %d" status, c.go))
            (Option.to_list t.from));
      Printf.sprintf "\tdefault:\n\t\treturn %s\n\t}\n}\n\n" t.unclassified.go;
      String.concat "\n" (List.map vocabulary t.others);
    ]

let file t = { Output.path; text = text t }
