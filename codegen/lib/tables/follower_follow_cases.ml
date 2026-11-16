(* specs/src/follower/follow-cases.json *)

type fold = {
  uses : string list;
  refuses : (string * int) list;
  fails : (string * int * int) list;
}

let fold =
  Decode.obj (fun o : fold ->
      {
        uses = Decode.required o "uses" (Decode.list Decode.string);
        refuses =
          Decode.required o "refuses"
            (Decode.list (Decode.pair Decode.string Decode.int));
        fails =
          Decode.required o "fails"
            (Decode.list (Decode.triple Decode.string Decode.int Decode.int));
      })

type step_start = { start : bool }

let step_start =
  Decode.obj (fun o : step_start ->
      { start = Decode.required o "start" Decode.bool })

type step_record = { record : string * string }

let step_record =
  Decode.obj (fun o : step_record ->
      {
        record =
          Decode.required o "record" (Decode.pair Decode.string Decode.string);
      })

type step_deliver = { deliver : string * int }

let step_deliver =
  Decode.obj (fun o : step_deliver ->
      {
        deliver =
          Decode.required o "deliver" (Decode.pair Decode.string Decode.int);
      })

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
  taken : (string * (int * string) list) list;
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
        taken =
          Decode.required o "taken"
            (Decode.map (Decode.list (Decode.pair Decode.int Decode.string)));
        cursors_after = Decode.required o "cursorsAfter" (Decode.map Decode.int);
        stopped = Decode.required o "stopped" (Decode.list Decode.string);
        started_own_way =
          Decode.required o "startedOwnWay" (Decode.list Decode.string);
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
