(* specs/src/worker/chunk-plan-cases.json *)

type sizing = {
  grow_below : float;
  shrink_above : float;
  grow_factor : float;
  shrink_factor : float;
}

let sizing =
  Decode.obj (fun o : sizing ->
      {
        grow_below = Decode.required o "growBelow" Decode.number;
        shrink_above = Decode.required o "shrinkAbove" Decode.number;
        grow_factor = Decode.required o "growFactor" Decode.number;
        shrink_factor = Decode.required o "shrinkFactor" Decode.number;
      })

type limits = {
  context_tokens : int;
  max_output_tokens : int;
  output_tokens_per_hour : int option;
}

let limits =
  Decode.obj (fun o : limits ->
      {
        context_tokens = Decode.required o "contextTokens" Decode.int;
        max_output_tokens = Decode.required o "maxOutputTokens" Decode.int;
        output_tokens_per_hour =
          Decode.optional o "outputTokensPerHour" Decode.int;
      })

type budget = {
  size : int;
  overlap : int;
  floor : int;
  ceiling : int;
  output_budget : int;
}

let budget =
  Decode.obj (fun o : budget ->
      {
        size = Decode.required o "size" Decode.int;
        overlap = Decode.required o "overlap" Decode.int;
        floor = Decode.required o "floor" Decode.int;
        ceiling = Decode.required o "ceiling" Decode.int;
        output_budget = Decode.required o "outputBudget" Decode.int;
      })

type refused = { name : string }

let refused =
  Decode.obj (fun o : refused ->
      { name = Decode.required o "name" Decode.string })

type case_budget = {
  why : string;
  limits : limits;
  scaffold_tokens : int;
  types_per_call : int;
  budget : budget option;
  refused : refused option;
}

let case_budget =
  Decode.obj (fun o : case_budget ->
      Decode.required o "kind" (Decode.literal "budget");
      {
        why = Decode.required o "why" Decode.string;
        limits = Decode.required o "limits" limits;
        scaffold_tokens = Decode.required o "scaffoldTokens" Decode.int;
        types_per_call = Decode.required o "typesPerCall" Decode.int;
        budget = Decode.optional o "budget" budget;
        refused = Decode.optional o "refused" refused;
      })

type recovered = Int of int | String of string

let recovered =
 fun c ->
  match Decode.kind c with
  | Decode.Int -> (Int (Decode.int c) : recovered)
  | Decode.String -> (String (Decode.string c) : recovered)
  | _ -> Decode.refuse c "expected an integer or a string"

type outcome = { output_tokens : int option; recovered : recovered option }

let outcome =
  Decode.obj (fun o : outcome ->
      {
        output_tokens = Decode.optional o "outputTokens" Decode.int;
        recovered = Decode.optional o "recovered" recovered;
      })

type bounds = { floor : int; ceiling : int; output_budget : int }

let bounds =
  Decode.obj (fun o : bounds ->
      {
        floor = Decode.required o "floor" Decode.int;
        ceiling = Decode.required o "ceiling" Decode.int;
        output_budget = Decode.required o "outputBudget" Decode.int;
      })

type case_step = {
  why : string;
  size : int;
  outcome : outcome;
  bounds : bounds;
  next_size : int;
}

let case_step =
  Decode.obj (fun o : case_step ->
      Decode.required o "kind" (Decode.literal "step");
      {
        why = Decode.required o "why" Decode.string;
        size = Decode.required o "size" Decode.int;
        outcome = Decode.required o "outcome" outcome;
        bounds = Decode.required o "bounds" bounds;
        next_size = Decode.required o "nextSize" Decode.int;
      })

type case_walk_budget = {
  size : int;
  overlap : int;
  floor : int;
  ceiling : int;
  output_budget : int;
}

let case_walk_budget =
  Decode.obj (fun o : case_walk_budget ->
      {
        size = Decode.required o "size" Decode.int;
        overlap = Decode.required o "overlap" Decode.int;
        floor = Decode.required o "floor" Decode.int;
        ceiling = Decode.required o "ceiling" Decode.int;
        output_budget = Decode.required o "outputBudget" Decode.int;
      })

type case_walk_outcome = {
  output_tokens : int option;
  recovered : int option;
  fails : bool option;
}

let case_walk_outcome =
  Decode.obj (fun o : case_walk_outcome ->
      {
        output_tokens = Decode.optional o "outputTokens" Decode.int;
        recovered = Decode.optional o "recovered" Decode.int;
        fails = Decode.optional o "fails" Decode.bool;
      })

type piece = { at : int; to_ : int; size : int; next : int }

let piece =
  Decode.obj (fun o : piece ->
      {
        at = Decode.required o "at" Decode.int;
        to_ = Decode.required o "to" Decode.int;
        size = Decode.required o "size" Decode.int;
        next = Decode.required o "next" Decode.int;
      })

type resume = {
  next : int;
  size : int;
  found : int;
  emitted : int;
  errors : int;
}

let resume =
  Decode.obj (fun o : resume ->
      {
        next = Decode.required o "next" Decode.int;
        size = Decode.required o "size" Decode.int;
        found = Decode.required o "found" Decode.int;
        emitted = Decode.required o "emitted" Decode.int;
        errors = Decode.required o "errors" Decode.int;
      })

type case_walk = {
  why : string;
  text : string;
  budget : case_walk_budget;
  outcomes : case_walk_outcome list;
  pieces : piece list;
  completes : bool;
  resume : resume option;
}

let case_walk =
  Decode.obj (fun o : case_walk ->
      Decode.required o "kind" (Decode.literal "walk");
      {
        why = Decode.required o "why" Decode.string;
        text = Decode.required o "text" Decode.string;
        budget = Decode.required o "budget" case_walk_budget;
        outcomes = Decode.required o "outcomes" (Decode.list case_walk_outcome);
        pieces = Decode.required o "pieces" (Decode.list piece);
        completes = Decode.required o "completes" Decode.bool;
        resume = Decode.optional o "resume" resume;
      })

type verdict = { found : int; counted : int; piece_chars : int }

let verdict =
  Decode.obj (fun o : verdict ->
      {
        found = Decode.required o "found" Decode.int;
        counted = Decode.required o "counted" Decode.int;
        piece_chars = Decode.required o "pieceChars" Decode.int;
      })

type fails = {
  name : string;
  stop_reason : string option;
  salvage : string list option;
  verdict : verdict option;
}

let fails =
  Decode.obj (fun o : fails ->
      {
        name = Decode.required o "name" Decode.string;
        stop_reason = Decode.optional o "stopReason" Decode.string;
        salvage = Decode.optional o "salvage" (Decode.list Decode.string);
        verdict = Decode.optional o "verdict" verdict;
      })

type reply = {
  items : string list option;
  output_tokens : int option;
  counted : int option;
  fails : fails option;
}

let reply =
  Decode.obj (fun o : reply ->
      {
        items = Decode.optional o "items" (Decode.list Decode.string);
        output_tokens = Decode.optional o "outputTokens" Decode.int;
        counted = Decode.optional o "counted" Decode.int;
        fails = Decode.optional o "fails" fails;
      })

type under_reported_item = { found : int; counted : int; piece_chars : int }

let under_reported_item =
  Decode.obj (fun o : under_reported_item ->
      {
        found = Decode.required o "found" Decode.int;
        counted = Decode.required o "counted" Decode.int;
        piece_chars = Decode.required o "pieceChars" Decode.int;
      })

type case_descent_result_recovered = Int of int | String of string

let case_descent_result_recovered =
 fun c ->
  match Decode.kind c with
  | Decode.Int -> (Int (Decode.int c) : case_descent_result_recovered)
  | Decode.String -> (String (Decode.string c) : case_descent_result_recovered)
  | _ -> Decode.refuse c "expected an integer or a string"

type case_descent_result = {
  items : string list;
  counted : int list;
  under_reported : under_reported_item list;
  output_tokens : int option;
  recovered : case_descent_result_recovered option;
}

let case_descent_result =
  Decode.obj (fun o : case_descent_result ->
      {
        items = Decode.required o "items" (Decode.list Decode.string);
        counted = Decode.required o "counted" (Decode.list Decode.int);
        under_reported =
          Decode.required o "underReported" (Decode.list under_reported_item);
        output_tokens = Decode.optional o "outputTokens" Decode.int;
        recovered = Decode.optional o "recovered" case_descent_result_recovered;
      })

type case_descent = {
  why : string;
  piece : string;
  overlap : int;
  replies : reply list;
  asked : int list list;
  result : case_descent_result option;
  raises : int option;
}

let case_descent =
  Decode.obj (fun o : case_descent ->
      Decode.required o "kind" (Decode.literal "descent");
      {
        why = Decode.required o "why" Decode.string;
        piece = Decode.required o "piece" Decode.string;
        overlap = Decode.required o "overlap" Decode.int;
        replies = Decode.required o "replies" (Decode.list reply);
        asked = Decode.required o "asked" (Decode.list (Decode.list Decode.int));
        result = Decode.optional o "result" case_descent_result;
        raises = Decode.optional o "raises" Decode.int;
      })

type case =
  | Budget of case_budget
  | Step of case_step
  | Walk of case_walk
  | Descent of case_descent

let case =
  Decode.variant "kind"
    [
      ("budget", fun c -> (Budget (case_budget c) : case));
      ("step", fun c -> (Step (case_step c) : case));
      ("walk", fun c -> (Walk (case_walk c) : case));
      ("descent", fun c -> (Descent (case_descent c) : case));
    ]

type t = {
  comment : string;
  run_by : Case_table.run_by;
  sizing : sizing;
  cases : case list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        sizing = Decode.required o "sizing" sizing;
        cases = Decode.required o "cases" (Decode.list case);
      })
