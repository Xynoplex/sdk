(* The bus as the OCaml SDK holds it: every channel and operation, typed by
   its payload's component (ocaml/sdk/lib/bus_registry.ml); the client's
   namespace methods that are one channel or operation each, from
   client/surface.json (ocaml/sdk/lib/namespace_methods.ml); and the surface
   test's dispatch to them (ocaml/sdk/test/surface_dispatch.ml). A payload
   names a component the required table holds; an operation's request can be
   emitted; and no two channels are one OCaml name. *)

module R = Tables.Bus_registry
module S = Tables.Client_surface
module O = Ocaml_syntax

let surface_file = "client/surface.json"

(* The methods the SDK writes by hand: what each does is more than the one
   channel or operation it names. *)
let by_hand = [ "addEntityTypes"; "createFromToken"; "pollUntilComplete" ]
let name_of = String.map (function ':' | '-' -> '_' | c -> c)
let upper = String.capitalize_ascii
let some = function None -> O.none | Some v -> O.some (O.construct (upper v))

(* [f] applied to [args], with [~label:value] for each of [labeled] before
   the unit that ends it. *)
let labeled_call f labeled =
  Ast_helper.Exp.apply (O.ident f)
    (List.map (fun (label, value) -> (Asttypes.Labelled label, value)) labeled
    @ [ (Asttypes.Nolabel, O.unit) ])

type row = {
  channel : string;
  name : string;
  type_ : Parsetree.core_type;
  shape : Parsetree.expression;
  emittable : bool;
}

let files (spec : Spec.t) (bus : Bus.Registry.t) ~shapes =
  let reg = bus.registry in
  let refusals = ref [] in
  let refuse ?(file = Bus.Registry.file) pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  let known name = List.mem_assoc name shapes in
  let event =
    match
      List.assoc_opt "components/schemas/BusEventMessage.json" spec.schemas
    with
    | Some (Schema.Schema { properties = Some p; _ }) -> (
        match List.assoc_opt "event" p with
        | Some (Schema.Schema { enum = Some [ String_literal e ]; _ }) -> e
        | _ -> "")
    | _ -> ""
  in
  if event = "" then
    refuse ~file:"components/schemas/BusEventMessage.json"
      "/properties/event/enum" "is not one event name";
  let delivery = Bus.Registry.delivery_classes reg in
  let index name = O.tags [ name ] in
  let rows =
    List.mapi
      (fun i (c : R.channels_item) ->
        let at = Printf.sprintf "/channels/%d" i in
        let named schema =
          if not (known schema) then
            refuse at (Printf.sprintf "names %s, which no component is" schema)
        in
        let type_, shape =
          match c with
          | Schema { schema; _ } ->
              named schema;
              ( O.type_ "component" ~args:[ index schema ],
                O.construct "Component" ~arg:(O.string schema) )
          | Envelope { schema; _ } ->
              named schema;
              ( O.type_ "envelope" ~args:[ index schema ],
                O.construct "Envelope" ~arg:(O.string schema) )
          | Stored_event { enriched; payload; _ } ->
              let envelope =
                Bus.Registry.stored_event_component
                  ~enriched:(enriched = Some true)
              in
              named envelope;
              named payload;
              ( O.type_ "recorded"
                  ~args:[ O.type_tuple [ index envelope; index payload ] ],
                O.construct "Recorded"
                  ~arg:
                    (O.record
                       [
                         ("envelope", O.string envelope);
                         ("payload", O.string payload);
                       ]) )
          | Void _ -> (O.type_ "void", O.construct "Void")
          | Empty _ -> (O.type_ "empty", O.construct "Empty")
        in
        {
          channel = Bus.Registry.name c;
          name = name_of (Bus.Registry.name c);
          type_;
          shape;
          emittable = Option.is_some (Bus.Registry.validate_of c);
        })
      reg.channels
  in
  let names = List.map (fun r -> r.name) rows in
  if List.length (List.sort_uniq compare names) <> List.length names then
    refuse "/channels" "names two channels one OCaml name";
  let row channel = List.find (fun r -> r.channel = channel) rows in
  let operations =
    List.mapi
      (fun i (o : R.operations_item) ->
        if not (row o.request).emittable then
          refuse
            (Printf.sprintf "/operations/%d/request" i)
            (Printf.sprintf "is %s, which cannot be emitted" o.request);
        ( o,
          O.type_ "operation"
            ~args:
              (List.map
                 (fun c -> (row c).type_)
                 [ o.request; o.result; o.failure ]) ))
      reg.operations
  in
  let bridged =
    List.concat_map
      (fun (o : R.operations_item) -> [ o.result; o.failure ])
      reg.operations
    @ reg.audience.everyone
  in
  if List.length (List.sort_uniq compare bridged) <> List.length bridged then
    refuse "/audience/everyone" "names a channel a full client hears already";
  let audience channel =
    if List.mem channel reg.audience.declared then Some "declared"
    else if List.mem channel reg.audience.scoped then Some "scoped"
    else if List.mem channel reg.audience.everyone then Some "everyone"
    else None
  in
  let effect_ channel =
    if List.mem channel reg.effect_.writes then Some "writes"
    else if List.mem channel reg.effect_.reads then Some "reads"
    else None
  in
  let banner source = Banner.ocaml ~from_:source __FILE__ in
  let registry_banner =
    banner (Bus.Registry.file ^ " and its OpenAPI components")
  in
  let a = O.type_var "a" in
  let channel_of_a = O.type_ "channel" ~args:[ a ] in
  let triple = [ "request"; "result"; "failure" ] in
  let operation_of_triple =
    O.type_ "operation" ~args:(List.map O.type_var triple)
  in
  let string = O.type_ "string" in
  let option t = O.type_ "option" ~args:[ O.type_ t ] in
  let abstract ?params name = O.type_declaration ?params name Abstract in
  let types =
    [
      abstract ~params:[ "schema" ] "component";
      abstract ~params:[ "schema" ] "envelope";
      abstract ~params:[ "schemas" ] "recorded";
      abstract "empty";
      abstract "void";
      O.type_declaration "delivery"
        (Variant
           (List.map O.constructor [ "Positioned"; "Correlated"; "Passing" ]));
      O.type_declaration "audience"
        (Variant (List.map O.constructor [ "Everyone"; "Scoped"; "Declared" ]));
      O.type_declaration "operation_effect"
        (Variant (List.map O.constructor [ "Reads"; "Writes" ]));
      O.type_declaration "payload"
        (Variant
           [
             O.constructor "Component" ~args:[ string ];
             O.constructor "Envelope" ~args:[ string ];
             O.record_constructor "Recorded"
               [ ("envelope", string); ("payload", string) ];
             O.constructor "Empty";
             O.constructor "Void";
           ]);
    ]
  in
  let packed =
    [
      O.type_declaration "packed_channel"
        (Variant
           [
             O.constructor "Channel" ~args:[ channel_of_a ]
               ~result:(O.type_ "packed_channel");
           ]);
      O.type_declaration "packed_operation"
        (Variant
           [
             O.constructor "Operation" ~args:[ operation_of_triple ]
               ~result:(O.type_ "packed_operation");
           ]);
    ]
  in
  let decoded = O.type_ "decoded" ~args:[ a ] in
  let decode_type =
    O.arrow channel_of_a
      (O.arrow string
         (O.type_ "result" ~args:[ decoded; O.type_ "decode_error" ]))
  in
  let of_channel t = O.arrow channel_of_a t in
  let of_operation t = O.arrow operation_of_triple t in
  let api =
    List.map O.type_spec
      [
        abstract ~params:[ "a" ] "decoded";
        O.type_declaration "fault" Required.Ocaml.fault;
        O.type_declaration "decode_error" Required.Ocaml.decode_error;
      ]
    @ [
        O.val_ "encode" (O.arrow decoded string);
        O.val_ "json" (O.arrow decoded (O.type_ "Yojson.Raw.t"));
      ]
    @ List.map O.type_spec
        ([
           abstract ~params:[ "a" ] "channel";
           abstract ~params:triple "operation";
         ]
        @ packed)
    @ [
        O.val_ "decode" decode_type;
        O.val_ "decode_received" decode_type;
        O.val_ "name" (of_channel string);
        O.val_ "payload" (of_channel (O.type_ "payload"));
        O.val_ "delivery" (of_channel (option "delivery"));
        O.val_ "emittable" (of_channel (O.type_ "bool"));
        O.val_ "audience" (of_channel (option "audience"));
        O.val_ "in_process" (of_channel (O.type_ "bool"));
        O.val_ "operation_effect" (of_operation (option "operation_effect"));
      ]
    @ List.map
        (fun field ->
          O.val_ field
            (of_operation (O.type_ "channel" ~args:[ O.type_var field ])))
        triple
    @ [
        O.val_ "reply_names" (of_operation (O.type_ "list" ~args:[ string ]));
        O.val_ "trace_field" string;
        O.val_ "stream_event" string;
      ]
    @ [
        O.val_ "channels" (O.type_ "list" ~args:[ O.type_ "packed_channel" ]);
        O.val_ "operations"
          (O.type_ "list" ~args:[ O.type_ "packed_operation" ]);
        O.val_ "bridged_channels"
          (O.type_ "list" ~args:[ O.type_ "packed_channel" ]);
      ]
  in
  let payload_of channel = O.field (O.ident channel) "payload" in
  let reference name = O.call "reference" [ O.ident name ] in
  let channel_shape =
    O.define "channel_shape" [ "channel" ]
      (O.open_in "Schema_shape"
         (O.match_ (payload_of "channel")
            [
              O.case
                (O.Pattern.construct "Component" ~arg:(O.Pattern.var "name"))
                (reference "name");
              O.case
                (O.Pattern.construct "Recorded"
                   ~arg:
                     (O.Pattern.record
                        [
                          ("envelope", O.Pattern.var "envelope");
                          ("payload", O.Pattern.var "payload");
                        ]))
                (O.record ~with_:(O.ident "any")
                   [
                     ( "all_of",
                       O.list
                         [
                           reference "envelope";
                           labeled_call "object_"
                             [
                               ( "members",
                                 O.list
                                   [
                                     O.tuple
                                       [
                                         O.string "payload"; reference "payload";
                                       ];
                                   ] );
                             ];
                         ] );
                   ]);
              O.case
                (O.Pattern.construct "Envelope" ~arg:(O.Pattern.var "name"))
                (labeled_call "object_"
                   [
                     ("required", O.list [ O.string "response" ]);
                     ( "members",
                       O.list
                         [ O.tuple [ O.string "response"; reference "name" ] ]
                     );
                     ("closed", O.list [ O.string "response" ]);
                   ]);
              O.case
                (O.Pattern.or_
                   (O.Pattern.construct "Empty")
                   (O.Pattern.construct "Void"))
                (labeled_call "object_" [ ("closed", O.list []) ]);
            ]))
  in
  let impl =
    List.map O.type_item
      ([
         O.type_declaration "channel" ~params:[ "a" ]
           (Record
              [
                ("name", string);
                ("payload", O.type_ "payload");
                ("delivery", option "delivery");
                ("emittable", O.type_ "bool");
                ("audience", option "audience");
                ("in_process", O.type_ "bool");
              ]);
         O.type_declaration "operation" ~params:triple
           (Record
              (List.map
                 (fun field ->
                   (field, O.type_ "channel" ~args:[ O.type_var field ]))
                 triple
              @ [
                  ("reply_names", O.type_ "list" ~args:[ string ]);
                  ("operation_effect", option "operation_effect");
                ]));
         O.type_declaration "decoded" ~params:[ "a" ]
           ~manifest:(O.type_ "Yojson.Raw.t") Abstract;
         O.type_declaration "fault"
           ~manifest:(O.type_ "Schema_codec.fault")
           Required.Ocaml.fault;
         O.type_declaration "decode_error"
           ~manifest:(O.type_ "Schema_codec.error")
           Required.Ocaml.decode_error;
       ]
      @ packed)
    @ [
        O.define "json" [ "value" ] (O.ident "value");
        O.define "encode" [ "value" ]
          (O.call "Yojson.Raw.to_string" [ O.ident "value" ]);
        channel_shape;
        O.define "decode" [ "channel" ]
          (O.call "Schema_codec.decode"
             [ O.call "channel_shape" [ O.ident "channel" ] ]);
        O.define "decode_received" [ "channel" ]
          (O.let_in "shape"
             (O.match_ (payload_of "channel")
                [
                  O.case
                    (O.Pattern.construct "Recorded"
                       ~arg:
                         (O.Pattern.record ~open_:true
                            [ ("envelope", O.Pattern.var "envelope") ]))
                    (O.call "Schema_shape.reference" [ O.ident "envelope" ]);
                  O.case O.Pattern.any
                    (O.call "channel_shape" [ O.ident "channel" ]);
                ])
             (O.call "Schema_codec.decode_received"
                [ O.string bus.user_field; O.ident "shape" ]));
      ]
    @ List.map
        (fun f -> O.define f [ "value" ] (O.field (O.ident "value") f))
        [
          "name";
          "payload";
          "delivery";
          "emittable";
          "audience";
          "in_process";
          "operation_effect";
          "request";
          "result";
          "failure";
          "reply_names";
        ]
    @ [
        O.let_ "trace_field" (O.string reg.trace.field);
        O.let_ "stream_event" (O.string event);
      ]
  in
  let delivery_of channel =
    match Hashtbl.find_opt delivery channel with
    | None -> O.none
    | Some Bus.Registry.Positioned -> O.some (O.construct "Positioned")
    | Some Correlated -> O.some (O.construct "Correlated")
    | Some Passing -> O.some (O.construct "Passing")
  in
  let channels =
    List.map
      (fun r ->
        O.let_ r.name
          (O.record
             [
               ("name", O.string r.channel);
               ("payload", r.shape);
               ("delivery", delivery_of r.channel);
               ("emittable", O.bool r.emittable);
               ("audience", some (audience r.channel));
               ( "in_process",
                 O.bool (List.mem r.channel reg.in_process.channels) );
             ]))
      rows
  in
  let operation_values =
    List.map
      (fun ((o : R.operations_item), _) ->
        let channel c = O.ident ("Channels." ^ name_of c) in
        O.let_ (name_of o.request)
          (O.record
             [
               ("request", channel o.request);
               ("result", channel o.result);
               ("failure", channel o.failure);
               ( "reply_names",
                 O.list
                   (List.map O.string (List.assoc o.request bus.reply_names)) );
               ("operation_effect", some (effect_ o.request));
             ]))
      operations
  in
  let packed constructor names =
    O.list (List.map (fun n -> O.construct constructor ~arg:(O.ident n)) names)
  in
  let registry_ml =
    List.map O.type_item types @ impl
    @ [
        O.module_ "Channels" channels;
        O.module_ "Operations" operation_values;
        O.let_ "channels"
          (packed "Channel" (List.map (fun r -> "Channels." ^ r.name) rows));
        O.let_ "operations"
          (packed "Operation"
             (List.map
                (fun ((o : R.operations_item), _) ->
                  "Operations." ^ name_of o.request)
                operations));
        O.let_ "bridged_channels"
          (packed "Channel"
             (List.map (fun c -> "Channels." ^ name_of c) bridged));
      ]
  in
  let registry_mli =
    List.map O.type_spec types @ api
    @ [
        O.module_spec "Channels"
          (List.map
             (fun r -> O.val_ r.name (O.type_ "channel" ~args:[ r.type_ ]))
             rows);
        O.module_spec "Operations"
          (List.map
             (fun ((o : R.operations_item), t) -> O.val_ (name_of o.request) t)
             operations);
      ]
  in
  (* Each method a channel or an operation is, by its namespace. *)
  let surface = spec.tables.client_surface in
  (* The channels a method names: the request it asks, the local channel it
     publishes, the channel it emits. *)
  let via_channels (m : S.methods_item) =
    match m.via with
    | Request { request } -> (Some request, None, None)
    | Local { local } -> (None, Some local, None)
    | Emit { emit } -> (None, None, Some emit)
    | Content _ | Gateway _ | Observes _ -> (None, None, None)
  in
  let correlated (m : S.methods_item) =
    List.exists
      (fun (c : S.cases_item) -> Option.is_some c.correlation_id)
      m.cases
  in
  let operation_of request =
    List.find_opt
      (fun ((o : R.operations_item), _) -> o.request = request)
      operations
  in
  let channel_of at kind channel =
    match List.find_opt (fun r -> r.channel = channel) rows with
    | Some r -> r.name
    | None ->
        refuse ~file:surface_file at
          (Printf.sprintf "names %s, which is no %s channel" channel kind);
        ""
  in
  let optional label = (Asttypes.Optional label, O.ident label) in
  let plain value = (Asttypes.Nolabel, value) in
  let wired =
    List.filter_map
      (fun ((n, ns) : int * S.namespaces_item) ->
        let functions =
          List.concat
            (List.mapi
               (fun i (m : S.methods_item) ->
                 let at = Printf.sprintf "/namespaces/%d/methods/%d/via" n i in
                 let name = Text.snake m.method_ in
                 let correlation =
                   if correlated m then [ "correlation_id" ] else []
                 in
                 let method_ options body =
                   O.let_ name
                     (O.fun_labeled
                        ((Asttypes.Nolabel, O.Pattern.var "client")
                         :: List.map
                              (fun o -> (Asttypes.Optional o, O.Pattern.var o))
                              options
                        @ [ (Asttypes.Nolabel, O.Pattern.var "payload") ])
                        body)
                 in
                 let client_core how options channel =
                   Ast_helper.Exp.apply
                     (O.ident ("Client_core." ^ how))
                     ((plain (O.ident "client") :: List.map optional options)
                     @ [ plain (O.ident channel); plain (O.ident "payload") ])
                 in
                 match via_channels m with
                 | Some request, _, _
                   when m.shape = S.Promise && not (List.mem m.method_ by_hand)
                   -> (
                     match operation_of request with
                     | Some (o, _) ->
                         [
                           method_ []
                             (client_core "ask" []
                                ("Bus_registry.Operations." ^ name_of o.request));
                         ]
                     | None ->
                         refuse ~file:surface_file (at ^ "/request")
                           (Printf.sprintf "names %s, which no operation asks"
                              request);
                         [])
                 | _, Some local, _ when m.shape = S.Signal ->
                     let c = channel_of (at ^ "/local") "local" local in
                     [
                       method_ correlation
                         (client_core "publish" correlation
                            ("Bus_registry.Channels." ^ c));
                     ]
                 | _, _, Some emit ->
                     let c = channel_of (at ^ "/emit") "emitted" emit in
                     let how =
                       if m.shape = S.Count then "drive" else "signal"
                     in
                     [
                       method_ [ "scope" ]
                         (client_core how [ "scope" ]
                            ("Bus_registry.Channels." ^ c));
                     ]
                 | _ -> [])
               ns.methods)
        in
        if functions = [] then None
        else Some (O.module_ (upper ns.namespace) functions))
      (List.mapi (fun n ns -> (n, ns)) surface.namespaces)
  in
  let behavior =
    List.concat_map
      (fun (ns : S.namespaces_item) ->
        List.filter_map
          (fun (m : S.methods_item) ->
            (* A promise that asks, or any method that emits or publishes,
               dispatches to the first channel it names. *)
            let request, local, emit = via_channels m in
            let target =
              if
                (Option.is_some request && m.shape = S.Promise)
                || Option.is_some emit || Option.is_some local
              then List.find_map Fun.id [ request; emit; local ]
              else None
            in
            match target with
            | Some channel when not (List.mem m.method_ by_hand) ->
                Some
                  (O.case
                     (O.Pattern.string (ns.namespace ^ "." ^ m.method_))
                     (O.sequence
                        [
                          O.call "ignore"
                            [
                              Ast_helper.Exp.apply
                                (O.ident
                                   ("C." ^ upper ns.namespace ^ "."
                                  ^ Text.snake m.method_))
                                (plain (O.ident "client")
                                 ::
                                 (if correlated m then
                                    [ optional "correlation_id" ]
                                  else [])
                                @ [
                                    plain
                                      (O.call "decode"
                                         [
                                           O.ident
                                             ("B.Channels." ^ name_of channel);
                                           O.ident "payload";
                                         ]);
                                  ]);
                            ];
                          O.bool true;
                        ]))
            | _ -> None)
          ns.methods)
      surface.namespaces
  in
  let dispatch =
    [
      O.module_alias "B" "Xynolog.Bus_registry";
      O.module_alias "C" "Xynolog.Client";
      O.define "decode" [ "channel"; "payload" ]
        (O.match_
           (O.call "B.decode"
              [
                O.ident "channel";
                O.call "Yojson.Safe.to_string" [ O.ident "payload" ];
              ])
           [
             O.case
               (O.Pattern.construct "Ok" ~arg:(O.Pattern.var "decoded"))
               (O.ident "decoded");
             O.case
               (O.Pattern.construct "Error" ~arg:O.Pattern.any)
               (O.call "failwith"
                  [
                    O.infix "^"
                      (O.string "invalid test payload for ")
                      (O.call "B.name" [ O.ident "channel" ]);
                  ]);
           ]);
      O.let_ "invoke"
        (O.fun_labeled
           [
             (Asttypes.Nolabel, O.Pattern.var "client");
             (Asttypes.Labelled "correlation_id", O.Pattern.var "correlation_id");
             (Asttypes.Nolabel, O.Pattern.var "name");
             (Asttypes.Nolabel, O.Pattern.var "payload");
           ]
           (O.match_ (O.ident "name")
              (behavior @ [ O.case O.Pattern.any (O.bool false) ])));
    ]
  in
  match List.rev !refusals with
  | [] ->
      Ok
        [
          O.implementation ~path:"ocaml/sdk/lib/bus_registry.ml"
            ~banner:registry_banner registry_ml;
          O.interface ~path:"ocaml/sdk/lib/bus_registry.mli"
            ~banner:registry_banner registry_mli;
          O.implementation ~path:"ocaml/sdk/lib/namespace_methods.ml"
            ~banner:
              (banner
                 ("protocol/specs/src/" ^ surface_file
                ^ " and protocol/specs/src/" ^ Bus.Registry.file))
            wired;
          O.implementation ~path:"ocaml/sdk/test/surface_dispatch.ml"
            ~banner:(banner ("protocol/specs/src/" ^ surface_file))
            dispatch;
        ]
  | errors -> Error errors
