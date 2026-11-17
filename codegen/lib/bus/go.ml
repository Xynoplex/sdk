(* The Go SDK's bus vocabulary, in go/bus:

   channels_gen.go    every channel, typed by its payload, and the field a
                      relayed frame's trace rides in
   operations_gen.go  every request, typed, with its two replies; and the
                      replies of each by name, with what each result states
                      beside its response
   bridged_gen.go     the channels bridged to every client, and those a
                      resource's scope carries

   The payload types are the OpenAPI schemas', in go/api, and the typed values
   are of the kinds go/bus/typed.go declares. *)

module R = Tables.Bus_registry
module G = Go_syntax

let header =
  G.verbatim
    "Code generated from protocol/specs/src/bus/registry.json — DO NOT EDIT.\n\n\
     Regenerate: make generate (codegen/lib/bus/go.ml)"

(* [mark:delegate-timeout] is [MarkDelegateTimeout]. *)
let name channel =
  String.concat ""
    (List.map String.capitalize_ascii
       (String.split_on_char ':' channel
       |> List.concat_map (String.split_on_char '-')))

let api schema = G.Named ("api." ^ schema)

let type_of (carried : Registry.carried) =
  match carried with
  | Component schema -> api schema
  | Response schema -> G.Generic ("Response", [ api schema ])
  | Nothing -> G.Named "Empty"

let typed (bus : Registry.t) channel =
  type_of (Registry.carried (bus.channel channel))

(* A channel's typed value: what it carries, and whether it is emitted, read
   for a resource, or of the record. A scoped channel is a stored event. *)
let value (bus : Registry.t) (c : R.channel) =
  let type_ = type_of (Registry.carried c) in
  match c.payload with
  | Stored_event { payload; _ } ->
      G.Generic
        ( (if List.mem c.channel bus.registry.audience.scoped then "Scoped"
           else "Recorded"),
          [ type_; api payload ] )
  | _ ->
      G.Generic
        ( (if Option.is_some (Registry.validate_of c) then "Emittable" else "Of"),
          [ type_ ] )

let quoted channels = List.map (fun c -> G.item (G.Quoted c)) channels

let channels (bus : Registry.t) =
  let reg = bus.registry in
  let requests = List.map (fun (o : R.operation) -> o.request) reg.operations in
  G.text
    {
      header;
      package = "bus";
      imports = [ [ "github.com/xynolog/sdk/go/api" ] ];
      decls =
        [
          G.Vars
            {
              doc =
                G.verbatim
                  "Every channel that is no operation's request, typed by the \
                   payload it\n\
                   carries. An operation's request is the operation \
                   (operations_gen.go).";
              spacing = G.Packed;
              specs =
                List.filter_map
                  (fun (c : R.channel) ->
                    if List.mem c.channel requests then None
                    else
                      Some
                        (G.spec (name c.channel)
                           (G.inline ~of_:(value bus c) (quoted [ c.channel ]))))
                  reg.channels;
            };
          G.Const
            (G.spec
               ~doc:(G.prose reg.trace.meaning)
               "TraceField" (G.Quoted reg.trace.field));
        ];
    }

let operations (bus : Registry.t) =
  let reg = bus.registry in
  let shape (o : R.operation) =
    G.Generic
      ("Operation", List.map (typed bus) [ o.request; o.result; o.failure ])
  in
  let first, rest = bus.limits in
  G.text
    {
      header;
      package = "bus";
      imports = [ [ "reflect" ]; [ "github.com/xynolog/sdk/go/api" ] ];
      decls =
        [
          G.Vars
            {
              doc =
                G.verbatim
                  "Every operation, named for its request channel and typed by \
                   what it sends\n\
                   and what each of its replies carries.";
              spacing = G.Packed;
              specs =
                List.map
                  (fun (o : R.operation) ->
                    G.spec (name o.request)
                      (G.inline ~of_:(shape o)
                         (quoted [ o.request; o.result; o.failure ])))
                  reg.operations;
            };
          G.Var
            (G.spec
               ~doc:
                 (G.verbatim
                    "LimitsOperations is the operations that report the limits \
                     of the models a\n\
                     service holds credentials for: one per such service, each \
                     named\n\
                     <flow>:limits-requested. A new key holder's joins by \
                     being registered.")
               "LimitsOperations"
               (G.lines
                  ~of_:(G.Slice (shape first))
                  (List.map
                     (fun (o : R.operation) -> G.item (G.Name (name o.request)))
                     (first :: rest))));
          G.Var
            (G.spec
               ~doc:
                 (G.verbatim
                    (Printf.sprintf
                       "Operations is each operation's replies, by the name of \
                        its request\n\
                        channel: for a request named at run time. %d \
                        operations."
                       (List.length reg.operations)))
               "Operations"
               (G.lines
                  ~of_:(G.Map (G.Named "Channel", G.Named "Replies"))
                  (List.map
                     (fun (o : R.operation) ->
                       G.element ~key:(G.Quoted o.request)
                         (G.inline
                            ([
                               G.keyed "Result" (G.Quoted o.result);
                               G.keyed "Failure" (G.Quoted o.failure);
                               G.keyed "FailurePayload"
                                 (G.Call
                                    ( G.Instance
                                        ( G.Name "reflect.TypeFor",
                                          [ typed bus o.failure ] ),
                                      [] ));
                             ]
                            @
                            match List.assoc o.request bus.reply_names with
                            | [] -> []
                            | names ->
                                [
                                  G.keyed "ReplyNames"
                                    (G.inline ~of_:(G.Slice (G.Named "string"))
                                       (quoted names));
                                ])))
                     reg.operations)));
        ];
    }

let bridged (bus : Registry.t) =
  let reg = bus.registry in
  let listed doc name channels =
    G.Var
      (G.spec ~doc:(G.verbatim doc) name
         (G.lines ~of_:(G.Slice (G.Named "Channel")) (quoted channels)))
  in
  G.text
    {
      header;
      package = "bus";
      imports = [];
      decls =
        [
          listed
            "BridgedBroadcasts: channels with no owning operation — job \
             lifecycle, KB\n\
             vocabulary changes, attention signals, SSE infrastructure. These \
             are what a\n\
             client subscribes to when it wants to watch a KB rather than \
             await a reply."
            "BridgedBroadcasts" reg.audience.everyone;
          listed
            "ResourceScopedChannels: the channels a resource's scope carries, \
             which a\n\
             client holding the scope names in that scope's entry of its \
             subscription.\n\
             Disjoint from BridgedChannels: a channel in both would reach a \
             client twice,\n\
             under two ids."
            "ResourceScopedChannels" reg.audience.scoped;
          listed
            "PersistedEventTypes: the channels of the events of the record, \
             each named\n\
             for the event it carries: every event the event log holds. A \
             follower of the\n\
             record receives each of them \
             (protocol/contract/TRANSPORT-CONTRACT.md § What\n\
             repairs a passing frame)."
            "PersistedEventTypes"
            (List.filter_map
               (fun (c : R.channel) ->
                 if Registry.is_recorded c then Some c.channel else None)
               reg.channels);
        ];
    }

(* Two channels whose Go names are one would be one value. *)
let collisions (bus : Registry.t) =
  let seen = Hashtbl.create 256 in
  List.filter_map
    (fun (c : R.channel) ->
      let go = name c.channel in
      match Hashtbl.find_opt seen go with
      | Some other ->
          Some
            {
              Decode.file = Registry.file;
              pointer = "/channels";
              message =
                Printf.sprintf "%S and %S would both be the Go name %s" other
                  c.channel go;
            }
      | None ->
          Hashtbl.replace seen go c.channel;
          None)
    bus.registry.channels

let files bus : (Output.file list, Decode.error list) result =
  match collisions bus with
  | _ :: _ as problems -> Error problems
  | [] ->
      let at name text = { Output.path = "go/bus/" ^ name; text } in
      Ok
        [
          at "channels_gen.go" (channels bus);
          at "operations_gen.go" (operations bus);
          at "bridged_gen.go" (bridged bus);
        ]
