(* The names a credential goes by, whose values every SDK's bus log withholds
   (bus/log-cases.json's names), as each SDK that lists them reads them:
   each named once, and at least one. *)

let file = "bus/log-cases.json"
let from_ = "protocol/specs/src/" ^ file

let about =
  "The names a credential goes by: a bus log line shows `[withheld]` for the \
   value of a member under any of them."

let names (log : Tables.Bus_log_cases.t) =
  if
    log.names = []
    || List.length (List.sort_uniq String.compare log.names)
       <> List.length log.names
  then
    Error
      [
        {
          Decode.file;
          pointer = "/names";
          message = "names no credential, or one twice";
        };
      ]
  else Ok log.names

let go names =
  let module G = Go_syntax in
  {
    Output.path = "go/buslogcredentials_gen.go";
    text =
      G.text
        {
          header =
            G.verbatim
              ("Code generated from " ^ from_
             ^ " — DO NOT EDIT.\n\nRegenerate: make generate ("
             ^ Banner.writer __FILE__ ^ ")");
          package = "xynolog";
          imports = [];
          decls =
            [
              G.Var
                (G.spec
                   ~doc:(G.prose ("credentials: " ^ about))
                   "credentials"
                   (G.lines
                      ~of_:(G.Map (G.Named "string", G.Named "bool"))
                      (List.map
                         (fun n -> G.element ~key:(G.Quoted n) (G.Name "true"))
                         names)));
            ];
        };
  }

let python names =
  let module P = Python_syntax in
  {
    Output.path = "python/sdk/src/xynolog/_bus_log_credentials.py";
    text =
      P.text
        {
          header = Banner.python_lines ~from_ __FILE__;
          doc =
            As_is "The names a credential goes by, which the bus log withholds.";
          imports = [ [ P.From ("typing", [ "Final" ]) ] ];
          body =
            [
              P.assign "__all__"
                ~value:(P.List (P.items [ P.item (P.Str "CREDENTIALS") ]));
              P.assign ~annotation:(P.Name "Final")
                ~value:
                  (P.call "frozenset"
                     [
                       P.item
                         (P.Set
                            (P.items
                               (List.map (fun n -> P.item (P.Str n)) names)));
                     ])
                ~doc:(As_is about) "CREDENTIALS";
            ];
        };
  }

let rust names =
  let module R = Rust_syntax in
  {
    Output.path = "rust/sdk/src/generated/bus_log_credentials.rs";
    text =
      R.text
        ~header:(Banner.lines ~from_ __FILE__)
        [
          R.Const
            {
              doc = [ about ];
              attrs = [];
              vis = Private;
              name = "CREDENTIALS";
              ty = R.Array_of (R.str_ty, List.length names);
              value = R.Array (List.map (fun n -> R.Str n) names);
            };
        ];
  }

let typescript names =
  let module T = Typescript_syntax in
  {
    Output.path = "typescript/core/src/bus-log-credentials.ts";
    text =
      T.text
        {
          banner = Banner.typescript_lines ~authority:[ from_ ] __FILE__;
          body =
            [
              T.const "CREDENTIALS" ~about:[ Doc about ]
                ~annotation:(T_generic ("ReadonlySet", [ T_name "string" ]))
                (T.New ("Set", [ T.array (List.map (fun n -> T.Str n) names) ]));
            ];
        };
  }

let kotlin names =
  let module K = Kotlin_syntax in
  Kotlin_sdk.table ~from_:file __FILE__ ~package:"xynolog.bus"
    ~name:"Credentials" ~imports:[]
    [
      K.property ~about:(K.Doc about) ~visibility:K.Internal
        ~type_:(K.Generic ("Set", [ K.Type "String" ]))
        ~value:
          (K.Same_line
             (K.call (K.Name "setOf") (List.map (fun s -> K.Str s) names)))
        "CREDENTIAL_NAMES";
    ]

let files log =
  Result.map
    (fun names ->
      [ go names; python names; rust names; typescript names; kotlin names ])
    (names log)
