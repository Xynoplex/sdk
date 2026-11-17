(* specs/src/client/timing.json *)

type value_value = {
  attempts : int;
  initial_delay_ms : int;
  max_delay_ms : int;
}

let value_value =
  Decode.obj (fun o : value_value ->
      {
        attempts = Decode.required o "attempts" Decode.int;
        initial_delay_ms = Decode.required o "initialDelayMs" Decode.int;
        max_delay_ms = Decode.required o "maxDelayMs" Decode.int;
      })

type value = Int of int | Object of value_value

let value =
 fun c ->
  match Decode.kind c with
  | Decode.Int -> (Int (Decode.int c) : value)
  | Decode.Object -> (Object (value_value c) : value)
  | _ -> Decode.refuse c "expected an integer or an object"

type timing_item = { name : string; value : value; docs : string }

let timing_item =
  Decode.obj (fun o : timing_item ->
      let name = Decode.required o "name" Decode.string in
      let value = Decode.required o "value" value in
      let docs = Decode.required o "docs" Decode.non_empty_string in
      { name; value; docs })

type t = { comment : string; timing : timing_item list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        timing = Decode.required o "timing" (Decode.non_empty_list timing_item);
      })
