(* specs/src/follower/follow-cases.json *)

type event = { log : string; sequence : int }

let event =
  Decode.obj (fun o : event ->
      {
        log = Decode.required o "log" Decode.string;
        sequence = Decode.required o "sequence" Decode.int;
      })

type failing = { log : string; sequence : int; times : int }

let failing =
  Decode.obj (fun o : failing ->
      {
        log = Decode.required o "log" Decode.string;
        sequence = Decode.required o "sequence" Decode.int;
        times = Decode.required o "times" Decode.int;
      })

type recorded = { log : string; type_ : string }

let recorded =
  Decode.obj (fun o : recorded ->
      {
        log = Decode.required o "log" Decode.string;
        type_ = Decode.required o "type" Decode.string;
      })

type taking = { sequence : int; how : string }

let taking =
  Decode.obj (fun o : taking ->
      {
        sequence = Decode.required o "sequence" Decode.int;
        how = Decode.required o "how" Decode.string;
      })

type fold = { uses : string list; refuses : event list; fails : failing list }

let fold =
  Decode.obj (fun o : fold ->
      {
        uses = Decode.required o "uses" (Decode.list Decode.string);
        refuses = Decode.required o "refuses" (Decode.list event);
        fails = Decode.required o "fails" (Decode.list failing);
      })

type step_start = { start : bool }

let step_start =
  Decode.obj (fun o : step_start ->
      { start = Decode.required o "start" Decode.bool })

type step_record = { record : recorded }

let step_record =
  Decode.obj (fun o : step_record ->
      { record = Decode.required o "record" recorded })

type step_deliver = { deliver : event }

let step_deliver =
  Decode.obj (fun o : step_deliver ->
      { deliver = Decode.required o "deliver" event })

type step_drop = { drop : bool }

let step_drop =
  Decode.obj (fun o : step_drop ->
      { drop = Decode.required o "drop" Decode.bool })

type step_reopen = { reopen : bool }

let step_reopen =
  Decode.obj (fun o : step_reopen ->
      { reopen = Decode.required o "reopen" Decode.bool })

type step =
  | Start of step_start
  | Record of step_record
  | Deliver of step_deliver
  | Drop of step_drop
  | Reopen of step_reopen

let step =
  Decode.keyed
    [
      ("start", fun c -> (Start (step_start c) : step));
      ("record", fun c -> (Record (step_record c) : step));
      ("deliver", fun c -> (Deliver (step_deliver c) : step));
      ("drop", fun c -> (Drop (step_drop c) : step));
      ("reopen", fun c -> (Reopen (step_reopen c) : step));
    ]

type case = {
  why : string;
  record : (string * string list) list;
  fold : fold;
  follows : string list;
  cursors : (string * int) list;
  with_no_cursor : string;
  steps : step list;
  taken : (string * taking list) list;
  cursors_after : (string * int) list;
  stopped : string list;
  started_own_way : string list;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        record =
          Decode.required o "record" (Decode.map (Decode.list Decode.string));
        fold = Decode.required o "fold" fold;
        follows = Decode.required o "follows" (Decode.list Decode.string);
        cursors = Decode.required o "cursors" (Decode.map Decode.int);
        with_no_cursor = Decode.required o "withNoCursor" Decode.string;
        steps = Decode.required o "steps" (Decode.list step);
        taken = Decode.required o "taken" (Decode.map (Decode.list taking));
        cursors_after = Decode.required o "cursorsAfter" (Decode.map Decode.int);
        stopped = Decode.required o "stopped" (Decode.list Decode.string);
        started_own_way =
          Decode.required o "startedOwnWay" (Decode.list Decode.string);
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
