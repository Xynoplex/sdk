(* specs/src/service-telemetry/telemetry.json *)

type sdk = {
  dispatcher : string list;
  archivist : string list;
  worker : string list;
  weaver : string list;
  smelter : string list;
  librarian : string list;
}

let sdk =
  Decode.obj (fun o : sdk ->
      {
        dispatcher = Decode.required o "dispatcher" (Decode.list Decode.string);
        archivist = Decode.required o "archivist" (Decode.list Decode.string);
        worker = Decode.required o "worker" (Decode.list Decode.string);
        weaver = Decode.required o "weaver" (Decode.list Decode.string);
        smelter = Decode.required o "smelter" (Decode.list Decode.string);
        librarian = Decode.required o "librarian" (Decode.list Decode.string);
      })

type resource_item = { key : string; services : string list; meaning : string }

let resource_item =
  Decode.obj (fun o : resource_item ->
      {
        key = Decode.required o "key" Decode.string;
        services = Decode.required o "services" (Decode.list Decode.string);
        meaning = Decode.required o "meaning" Decode.string;
      })

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
  services : string list;
  kind : string;
  when_ : string;
  meaning : string;
  attributes : attribute list;
}

let span =
  Decode.obj (fun o : span ->
      {
        name = Decode.required o "name" Decode.string;
        services = Decode.required o "services" (Decode.list Decode.string);
        kind = Decode.required o "kind" Decode.string;
        when_ = Decode.required o "when" Decode.string;
        meaning = Decode.required o "meaning" Decode.string;
        attributes = Decode.required o "attributes" (Decode.list attribute);
      })

type metric_attribute = {
  key : string;
  only : string option;
  values : string list option;
}

let metric_attribute =
  Decode.obj (fun o : metric_attribute ->
      {
        key = Decode.required o "key" Decode.string;
        only = Decode.optional o "only" Decode.string;
        values = Decode.optional o "values" (Decode.list Decode.string);
      })

type metric = {
  name : string;
  services : string list;
  instrument : string;
  when_ : string;
  meaning : string;
  attributes : metric_attribute list;
  planes : string list option;
}

let metric =
  Decode.obj (fun o : metric ->
      {
        name = Decode.required o "name" Decode.string;
        services = Decode.required o "services" (Decode.list Decode.string);
        instrument = Decode.required o "instrument" Decode.string;
        when_ = Decode.required o "when" Decode.string;
        meaning = Decode.required o "meaning" Decode.string;
        attributes =
          Decode.required o "attributes" (Decode.list metric_attribute);
        planes = Decode.optional o "planes" (Decode.list Decode.string);
      })

type t = {
  comment : string;
  sdk : sdk;
  resource : resource_item list;
  spans : span list;
  metrics : metric list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        sdk = Decode.required o "sdk" sdk;
        resource = Decode.required o "resource" (Decode.list resource_item);
        spans = Decode.required o "spans" (Decode.list span);
        metrics = Decode.required o "metrics" (Decode.list metric);
      })
