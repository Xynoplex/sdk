(* specs/src/client/testing.json *)

type fault_action = {
  name : string;
  kind : string;
  docs : string;
  holds : string list;  (** The whole numbers the fault carries, by name. *)
}

type bounds = { docs : string; minimum : int; maximum : int }
type slack = { docs : string; times : int }
type delivery_ops = { docs : string; ops : string list }
type record = { name : string; docs : string; members : string list }

type t = {
  comment : string;
  fault_actions : fault_action list;
  delay_ms : bounds;
  schedule_length : bounds;
  slack : slack;
  delivery_ops : delivery_ops;
  records : record list;
}

let docs o = Decode.required o "docs" Decode.non_empty_string

let fault_action =
  Decode.obj (fun o : fault_action ->
      let name = Decode.required o "name" Decode.non_empty_string in
      let kind = Decode.required o "kind" Decode.non_empty_string in
      let docs = docs o in
      let holds =
        Decode.required o "holds" (Decode.list Decode.non_empty_string)
      in
      { name; kind; docs; holds })

let bounds =
  Decode.obj (fun o : bounds ->
      let docs = docs o in
      let minimum = Decode.required o "minimum" Decode.int in
      let maximum = Decode.required o "maximum" Decode.int in
      if minimum < 0 || maximum < minimum then
        Decode.refuse (Decode.at o) "is no range of whole numbers from 0 up";
      { docs; minimum; maximum })

let slack =
  Decode.obj (fun o : slack ->
      let docs = docs o in
      let times = Decode.required o "times" Decode.int in
      if times < 1 then Decode.refuse (Decode.at o) "gives a case no room";
      { docs; times })

let delivery_ops =
  Decode.obj (fun o : delivery_ops ->
      let docs = docs o in
      let ops =
        Decode.required o "ops" (Decode.non_empty_list Decode.non_empty_string)
      in
      { docs; ops })

let record =
  Decode.obj (fun o : record ->
      let name = Decode.required o "name" Decode.non_empty_string in
      let docs = docs o in
      let members =
        Decode.required o "members"
          (Decode.non_empty_list Decode.non_empty_string)
      in
      { name; docs; members })

let decode =
  Decode.obj (fun o : t ->
      let comment = Decode.required o "$comment" Decode.string in
      let fault_actions =
        Decode.required o "faultActions" (Decode.non_empty_list fault_action)
      in
      let delay_ms = Decode.required o "delayMs" bounds in
      let schedule_length = Decode.required o "scheduleLength" bounds in
      let slack = Decode.required o "slack" slack in
      let delivery_ops = Decode.required o "deliveryOps" delivery_ops in
      let records =
        Decode.required o "records" (Decode.non_empty_list record)
      in
      if schedule_length.minimum < 1 then
        Decode.refuse (Decode.at o) "lets a schedule be of no faults";
      {
        comment;
        fault_actions;
        delay_ms;
        schedule_length;
        slack;
        delivery_ops;
        records;
      })
