(* What every case table carries beside its cases (specs/README.md, "Case
   tables"): the rule it states, the consumers that run it, and why an
   implementation does not yet. *)

(* Each runner, with the consumer-owned test locations that run the table. *)
type run_by = (string * string list) list

let run_by = Decode.map (Decode.non_empty_list Decode.non_empty_string)

(* Each implementation, with why it does not run the table. *)
type explanations = (string * string) list

let explanations = Decode.map Decode.non_empty_string
