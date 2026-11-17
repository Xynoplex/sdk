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

let banner =
  {|// Code generated from protocol/specs/src/bus/registry.json — DO NOT EDIT.
//
// Regenerate: make generate (codegen/lib/bus/go.ml)
|}

(* [mark:delegate-timeout] is [MarkDelegateTimeout]. *)
let name channel =
  String.concat ""
    (List.map String.capitalize_ascii
       (String.split_on_char ':' channel
       |> List.concat_map (String.split_on_char '-')))

(* Rows aligned to their longest first cell, as gofmt aligns them. *)
let aligned rows =
  let width = List.fold_left (fun w (k, _) -> max w (Text.length k)) 0 rows in
  String.concat "\n"
    (List.map
       (fun (k, v) ->
         "\t" ^ k ^ String.make (width - Text.length k) ' ' ^ " " ^ v)
       rows)

let type_of (carried : Registry.carried) =
  match carried with
  | Component schema -> "api." ^ schema
  | Response schema -> "Response[api." ^ schema ^ "]"
  | Nothing -> "Empty"

let typed (bus : Registry.t) channel =
  type_of (Registry.carried (bus.channel channel))

(* A channel's typed value: what it carries, and whether it is emitted, read
   for a resource, or of the record. A scoped channel is a stored event. *)
let value (bus : Registry.t) (c : R.channel) =
  let type_ = type_of (Registry.carried c) in
  match c.payload with
  | Stored_event { payload; _ } ->
      (if List.mem c.channel bus.registry.audience.scoped then "Scoped"
       else "Recorded")
      ^ "[" ^ type_ ^ ", api." ^ payload ^ "]"
  | _ ->
      (if Option.is_some (Registry.validate_of c) then "Emittable" else "Of")
      ^ "[" ^ type_ ^ "]"

let channels (bus : Registry.t) =
  let reg = bus.registry in
  let requests = List.map (fun (o : R.operation) -> o.request) reg.operations in
  let rows =
    List.filter_map
      (fun (c : R.channel) ->
        if List.mem c.channel requests then None
        else
          Some
            ( name c.channel,
              "= " ^ value bus c ^ "{" ^ Text.quoted c.channel ^ "}" ))
      reg.channels
  in
  String.concat ""
    [
      banner;
      {|
package bus

import "github.com/xynolog/sdk/go/api"

// Channel is a bus channel's name: what a channel chosen at run time is
// given as, and what each typed value below is named by.
type Channel string

// Every channel that is no operation's request, typed by the payload it
// carries. An operation's request is the operation (operations_gen.go).
var (
|};
      aligned rows;
      "\n)\n\n";
      Text.go_comment ~indent:"" reg.trace.meaning;
      "\nconst TraceField = ";
      Text.quoted reg.trace.field;
      "\n";
    ]

let operations (bus : Registry.t) =
  let reg = bus.registry in
  let shape (o : R.operation) =
    String.concat ", " (List.map (typed bus) [ o.request; o.result; o.failure ])
  in
  let rows =
    List.map
      (fun (o : R.operation) ->
        ( name o.request,
          "= Operation[" ^ shape o ^ "]{"
          ^ String.concat ", "
              (List.map Text.quoted [ o.request; o.result; o.failure ])
          ^ "}" ))
      reg.operations
  in
  let replies =
    List.map
      (fun (o : R.operation) ->
        let named =
          match List.assoc o.request bus.reply_names with
          | [] -> ""
          | names ->
              ", ReplyNames: []string{"
              ^ String.concat ", " (List.map Text.quoted names)
              ^ "}"
        in
        ( Text.quoted o.request ^ ":",
          "{Result: " ^ Text.quoted o.result ^ ", Failure: "
          ^ Text.quoted o.failure ^ ", FailurePayload: reflect.TypeFor["
          ^ typed bus o.failure ^ "]()" ^ named ^ "}," ))
      reg.operations
  in
  let first, rest = bus.limits in
  String.concat ""
    [
      banner;
      {|
package bus

import (
	"reflect"

	"github.com/xynolog/sdk/go/api"
)

// Every operation, named for its request channel and typed by what it sends
// and what each of its replies carries.
var (
|};
      aligned rows;
      {|
)

// LimitsOperations is the operations that report the limits of the models a
// service holds credentials for: one per such service, each named
// <flow>:limits-requested. A new key holder's joins by being registered.
var LimitsOperations = []Operation[|};
      shape first;
      "]{\n";
      String.concat "\n"
        (List.map
           (fun (o : R.operation) -> "\t" ^ name o.request ^ ",")
           (first :: rest));
      {|
}

// Replies is the two channels a request is answered on, the type its
// failure is read as, and what its result states beside its response.
type Replies struct {
	Result  Channel
	Failure Channel
	// FailurePayload is the type of what the failure channel carries: a
	// failure is held to its shape before it is read.
	FailurePayload reflect.Type
	// ReplyNames is what the result states beside its response: properties of
	// the request, which whoever answers states again (the resource a context
	// was gathered for, the reference a search was for). None, for most.
	ReplyNames []string
}

// Operations is each operation's replies, by the name of its request
// channel: for a request named at run time. |};
      string_of_int (List.length reg.operations);
      " operations.\nvar Operations = map[Channel]Replies{\n";
      aligned replies;
      "\n}\n";
    ]

let bridged (bus : Registry.t) =
  let reg = bus.registry in
  let listed channels =
    String.concat "\n" (List.map (fun c -> "\t" ^ Text.quoted c ^ ",") channels)
  in
  String.concat ""
    [
      banner;
      {|
package bus

// BridgedBroadcasts: channels with no owning operation — job lifecycle, KB
// vocabulary changes, attention signals, SSE infrastructure. These are what a
// client subscribes to when it wants to watch a KB rather than await a reply.
var BridgedBroadcasts = []Channel{
|};
      listed reg.audience.everyone;
      {|
}

// BridgedChannels: everything a transport delivers — the broadcasts plus
// every operation's reply channels. Derived from Operations, so a reply can
// never be missing from the set (the recurring unbridged-reply bug).
var BridgedChannels = func() []Channel {
	out := append([]Channel(nil), BridgedBroadcasts...)
	for _, op := range Operations {
		out = append(out, op.Result, op.Failure)
	}
	return out
}()

// Bridged reports whether a channel can be received over a transport at all.
// Subscribing to anything else delivers nothing, silently — the trap the bus
// docs warn about.
func Bridged(c Channel) bool {
	for _, b := range BridgedChannels {
		if b == c {
			return true
		}
	}
	return false
}

// ResourceScopedChannels: the channels a resource's scope carries, which a
// client holding the scope names in that scope's entry of its subscription.
// Disjoint from BridgedChannels: a channel in both would reach a client twice,
// under two ids.
var ResourceScopedChannels = []Channel{
|};
      listed reg.audience.scoped;
      {|
}

// PersistedEventTypes: the channels of the events of the record, each named
// for the event it carries: every event the event log holds. A follower of the
// record receives each of them (protocol/contract/TRANSPORT-CONTRACT.md § What
// repairs a passing frame).
var PersistedEventTypes = []Channel{
|};
      listed
        (List.filter_map
           (fun (c : R.channel) ->
             if Registry.is_recorded c then Some c.channel else None)
           reg.channels);
      "\n}\n";
    ]

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
