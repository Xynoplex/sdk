(* The bus as the OCaml SDK holds it: every channel and operation, typed by
   its payload's component (ocaml/sdk/lib/bus_registry.ml); the client's
   namespace methods that are one channel or operation each, from
   client/surface.json (ocaml/sdk/lib/namespace_methods.ml); and the surface
   test's dispatch to them (ocaml/sdk/test/surface_dispatch.ml). A payload
   names a component the required table holds; an operation's request can be
   emitted; and no two channels are one OCaml name. *)

module R = Tables.Bus_registry
module S = Tables.Client_surface

let string = Text.ocaml_quoted
let surface_file = "client/surface.json"

(* The methods the SDK writes by hand: what each does is more than the one
   channel or operation it names. *)
let by_hand = [ "addEntityTypes"; "createFromToken"; "pollUntilComplete" ]
let name_of = String.map (function ':' | '-' -> '_' | c -> c)
let upper = String.capitalize_ascii
let some = function None -> "None" | Some v -> "Some " ^ upper v

type row = {
  channel : string;
  name : string;
  type_ : string;
  shape : string;
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
  let index name = "[ `" ^ name ^ " ]" in
  let rows =
    List.mapi
      (fun i (c : R.channel) ->
        let at = Printf.sprintf "/channels/%d" i in
        let named schema =
          if not (known schema) then
            refuse at (Printf.sprintf "names %s, which no component is" schema)
        in
        let type_, shape =
          match c.payload with
          | Schema { schema; _ } ->
              named schema;
              (index schema ^ " component", "Component " ^ string schema)
          | Envelope { schema } ->
              named schema;
              (index schema ^ " envelope", "Envelope " ^ string schema)
          | Stored_event { enriched; payload; _ } ->
              let envelope = Bus.Registry.stored_event_component ~enriched in
              named envelope;
              named payload;
              ( "(" ^ index envelope ^ " * " ^ index payload ^ ") recorded",
                "Recorded { envelope = " ^ string envelope ^ "; payload = "
                ^ string payload ^ " }" )
          | Void -> ("void", "Void")
          | Empty -> ("empty", "Empty")
        in
        {
          channel = c.channel;
          name = name_of c.channel;
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
      (fun i (o : R.operation) ->
        if not (row o.request).emittable then
          refuse
            (Printf.sprintf "/operations/%d/request" i)
            (Printf.sprintf "is %s, which cannot be emitted" o.request);
        ( o,
          "("
          ^ String.concat ", "
              (List.map
                 (fun c -> (row c).type_)
                 [ o.request; o.result; o.failure ])
          ^ ") operation" ))
      reg.operations
  in
  let bridged =
    List.concat_map
      (fun (o : R.operation) -> [ o.result; o.failure ])
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
  let header source = Banner.ocaml ~from_:source __FILE__ ^ "\n" in
  let registry_header =
    header (Bus.Registry.file ^ " and its OpenAPI components")
  in
  let types =
    [
      "type 'schema component";
      "type 'schema envelope";
      "type 'schemas recorded";
      "type empty";
      "type void";
      "type delivery = Positioned | Correlated | Passing";
      "type audience = Everyone | Scoped | Declared";
      "type operation_effect = Reads | Writes";
      "type payload = Component of string | Envelope of string | Recorded of { \
       envelope : string; payload : string } | Empty | Void";
    ]
  in
  let api =
    [
      "type 'a decoded";
      "type fault = { member : string; reason : [ `Lacks | `Malformed ] }";
      "type decode_error = Invalid_json of string | Invalid_payload of fault";
      "val encode : 'a decoded -> string";
      "val json : 'a decoded -> Yojson.Raw.t";
      "type 'a channel";
      "type ('request, 'result, 'failure) operation";
      "type packed_channel = Channel : 'a channel -> packed_channel";
      "type packed_operation = Operation : ('request, 'result, 'failure) \
       operation -> packed_operation";
      "val decode : 'a channel -> string -> ('a decoded, decode_error) result";
      "val decode_received : 'a channel -> string -> ('a decoded, \
       decode_error) result";
      "val name : 'a channel -> string";
      "val payload : 'a channel -> payload";
      "val delivery : 'a channel -> delivery option";
      "val emittable : 'a channel -> bool";
      "val audience : 'a channel -> audience option";
      "val in_process : 'a channel -> bool";
      "val operation_effect : ('request, 'result, 'failure) operation -> \
       operation_effect option";
      "val request : ('request, 'result, 'failure) operation -> 'request \
       channel";
      "val result : ('request, 'result, 'failure) operation -> 'result channel";
      "val failure : ('request, 'result, 'failure) operation -> 'failure \
       channel";
      "val reply_names : ('request, 'result, 'failure) operation -> string list";
      "val trace_field : string";
      "val stream_event : string";
      "val channels : packed_channel list";
      "val operations : packed_operation list";
      "val bridged_channels : packed_channel list";
    ]
  in
  let impl =
    [
      "type 'a channel = { name : string; payload : payload; delivery : \
       delivery option; emittable : bool; audience : audience option; \
       in_process : bool }";
      "type ('request, 'result, 'failure) operation = { request : 'request \
       channel; result : 'result channel; failure : 'failure channel; \
       reply_names : string list; operation_effect : operation_effect option }";
      "type 'a decoded = Yojson.Raw.t";
      "type fault = Schema_codec.fault = { member : string; reason : [ `Lacks \
       | `Malformed ] }";
      "type decode_error = Schema_codec.error = Invalid_json of string | \
       Invalid_payload of fault";
    ]
    @ List.filter (String.starts_with ~prefix:"type packed_") api
    @ [
        "let json value = value";
        "let encode value = Yojson.Raw.to_string value";
        "let channel_shape channel =";
        "  let open Schema_shape in";
        "  match channel.payload with";
        "    | Component name -> reference name";
        "    | Recorded { envelope; payload } ->";
        "        { any with all_of = [reference envelope; object_ \
         ~members:[\"payload\", reference payload] ()] }";
        "    | Envelope name -> object_ ~required:[\"response\"] \
         ~members:[\"response\", reference name] ~closed:[\"response\"] ()";
        "    | Empty | Void -> object_ ~closed:[] ()";
        "let decode channel = Schema_codec.decode (channel_shape channel)";
        "let decode_received channel =";
        "  let shape = match channel.payload with";
        "    | Recorded { envelope; _ } -> Schema_shape.reference envelope";
        "    | _ -> channel_shape channel";
        "  in";
        "  Schema_codec.decode_received shape";
      ]
    @ List.map
        (fun f -> "let " ^ f ^ " value = value." ^ f)
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
        "let trace_field = " ^ string reg.trace.field;
        "let stream_event = " ^ string event;
      ]
  in
  let delivery_of channel =
    match Hashtbl.find_opt delivery channel with
    | None -> "None"
    | Some Bus.Registry.Positioned -> "Some Positioned"
    | Some Correlated -> "Some Correlated"
    | Some Passing -> "Some Passing"
  in
  let channels =
    List.map
      (fun r ->
        Printf.sprintf
          "  let %s = { name = %s; payload = %s; delivery = %s; emittable = \
           %b; audience = %s; in_process = %b }"
          r.name (string r.channel) r.shape (delivery_of r.channel) r.emittable
          (some (audience r.channel))
          (List.mem r.channel reg.in_process.channels))
      rows
  in
  let operation_values =
    List.map
      (fun ((o : R.operation), _) ->
        Printf.sprintf
          "  let %s = { request = Channels.%s; result = Channels.%s; failure = \
           Channels.%s; reply_names = [%s]; operation_effect = %s }"
          (name_of o.request) (name_of o.request) (name_of o.result)
          (name_of o.failure)
          (String.concat "; "
             (List.map string (List.assoc o.request bus.reply_names)))
          (some (effect_ o.request)))
      operations
  in
  let packed f values = "[" ^ String.concat "; " (List.map f values) ^ "]" in
  let registry_ml =
    types @ impl
    @ ("module Channels = struct" :: channels)
    @ ("end" :: "module Operations = struct" :: operation_values)
    @ [
        "end";
        "let channels = " ^ packed (fun r -> "Channel Channels." ^ r.name) rows;
        "let operations = "
        ^ packed
            (fun ((o : R.operation), _) ->
              "Operation Operations." ^ name_of o.request)
            operations;
        "let bridged_channels = "
        ^ packed (fun c -> "Channel Channels." ^ name_of c) bridged;
      ]
  in
  let registry_mli =
    types @ api
    @ "module Channels : sig"
      :: List.map
           (fun r -> "  val " ^ r.name ^ " : " ^ r.type_ ^ " channel")
           rows
    @ "end" :: "module Operations : sig"
      :: List.map
           (fun ((o : R.operation), t) ->
             "  val " ^ name_of o.request ^ " : " ^ t)
           operations
    @ [ "end" ]
  in
  (* Each method a channel or an operation is, by its namespace. *)
  let surface = spec.tables.client_surface in
  let correlated (m : S.method_) =
    List.exists (fun (c : S.case) -> Option.is_some c.correlation_id) m.cases
  in
  let operation_of request =
    List.find_opt (fun ((o : R.operation), _) -> o.request = request) operations
  in
  let channel_of at kind channel =
    match List.find_opt (fun r -> r.channel = channel) rows with
    | Some r -> r.name
    | None ->
        refuse ~file:surface_file at
          (Printf.sprintf "names %s, which is no %s channel" channel kind);
        ""
  in
  let wired =
    List.concat
      (List.mapi
         (fun n (ns : S.namespace) ->
           let functions =
             List.concat
               (List.mapi
                  (fun i (m : S.method_) ->
                    let at =
                      Printf.sprintf "/namespaces/%d/methods/%d/via" n i
                    in
                    let name = Text.snake m.method_ in
                    let correlation = correlated m in
                    match (m.via.request, m.via.local, m.via.emit) with
                    | Some request, _, _
                      when m.shape = "promise"
                           && not (List.mem m.method_ by_hand) -> (
                        match operation_of request with
                        | Some (o, _) ->
                            [
                              Printf.sprintf
                                "  let %s client payload = Client_core.ask \
                                 client Bus_registry.Operations.%s payload"
                                name (name_of o.request);
                            ]
                        | None ->
                            refuse ~file:surface_file (at ^ "/request")
                              (Printf.sprintf
                                 "names %s, which no operation asks" request);
                            [])
                    | _, Some local, _ when m.shape = "signal" ->
                        let c = channel_of (at ^ "/local") "local" local in
                        let opt =
                          if correlation then " ?correlation_id" else ""
                        in
                        [
                          Printf.sprintf
                            "  let %s client%s payload = Client_core.publish \
                             client%s Bus_registry.Channels.%s payload"
                            name opt opt c;
                        ]
                    | _, _, Some emit ->
                        let c = channel_of (at ^ "/emit") "emitted" emit in
                        let how =
                          if m.shape = "count" then "drive" else "signal"
                        in
                        [
                          Printf.sprintf
                            "  let %s client ?scope payload = Client_core.%s \
                             client ?scope Bus_registry.Channels.%s payload"
                            name how c;
                        ]
                    | _ -> [])
                  ns.methods)
           in
           if functions = [] then []
           else
             (("module " ^ upper ns.namespace ^ " = struct") :: functions)
             @ [ "end"; "" ])
         surface.namespaces)
  in
  let behavior =
    List.concat_map
      (fun (ns : S.namespace) ->
        List.filter_map
          (fun (m : S.method_) ->
            (* A promise that asks, or any method that emits or publishes,
               dispatches to the first channel it names. *)
            let target =
              if
                (Option.is_some m.via.request && m.shape = "promise")
                || Option.is_some m.via.emit || Option.is_some m.via.local
              then
                List.find_map Fun.id [ m.via.request; m.via.emit; m.via.local ]
              else None
            in
            match target with
            | Some channel when not (List.mem m.method_ by_hand) ->
                Some
                  (Printf.sprintf
                     "  | \"%s.%s\" -> ignore (C.%s.%s client%s (decode \
                      B.Channels.%s payload)); true"
                     ns.namespace m.method_ (upper ns.namespace)
                     (Text.snake m.method_)
                     (if correlated m then " ?correlation_id" else "")
                     (name_of channel))
            | _ -> None)
          ns.methods)
      surface.namespaces
  in
  let surface_header =
    Banner.ocaml ~from_:("protocol/specs/src/" ^ surface_file) __FILE__ ^ "\n"
  in
  match List.rev !refusals with
  | [] ->
      Ok
        [
          {
            Output.path = "ocaml/sdk/lib/bus_registry.ml";
            text = registry_header ^ String.concat "\n" registry_ml ^ "\n";
          };
          {
            Output.path = "ocaml/sdk/lib/bus_registry.mli";
            text = registry_header ^ String.concat "\n" registry_mli ^ "\n";
          };
          {
            Output.path = "ocaml/sdk/lib/namespace_methods.ml";
            text =
              header
                ("protocol/specs/src/" ^ surface_file
               ^ " and protocol/specs/src/" ^ Bus.Registry.file)
              ^ String.concat "\n" wired;
          };
          {
            Output.path = "ocaml/sdk/test/surface_dispatch.ml";
            text =
              surface_header
              ^ String.concat "\n"
                  ([
                     "module B = Xynolog.Bus_registry";
                     "module C = Xynolog.Client";
                     "";
                     "let decode channel payload = match B.decode channel \
                      (Yojson.Safe.to_string payload) with";
                     "  | Ok decoded -> decoded";
                     "  | Error _ -> failwith (\"invalid test payload for \" ^ \
                      B.name channel)";
                     "";
                     "let invoke client ~correlation_id name payload = match \
                      name with";
                   ]
                  @ behavior @ [ "  | _ -> false"; "" ]);
          };
        ]
  | errors -> Error errors
