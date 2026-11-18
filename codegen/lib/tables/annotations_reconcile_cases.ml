(* specs/src/annotations/reconcile-cases.json *)

type quoted = { exact : string; prefix : string option; suffix : string option }

let quoted =
  Decode.obj (fun o : quoted ->
      {
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.optional o "prefix" Decode.string;
        suffix = Decode.optional o "suffix" Decode.string;
      })

type reconciled = {
  start : int;
  end_ : int;
  exact : string;
  prefix : string option;
  suffix : string option;
  anchor_method : string;
  match_quality : string option;
}

let reconciled =
  Decode.obj (fun o : reconciled ->
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.optional o "prefix" Decode.string;
        suffix = Decode.optional o "suffix" Decode.string;
        anchor_method = Decode.required o "anchorMethod" Decode.string;
        match_quality = Decode.optional o "matchQuality" Decode.string;
      })

type case = {
  why : string;
  text : string;
  quoted : quoted;
  reconciled : reconciled option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        text = Decode.required o "text" Decode.string;
        quoted = Decode.required o "quoted" quoted;
        reconciled = Decode.required o "reconciled" (Decode.nullable reconciled);
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
