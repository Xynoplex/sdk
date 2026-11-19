(* The bus registry as every language's bus files read it: held to the bus's
   rules, which its decoder's types cannot state, and with what it derives.
   Every refusal names the registry's entry; see protocol/contract/EVENT-BUS.md
   for the rules. *)

module R = Tables.Bus_registry

let file = "bus/registry.json"

type direction = Outbound | Inbound | In_process

(* What a subscriber is promised about a frame on a channel when its stream
   drops (protocol/contract/TRANSPORT-CONTRACT.md § Delivery). *)
type delivery = Positioned | Correlated | Passing

type attrs = {
  channel : string;
  recorded : bool;
  direction : direction;
  writes : bool option;
      (* Absent off the emittable set: nobody emits the channel. *)
  delivery : delivery option; (* Absent on a channel that never crosses. *)
}

(* What a channel carries, as each language names its type. *)
type carried = Component of string | Response of string | Nothing

type t = {
  registry : R.t;
  ids : Decode.ids;
      (** Each schema's [$id]: what a payload's reference names. *)
  channel : string -> R.channels_item;
  reply_names : (string * string list) list;
      (* Each operation's request, with what its result states beside its
         response, in the order the result's schema requires them. *)
  stamps : (string * string list) list;
      (* Each channel of channelOrder.eventMap, with the stamps its payload's
         schema declares: its properties whose names begin with "_". *)
  attrs : attrs list; (* Each channel of channelOrder.eventMap. *)
  limits : R.operations_item * R.operations_item list;
      (* The operations named <flow>:limits-requested, which all ask and
         answer the same. *)
}

(* What every shape of channel states alike. *)
let name : R.channels_item -> string = function
  | Schema { channel; _ }
  | Envelope { channel; _ }
  | Stored_event { channel; _ }
  | Void { channel; _ }
  | Empty { channel; _ } ->
      channel

let docs : R.channels_item -> R.docs = function
  | Schema { docs; _ }
  | Envelope { docs; _ }
  | Stored_event { docs; _ }
  | Void { docs; _ }
  | Empty { docs; _ } ->
      docs

let schema_docs : R.channels_item -> R.docs = function
  | Schema { schema_docs; _ }
  | Envelope { schema_docs; _ }
  | Stored_event { schema_docs; _ }
  | Void { schema_docs; _ }
  | Empty { schema_docs; _ } ->
      schema_docs

(* Prose as the registry states it, in no language's shape: paragraphs, each
   a text or a list of items, every text one line of words that a writer lays
   out for its own language. *)
let paragraph : R.event_name_item -> Text.paragraph = function
  | String words -> Words words
  | Object { items } -> Items items

let prose = List.map paragraph

let stored_event_component ~enriched =
  if enriched then "EnrichedResourceEvent" else "StoredEventResponse"

let carried : R.channels_item -> carried = function
  | Schema { schema; _ } -> Component schema
  | Envelope { schema; _ } -> Response schema
  | Stored_event { enriched; _ } ->
      Component (stored_event_component ~enriched:(enriched = Some true))
  | Void _ | Empty _ -> Nothing

let is_recorded : R.channels_item -> bool = function
  | Stored_event _ -> true
  | _ -> false

let validate_of : R.channels_item -> string option = function
  | Schema { validate; _ } -> validate
  | _ -> None

let indexed list = List.mapi (fun i x -> (i, x)) list
let components = "components/schemas/"

(* A component schema, by the name the registry gives it. *)
let component (spec : Spec.t) name =
  List.assoc_opt (components ^ name ^ ".json") spec.schemas

exception Problem of string

let problem fmt = Printf.ksprintf (fun message -> raise (Problem message)) fmt

let named component name =
  match component name with
  | Some schema -> schema
  | None -> problem "names the schema %s, which Protocol does not have" name

(* The name of the component schema a payload's schema refers to. *)
let referred ids (reference : Decode.reference) =
  match Decode.names ids reference with
  | Some (file, "") when Filename.dirname file ^ "/" = components ->
      Filename.remove_extension (Filename.basename file)
  | _ ->
      problem "a payload schema refers to %S, which names no component schema"
        reference.target

(* The stamps [schema], the component [of_] or a schema within it, declares:
   the properties of what it merges to ([Normalize]), and a union's, on which
   its members must agree: a stamp is kept or dropped before a frame is read,
   so before it is known which member the frame is. A schema that refers to a
   component is read as that component. *)
let stamps ~ids component ~of_ (schema : Schema.t) =
  let rec stamped ~of_ (schema : Schema.t) =
    match schema with
    | Boolean_schema _ -> []
    | Schema { ref_ = Some reference; _ } ->
        let name = referred ids reference in
        stamped ~of_:name (named component name)
    | Schema _ -> (
        match
          Normalize.normalize ids
            ~find:(fun r -> Ok (named component (referred ids r)))
            schema
        with
        | Error message -> problem "%s: %s" of_ message
        | Ok s ->
            let union members =
              match
                List.map
                  (fun member ->
                    List.sort_uniq String.compare (stamped ~of_ member))
                  (Option.value members ~default:[])
              with
              | [] -> []
              | first :: rest when List.for_all (( = ) first) rest -> first
              | each ->
                  problem
                    "%s: its members do not declare the same stamps (%s), and \
                     a stamp is kept or dropped before it is known which \
                     member a frame is"
                    of_
                    (String.concat "; "
                       (List.map
                          (fun one -> "[" ^ String.concat ", " one ^ "]")
                          each))
            in
            List.filter
              (fun name -> String.starts_with ~prefix:"_" name)
              (List.map fst (Option.value s.properties ~default:[]))
            @ union s.one_of @ union s.any_of)
  in
  stamped ~of_ schema

let required (schema : Schema.t) =
  match schema with
  | Boolean_schema _ -> []
  | Schema s -> Option.value s.required ~default:[]

let properties (schema : Schema.t) =
  match schema with
  | Boolean_schema _ -> []
  | Schema s -> List.map fst (Option.value s.properties ~default:[])

let composition (schema : Schema.t) =
  match schema with
  | Boolean_schema _ -> None
  | Schema s ->
      List.find_map
        (fun (keyword, present) -> if present then Some keyword else None)
        [
          ("$ref", Option.is_some s.ref_);
          ("allOf", Option.is_some s.all_of);
          ("anyOf", Option.is_some s.any_of);
          ("oneOf", Option.is_some s.one_of);
        ]

(* What an operation's result states beside its response: the properties its
   schema requires, which must be properties of the request, since whoever
   answers takes each from it. *)
let reply_names component channel (o : R.operations_item) =
  let names =
    match channel o.result with
    | R.Schema { schema = name; _ } ->
        let schema = named component name in
        (match composition schema with
        | Some keyword ->
            problem
              "%s carries %s, which is composed with %s: what it requires is \
               not read from its own required"
              o.result name keyword
        | None -> ());
        List.filter (fun name -> name <> "response") (required schema)
    | Envelope _ | Empty _ | Void _ -> []
    | Stored_event _ ->
        problem
          "%s is the reply to %s and is a stored event, which states no \
           response to name anything beside"
          o.result o.request
  in
  (if names <> [] then
     let stated =
       match channel o.request with
       | R.Schema { schema; _ } -> properties (named component schema)
       | _ -> []
     in
     match List.find_opt (fun name -> not (List.mem name stated)) names with
     | Some unstated ->
         problem "%s names %S beside its response, which %s does not state"
           o.result unstated o.request
     | None -> ());
  names

(* An operation's replies are correlated; a recorded event on a resource's
   scope is positioned; every other channel that crosses is passing. Protocol's
   reader gives each channel one place on the axes, so each has one class. *)
let delivery_classes (reg : R.t) =
  let classes = Hashtbl.create 256 in
  let set ch delivery = Hashtbl.replace classes ch delivery in
  List.iter
    (fun (o : R.operations_item) ->
      set o.request Passing;
      set o.result Correlated;
      set o.failure Correlated)
    reg.operations;
  let recorded =
    List.filter_map
      (fun (c : R.channels_item) ->
        if is_recorded c then Some (name c) else None)
      reg.channels
  in
  List.iter
    (fun ch -> set ch (if List.mem ch recorded then Positioned else Passing))
    reg.audience.scoped;
  List.iter
    (fun ch -> set ch Passing)
    (reg.audience.everyone @ reg.audience.declared);
  classes

(* [component name] is the component schema the registry names [name]. *)
let derive ~ids ~component (reg : R.t) =
  let by_channel = Hashtbl.create 256 in
  List.iter
    (fun (c : R.channels_item) -> Hashtbl.replace by_channel (name c) c)
    reg.channels;
  let channel name = Hashtbl.find by_channel name in
  let problems = ref [] in
  let refuse pointer message =
    problems := { Decode.file; pointer; message } :: !problems
  in
  let attempt pointer f default =
    match f () with
    | value -> value
    | exception Problem message ->
        refuse pointer message;
        default
  in
  let reply_names =
    List.mapi
      (fun i (o : R.operations_item) ->
        ( o.request,
          attempt
            (Printf.sprintf "/operations/%d" i)
            (fun () -> reply_names component channel o)
            [] ))
      reg.operations
  in
  let stamps =
    List.mapi
      (fun i ch ->
        ( ch,
          attempt
            (Printf.sprintf "/channelOrder/eventMap/%d" i)
            (fun () ->
              match channel ch with
              | R.Schema { schema; _ } ->
                  List.sort_uniq String.compare
                    (stamps ~ids component ~of_:schema (named component schema))
              | _ -> [])
            [] ))
      reg.channel_order.event_map
  in
  let delivery = delivery_classes reg in
  let requests =
    List.map (fun (o : R.operations_item) -> o.request) reg.operations
  in
  let replies =
    List.concat_map
      (fun (o : R.operations_item) -> [ o.result; o.failure ])
      reg.operations
  in
  let audiences =
    reg.audience.everyone @ reg.audience.scoped @ reg.audience.declared
  in
  let emittable = requests @ reg.kind.command in
  let attrs =
    List.filter_map
      (fun (i, ch) ->
        let direction =
          if List.mem ch emittable then Some Outbound
          else if List.mem ch replies || List.mem ch audiences then Some Inbound
          else if List.mem ch reg.in_process.channels then Some In_process
          else (
            refuse
              (Printf.sprintf "/channelOrder/eventMap/%d" i)
              (Printf.sprintf
                 "channel %S declares no direction: add it to operations, kind \
                  and audience, or inProcess. There is no default."
                 ch);
            None)
        in
        Option.map
          (fun direction ->
            {
              channel = ch;
              recorded = is_recorded (channel ch);
              direction;
              writes =
                (if List.mem ch emittable then
                   Some (List.mem ch reg.effect_.writes)
                 else None);
              delivery = Hashtbl.find_opt delivery ch;
            })
          direction)
      (indexed reg.channel_order.event_map)
  in
  let limits =
    List.filter
      (fun (o : R.operations_item) ->
        String.ends_with ~suffix:":limits-requested" o.request)
      reg.operations
  in
  let shape (o : R.operations_item) =
    List.map (fun ch -> carried (channel ch)) [ o.request; o.result; o.failure ]
  in
  let limits_problem message =
    [ { Decode.file; pointer = "/operations"; message } ]
  in
  let mismatched =
    match limits with
    | [] -> limits_problem "no operation is named <flow>:limits-requested"
    | first :: rest ->
        if List.for_all (fun o -> shape o = shape first) rest then []
        else
          limits_problem
            ("the limits operations do not all ask and answer the same: "
            ^ String.concat ", "
                (List.map (fun (o : R.operations_item) -> o.request) limits))
  in
  match (limits, List.rev !problems @ mismatched) with
  | first :: rest, [] ->
      Ok
        {
          registry = reg;
          ids;
          channel;
          reply_names;
          stamps;
          attrs;
          limits = (first, rest);
        }
  | _, problems -> Error problems
