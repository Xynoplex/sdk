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
  channel : string -> R.channel;
  reply_names : (string * string list) list;
      (* Each operation's request, with what its result states beside its
         response, in the order the result's schema requires them. *)
  stamps : (string * string list) list;
      (* Each channel of channelOrder.eventMap, with the stamps its payload's
         schema declares: its properties whose names begin with "_". *)
  attrs : attrs list; (* Each channel of channelOrder.eventMap. *)
  limits : R.operation * R.operation list;
      (* The operations named <flow>:limits-requested, which all ask and
         answer the same. *)
}

let stored_event_component ~enriched =
  if enriched then "EnrichedResourceEvent" else "StoredEventResponse"

let carried (c : R.channel) =
  match c.payload with
  | Schema { schema; _ } -> Component schema
  | Envelope { schema } -> Response schema
  | Stored_event { enriched; _ } -> Component (stored_event_component ~enriched)
  | Void | Empty -> Nothing

let is_recorded (c : R.channel) =
  match c.payload with Stored_event _ -> true | _ -> false

let validate_of (c : R.channel) =
  match c.payload with Schema { validate; _ } -> validate | _ -> None

let indexed list = List.mapi (fun i x -> (i, x)) list
let member set x = List.mem x set

(* The rules of the registry's lists: each channel declared once and named
   only where declared, each crossing channel declaring its kind and audience
   and each emittable one its effect, with no default for any. *)
let check (reg : R.t) =
  let problems = ref [] in
  let refuse pointer fmt =
    Printf.ksprintf
      (fun message ->
        problems := { Decode.file; pointer; message } :: !problems)
      fmt
  in
  let declared = Hashtbl.create 256 in
  List.iter
    (fun (i, (c : R.channel)) ->
      if Hashtbl.mem declared c.channel then
        refuse
          (Printf.sprintf "/channels/%d" i)
          "channel %S is declared more than once" c.channel
      else Hashtbl.replace declared c.channel c)
    (indexed reg.channels);
  let known pointer ch =
    if not (Hashtbl.mem declared ch) then
      refuse pointer "names %S, which is not declared in channels[]" ch
  in
  let known_list pointer list =
    List.iteri (fun i ch -> known (Printf.sprintf "%s/%d" pointer i) ch) list
  in
  known_list "/channelOrder/eventMap" reg.channel_order.event_map;
  known_list "/channelOrder/schemas" reg.channel_order.schemas;
  let requests = List.map (fun (o : R.operation) -> o.request) reg.operations in
  let replies =
    List.concat_map
      (fun (o : R.operation) -> [ o.result; o.failure ])
      reg.operations
  in
  let owners = Hashtbl.create 64 in
  List.iter
    (fun (i, (o : R.operation)) ->
      let at member = Printf.sprintf "/operations/%d/%s" i member in
      known (at "request") o.request;
      known (at "result") o.result;
      known (at "failure") o.failure;
      (match Hashtbl.find_opt declared o.request with
      | Some c when validate_of c = None ->
          refuse (at "request")
            "%S is an operation's request and names no validate schema: \
             /bus/emit could never accept it, so Bus.request could never send \
             it"
            o.request
      | _ -> ());
      if member replies o.request then
        refuse (at "request") "%S is both a request and a reply" o.request;
      List.iter
        (fun (role, ch) ->
          match Hashtbl.find_opt owners ch with
          | Some owner ->
              refuse (at role)
                "%S is the %s of both %s and %s: a reply channel is one \
                 operation's"
                ch role owner o.request
          | None -> Hashtbl.replace owners ch o.request)
        [ ("result", o.result); ("failure", o.failure) ])
    (indexed reg.operations);
  let operation_channel ch = member requests ch || member replies ch in
  (* One owner per channel across an axis's values, which name only declared
     channels, each once. *)
  let axis name values =
    let owner = Hashtbl.create 64 in
    List.iter
      (fun (value, list) ->
        let pointer = Printf.sprintf "/%s/%s" name value in
        known_list pointer list;
        List.iteri
          (fun i ch ->
            let at = Printf.sprintf "%s/%d" pointer i in
            if
              List.exists (String.equal ch)
                (List.filteri (fun j _ -> j < i) list)
            then refuse at "%s.%s lists %S more than once" name value ch
            else
              match Hashtbl.find_opt owner ch with
              | Some prior ->
                  refuse at
                    "%S is declared both %s.%s and %s.%s: a channel crosses \
                     exactly one way"
                    ch name prior name value
              | None -> Hashtbl.replace owner ch value)
          list)
      values;
    owner
  in
  let kind_of =
    axis "kind" [ ("command", reg.kind.command); ("event", reg.kind.event) ]
  in
  let audience_of =
    axis "audience"
      [
        ("everyone", reg.audience.everyone);
        ("scoped", reg.audience.scoped);
        ("declared", reg.audience.declared);
      ]
  in
  known_list "/inProcess/channels" reg.in_process.channels;
  let in_process = reg.in_process.channels in
  List.iter
    (fun ch ->
      if operation_channel ch then (
        Option.iter
          (refuse "/kind"
             "%S belongs to an operation, so its kind is derived: remove it \
              from kind.%s"
             ch)
          (Hashtbl.find_opt kind_of ch);
        Option.iter
          (refuse "/audience"
             "%S belongs to an operation, so its audience is derived: remove \
              it from audience.%s"
             ch)
          (Hashtbl.find_opt audience_of ch));
      if member in_process ch then (
        Option.iter
          (refuse "/inProcess/channels"
             "%S is declared inProcess and given audience.%s: inProcess means \
              it never crosses"
             ch)
          (Hashtbl.find_opt audience_of ch);
        Option.iter
          (refuse "/inProcess/channels"
             "%S is declared inProcess and given kind.%s: inProcess means it \
              never crosses"
             ch)
          (Hashtbl.find_opt kind_of ch)))
    (List.map (fun (c : R.channel) -> c.channel) reg.channels);
  List.iter
    (fun (i, (c : R.channel)) ->
      let at = Printf.sprintf "/channels/%d" i in
      if not (member in_process c.channel || operation_channel c.channel) then (
        if not (Hashtbl.mem kind_of c.channel) then
          refuse at
            "channel %S declares no kind: add it to kind.command or \
             kind.event, or to inProcess if it never crosses. There is no \
             default."
            c.channel;
        if not (Hashtbl.mem audience_of c.channel) then
          refuse at
            "channel %S declares no audience: add it to audience.everyone, \
             audience.scoped or audience.declared. There is no default."
            c.channel);
      (match c.payload with
      | Stored_event { event; _ } when event <> c.channel ->
          refuse at
            "%S is a stored event named %S: a persisted event is published on \
             the channel of its own type"
            c.channel event
      | Schema { schema; validate = Some validate; _ } when validate <> schema
        ->
          refuse at
            "%S carries %s and validates against %s: one channel, one schema"
            c.channel schema validate
      | _ -> ());
      if
        Hashtbl.find_opt audience_of c.channel = Some "scoped"
        && not (is_recorded c)
      then
        refuse at
          "%S has audience scoped and is no stored event: a resource's scope \
           carries the events of its record"
          c.channel)
    (indexed reg.channels);
  (* Who emits a channel: whether that emit changes the knowledge base is
     declared, since the gateway reads it to decide whether an emit was an
     act. *)
  let emittable = requests @ reg.kind.command in
  let effect_of = Hashtbl.create 64 in
  List.iter
    (fun (side, list) ->
      let pointer = "/effect/" ^ side in
      known_list pointer list;
      List.iteri
        (fun i ch ->
          let at = Printf.sprintf "%s/%d" pointer i in
          if
            List.exists (String.equal ch) (List.filteri (fun j _ -> j < i) list)
          then refuse at "effect.%s lists %S more than once" side ch
          else (
            (match Hashtbl.find_opt effect_of ch with
            | Some prior ->
                refuse at
                  "%S is declared both effect.%s and effect.%s: an emit either \
                   changes the knowledge base or it does not"
                  ch prior side
            | None -> Hashtbl.replace effect_of ch side);
            if not (member emittable ch) then
              refuse at
                "effect.%s names %S, which nobody emits: the domain is an \
                 operation's request or a kind.command"
                side ch))
        list)
    [ ("writes", reg.effect_.writes); ("reads", reg.effect_.reads) ];
  List.iter
    (fun ch ->
      if not (Hashtbl.mem effect_of ch) then
        refuse "/effect"
          "emittable channel %S declares no effect: add it to effect.writes or \
           effect.reads. There is no default."
          ch)
    emittable;
  Hashtbl.iter
    (fun ch kind ->
      if kind = "command" && Hashtbl.find_opt audience_of ch = Some "everyone"
      then
        refuse "/kind/command"
          "%S is kind command with audience everyone: a directive is not a \
           broadcast"
          ch)
    kind_of;
  (* A directive, or a declaration, of a channel the TypeScript EventMap does
     not carry is drift. *)
  List.iter
    (fun (pointer, list) ->
      List.iter
        (fun ch ->
          if not (member reg.channel_order.event_map ch) then
            refuse pointer "%S is classified but not in channelOrder.eventMap"
              ch)
        list)
    [
      ("/kind/command", reg.kind.command);
      ("/audience/declared", reg.audience.declared);
      ("/inProcess/channels", reg.in_process.channels);
    ];
  let field = reg.trace.field in
  let word_char c =
    match c with
    | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '_' -> true
    | _ -> false
  in
  if
    not
      (String.length field >= 2
      && field.[0] = '_'
      && (match field.[1] with 'A' .. 'Z' | 'a' .. 'z' -> true | _ -> false)
      && String.for_all word_char field)
  then
    refuse "/trace/field"
      "is %S: it is a payload field the bus writes, so a name that begins with \
       \"_\" and a letter"
      field;
  List.rev !problems

(* A component schema, by the name the registry gives it. *)
let component (spec : Spec.t) name =
  List.assoc_opt ("components/schemas/" ^ name ^ ".json") spec.schemas

exception Problem of string

let problem fmt = Printf.ksprintf (fun message -> raise (Problem message)) fmt

let named component name =
  match component name with
  | Some schema -> schema
  | None -> problem "names the schema %s, which Protocol does not have" name

(* The schema a payload's schema refers to by "./<name>.json". *)
let referred component (reference : Decode.reference) =
  let target = reference.target in
  let n = String.length target in
  let name = if n > 7 then String.sub target 2 (n - 7) else "" in
  if
    String.starts_with ~prefix:"./" target
    && String.ends_with ~suffix:".json" target
    && name <> ""
    && String.for_all
         (function 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' -> true | _ -> false)
         name
  then named component name
  else
    problem "a payload schema refers to %S, which names no component schema"
      target

(* The properties [schema] states that begin with "_", and those of each
   schema it is composed of; a schema that refers to a component is read as
   that component. *)
let stamps component (schema : Schema.t) =
  let rec stamped (schema : Schema.t) =
    Schema.para
      ~boolean:(fun _ () -> [])
      ~schema:(fun s () ->
        List.filter
          (fun name -> String.starts_with ~prefix:"_" name)
          (List.map fst (Option.value s.properties ~default:[]))
        @ List.concat_map read
            (List.concat_map
               (fun members -> Option.value members ~default:[])
               [ s.all_of; s.one_of; s.any_of ]))
      schema
  and read (part, stamps) =
    match part with
    | Schema.Schema { ref_ = Some reference; _ } ->
        stamped (referred component reference) ()
    | _ -> stamps ()
  in
  read (schema, stamped schema)

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
let reply_names component channel (o : R.operation) =
  let reply : R.channel = channel o.result in
  let names =
    match reply.payload with
    | Schema { schema = name; _ } ->
        let schema = named component name in
        (match composition schema with
        | Some keyword ->
            problem
              "%s carries %s, which is composed with %s: what it requires is \
               not read from its own required"
              o.result name keyword
        | None -> ());
        List.filter (fun name -> name <> "response") (required schema)
    | Envelope _ | Empty | Void -> []
    | Stored_event _ ->
        problem
          "%s is the reply to %s and is a stored event, which states no \
           response to name anything beside"
          o.result o.request
  in
  (if names <> [] then
     let asked : R.channel = channel o.request in
     let stated =
       match asked.payload with
       | Schema { schema; _ } -> properties (named component schema)
       | _ -> []
     in
     match List.find_opt (fun name -> not (List.mem name stated)) names with
     | Some unstated ->
         problem "%s names %S beside its response, which %s does not state"
           o.result unstated o.request
     | None -> ());
  names

(* An operation's replies are correlated; a recorded event on a resource's
   scope is positioned; every other channel that crosses is passing. [check]
   gives each channel one place on the axes, so each has one class. *)
let delivery_classes (reg : R.t) =
  let classes = Hashtbl.create 256 in
  let set ch delivery = Hashtbl.replace classes ch delivery in
  List.iter
    (fun (o : R.operation) ->
      set o.request Passing;
      set o.result Correlated;
      set o.failure Correlated)
    reg.operations;
  let recorded =
    List.filter_map
      (fun (c : R.channel) -> if is_recorded c then Some c.channel else None)
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
let derive ~component (reg : R.t) =
  match check reg with
  | _ :: _ as problems -> Error problems
  | [] -> (
      let by_channel = Hashtbl.create 256 in
      List.iter
        (fun (c : R.channel) -> Hashtbl.replace by_channel c.channel c)
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
          (fun i (o : R.operation) ->
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
                  match (channel ch).payload with
                  | Schema { schema; _ } ->
                      List.sort_uniq String.compare
                        (stamps component (named component schema))
                  | _ -> [])
                [] ))
          reg.channel_order.event_map
      in
      let delivery = delivery_classes reg in
      let requests =
        List.map (fun (o : R.operation) -> o.request) reg.operations
      in
      let replies =
        List.concat_map
          (fun (o : R.operation) -> [ o.result; o.failure ])
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
              else if List.mem ch replies || List.mem ch audiences then
                Some Inbound
              else if List.mem ch reg.in_process.channels then Some In_process
              else (
                refuse
                  (Printf.sprintf "/channelOrder/eventMap/%d" i)
                  (Printf.sprintf
                     "channel %S declares no direction: add it to operations, \
                      kind and audience, or inProcess. There is no default."
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
          (fun (o : R.operation) ->
            String.ends_with ~suffix:":limits-requested" o.request)
          reg.operations
      in
      let shape (o : R.operation) =
        List.map
          (fun ch -> carried (channel ch))
          [ o.request; o.result; o.failure ]
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
                    (List.map (fun (o : R.operation) -> o.request) limits))
      in
      match (limits, List.rev !problems @ mismatched) with
      | first :: rest, [] ->
          Ok
            {
              registry = reg;
              channel;
              reply_names;
              stamps;
              attrs;
              limits = (first, rest);
            }
      | _, problems -> Error problems)
