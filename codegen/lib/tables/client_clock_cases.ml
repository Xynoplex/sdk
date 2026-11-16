(* specs/src/client/clock-cases.json *)

type pass_pass = { timing : string; times : float option; plus_ms : int option }

let pass_pass =
  Decode.obj (fun o : pass_pass ->
      {
        timing = Decode.required o "timing" Decode.string;
        times = Decode.optional o "times" Decode.number;
        plus_ms = Decode.optional o "plusMs" Decode.int;
      })

type pass = Int of int | Object of pass_pass

let pass =
 fun c ->
  match Decode.kind c with
  | Decode.Int -> (Int (Decode.int c) : pass)
  | Decode.Object -> (Object (pass_pass c) : pass)
  | _ -> Decode.refuse c "expected an integer or an object"

type step_step = { counted : int option; pass : pass option }

let step_step =
  Decode.obj (fun o : step_step ->
      {
        counted = Decode.optional o "counted" Decode.int;
        pass = Decode.optional o "pass" pass;
      })

type step = String of string | Object of step_step

let step =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : step)
  | Decode.Object -> (Object (step_step c) : step)
  | _ -> Decode.refuse c "expected a string or an object"

type given = {
  retry_after_seconds : int option;
  lifetime_seconds : int option;
  answers : string list option;
  interval_seconds : int option;
}

let given =
  Decode.obj (fun o : given ->
      {
        retry_after_seconds = Decode.optional o "retryAfterSeconds" Decode.int;
        lifetime_seconds = Decode.optional o "lifetimeSeconds" Decode.int;
        answers = Decode.optional o "answers" (Decode.list Decode.string);
        interval_seconds = Decode.optional o "intervalSeconds" Decode.int;
      })

type case = {
  subject : string;
  case : string;
  steps : step list;
  given : given option;
}

let case =
  Decode.obj (fun o : case ->
      {
        subject = Decode.required o "subject" Decode.string;
        case = Decode.required o "case" Decode.string;
        steps = Decode.required o "steps" (Decode.list step);
        given = Decode.optional o "given" given;
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
