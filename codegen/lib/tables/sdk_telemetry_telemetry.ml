(* specs/src/sdk-telemetry/telemetry.json *)

type attribute = {
  key : string;
  only : string option;
  values : string list option;
}

let attribute =
  Decode.obj (fun o : attribute ->
      {
        key = Decode.required o "key" Decode.string;
        only = Decode.optional o "only" Decode.string;
        values = Decode.optional o "values" (Decode.list Decode.string);
      })

type span = {
  name : string;
  transport : string;
  kind : string;
  meaning : string;
  attributes : attribute list;
}

let span =
  Decode.obj (fun o : span ->
      {
        name = Decode.required o "name" Decode.string;
        transport = Decode.required o "transport" Decode.string;
        kind = Decode.required o "kind" Decode.string;
        meaning = Decode.required o "meaning" Decode.string;
        attributes = Decode.required o "attributes" (Decode.list attribute);
      })

type metric_attribute = { key : string; only : string option }

let metric_attribute =
  Decode.obj (fun o : metric_attribute ->
      {
        key = Decode.required o "key" Decode.string;
        only = Decode.optional o "only" Decode.string;
      })

type metric = {
  name : string;
  transport : string;
  instrument : string;
  meaning : string;
  attributes : metric_attribute list;
}

let metric =
  Decode.obj (fun o : metric ->
      {
        name = Decode.required o "name" Decode.string;
        transport = Decode.required o "transport" Decode.string;
        instrument = Decode.required o "instrument" Decode.string;
        meaning = Decode.required o "meaning" Decode.string;
        attributes =
          Decode.required o "attributes" (Decode.list metric_attribute);
      })

type t = { comment : string; spans : span list; metrics : metric list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        spans = Decode.required o "spans" (Decode.list span);
        metrics = Decode.required o "metrics" (Decode.list metric);
      })
