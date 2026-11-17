(* The Python SDK's bus vocabulary, in python/sdk/src/xynolog:

   channels.py    every channel, typed by its payload, and the field a relayed
                  frame's trace rides in
   operations.py  every request, with its two replies

   The payload classes are the OpenAPI schemas', in xynolog/types.py. A
   channel that carries a stored event names the type of the event's own
   payload too, from the entry's payload. *)

module R = Tables.Bus_registry

let banner =
  {|# Generated from protocol/specs/src/bus/registry.json; do not edit.
# Regenerate: make generate (codegen/lib/bus/python.ml)
|}

let is_lower_or_digit = function 'a' .. 'z' | '0' .. '9' -> true | _ -> false
let is_upper = function 'A' .. 'Z' -> true | _ -> false
let is_alnum c = is_lower_or_digit c || is_upper c

(* [emitRetry] is [EMIT_RETRY]; [mark:delegate-timeout] is
   [MARK_DELEGATE_TIMEOUT]. *)
let constant name =
  let out = Buffer.create (String.length name + 8) in
  String.iteri
    (fun i c ->
      if i > 0 && is_upper c && is_lower_or_digit name.[i - 1] then
        Buffer.add_char out '_';
      if is_alnum c then Buffer.add_char out (Char.uppercase_ascii c)
      else if i = 0 || is_alnum name.[i - 1] then Buffer.add_char out '_')
    name;
  Buffer.contents out

let type_of (carried : Registry.carried) =
  match carried with
  | Component schema -> schema
  | Response schema -> "Response[" ^ schema ^ "]"
  | Nothing -> "Empty"

(* The schemas a channel's type names: for a stored event, the event's own
   payload's too. *)
let names (c : R.channel) =
  match (c.payload, Registry.carried c) with
  | Stored_event { payload; _ }, Component event -> [ event; payload ]
  | _, (Component schema | Response schema) -> [ schema ]
  | _, Nothing -> []

let lines = String.concat "\n"

let indented indent channels =
  lines (List.map (fun c -> indent ^ Text.quoted c ^ ",") channels)

let channels (bus : Registry.t) =
  let reg = bus.registry in
  let scoped = reg.audience.scoped in
  let declaration (c : R.channel) =
    let type_ = type_of (Registry.carried c) in
    match c.payload with
    | Stored_event { payload; _ } ->
        constant c.channel ^ ": Final = "
        ^ (if List.mem c.channel scoped then "ScopedChannel"
           else "RecordedChannel")
        ^ "[" ^ type_ ^ ", " ^ payload ^ "](" ^ Text.quoted c.channel ^ ", "
        ^ type_ ^ ", " ^ payload ^ ")"
    | _ ->
        constant c.channel ^ ": Final = Channel[" ^ type_ ^ "]("
        ^ Text.quoted c.channel ^ ", " ^ type_ ^ ")"
  in
  let all_names = List.map (fun (c : R.channel) -> c.channel) reg.channels in
  let bridged =
    List.concat_map
      (fun (o : R.operation) -> [ o.result; o.failure ])
      reg.operations
    @ reg.audience.everyone
  in
  String.concat ""
    [
      banner;
      {|
"""Every channel of the bus, typed by the payload it carries.

A constant names its channel and holds its payload's type, so a function that
takes a `Channel[P]` and a `P` is refused another channel's payload by a type
checker. The payload types are the protocol's own (`xynolog.types`); which
belongs to which channel is the registry's to say, and is derived here from
each channel's shape.

A channel a resource's scope carries is a `ScopedChannel[P, E]`, by the
registry's `audience`: it is read for a resource, and a type checker refuses
a read of one that names none.

A channel that carries events of the record carries the stored event, and
names the type `E` of the event's own payload too, by the registry's
`payload`: a `ScopedChannel[P, E]`, or a `RecordedChannel[P, E]` where
the event concerns the whole knowledge base. `MARK_ADDED.event(stored)` is
an `AnnotationAddedPayload`, and a stored event of another type is refused.
"""

from collections.abc import Mapping
from types import MappingProxyType
from typing import Final, Literal

from xynolog.channel import AnyChannel, Channel, Empty, RecordedChannel, Response, ScopedChannel
from xynolog.types import (
|};
      lines
        (List.map
           (fun name -> "    " ^ name ^ ",")
           (List.sort_uniq String.compare (List.concat_map names reg.channels)));
      {|
)

__all__ = [
    "BRIDGED_CHANNELS",
    "CHANNELS",
    "CHANNEL_NAMES",
    "PERSISTED_EVENT_TYPES",
    "RESOURCE_SCOPED_CHANNELS",
    "TRACE_FIELD",
|};
      indented "    " (List.sort String.compare (List.map constant all_names));
      {|
    "ChannelName",
]

# Every channel's name.
type ChannelName = Literal[
|};
      indented "    " all_names;
      {|
]

CHANNEL_NAMES: Final[tuple[ChannelName, ...]] = (
|};
      indented "    " all_names;
      "\n)\n\n";
      lines (List.map declaration reg.channels);
      {|

# Every channel, by its name: for code that is given a name and not a constant.
CHANNELS: Final[Mapping[str, AnyChannel]] = MappingProxyType(
    {
|};
      lines
        (List.map
           (fun name ->
             "        " ^ Text.quoted name ^ ": " ^ constant name ^ ",")
           all_names);
      {|
    }
)

# The channels a client hears with no scope held, unless it names a narrower list: every
# operation's result and failure, and the events sent to every client.
BRIDGED_CHANNELS: Final[tuple[ChannelName, ...]] = (
|};
      indented "    " bridged;
      {|
)

# The channels a resource's scope carries: what holding a resource adds to a client's stream.
RESOURCE_SCOPED_CHANNELS: Final[tuple[ChannelName, ...]] = (
|};
      indented "    " scoped;
      {|
)

# The channels of the events of the record, each named for the event it carries: every event the event log
# holds. A follower of the record receives each of them (protocol/contract/TRANSPORT-CONTRACT.md § What repairs
# a passing frame).
PERSISTED_EVENT_TYPES: Final[tuple[ChannelName, ...]] = (
|};
      indented "    "
        (List.filter_map
           (fun (c : R.channel) ->
             if Registry.is_recorded c then Some c.channel else None)
           reg.channels);
      "\n)\n\n";
      Text.python_comment ~indent:"" reg.trace.meaning;
      "\nTRACE_FIELD: Final = ";
      Text.quoted reg.trace.field;
      "\n";
    ]

let operations (bus : Registry.t) =
  let reg = bus.registry in
  let first, rest = bus.limits in
  let operation (o : R.operation) =
    constant o.request ^ ": Final = Operation(\n    request=channels."
    ^ constant o.request ^ ",\n    result=channels." ^ constant o.result
    ^ ",\n    failure=channels." ^ constant o.failure ^ ",\n)"
  in
  let requests = List.map (fun (o : R.operation) -> o.request) reg.operations in
  String.concat ""
    [
      banner;
      {|
"""Every request of the bus, with the two channels it is answered on.

An operation is named for its request channel. Its type says what is sent and
what a reply carries, so a request is refused another operation's payload, and
its answer is typed, by a type checker.
"""

from collections.abc import Mapping
from types import MappingProxyType
from typing import Final

from xynolog import channels
from xynolog.channel import AnyOperation, Operation

__all__ = [
    "LIMITS_OPERATIONS",
    "OPERATIONS",
|};
      indented "    " (List.sort String.compare (List.map constant requests));
      "\n]\n\n";
      lines (List.map operation reg.operations);
      {|

# Every operation, by the name of its request channel: for code that is given a name and not a constant.
OPERATIONS: Final[Mapping[str, AnyOperation]] = MappingProxyType(
    {
|};
      lines
        (List.map
           (fun name ->
             "        " ^ Text.quoted name ^ ": " ^ constant name ^ ",")
           requests);
      {|
    }
)

# The operations that report the limits of the models a service holds credentials for: one per
# such service, each named `<flow>:limits-requested`. A new key holder's joins by being registered.
LIMITS_OPERATIONS: Final = (
|};
      lines
        (List.map
           (fun (o : R.operation) -> "    " ^ constant o.request ^ ",")
           (first :: rest));
      "\n)\n";
    ]

(* Two channels whose Python constants are one would be one constant. *)
let collisions (bus : Registry.t) =
  let seen = Hashtbl.create 256 in
  List.filter_map
    (fun (c : R.channel) ->
      let python = constant c.channel in
      match Hashtbl.find_opt seen python with
      | Some other ->
          Some
            {
              Decode.file = Registry.file;
              pointer = "/channels";
              message =
                Printf.sprintf "%S and %S would both be the Python constant %s"
                  other c.channel python;
            }
      | None ->
          Hashtbl.replace seen python c.channel;
          None)
    bus.registry.channels

let files bus : (Output.file list, Decode.error list) result =
  match collisions bus with
  | _ :: _ as problems -> Error problems
  | [] ->
      let at name text =
        { Output.path = "python/sdk/src/xynolog/" ^ name; text }
      in
      Ok
        [ at "channels.py" (channels bus); at "operations.py" (operations bus) ]
