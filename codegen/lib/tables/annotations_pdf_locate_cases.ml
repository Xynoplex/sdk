(* specs/src/annotations/pdf-locate-cases.json *)

type item = {
  start : int;
  end_ : int;
  page : int;
  x : float;
  y : float;
  width : int;
  height : int;
}

let item =
  Decode.obj (fun o : item ->
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
        page = Decode.required o "page" Decode.int;
        x = Decode.required o "x" Decode.number;
        y = Decode.required o "y" Decode.number;
        width = Decode.required o "width" Decode.int;
        height = Decode.required o "height" Decode.int;
      })

type anchored = { text : string; items : item list }

let anchored =
  Decode.obj (fun o : anchored ->
      {
        text = Decode.required o "text" Decode.string;
        items = Decode.required o "items" (Decode.list item);
      })

type span = { start : int; end_ : int }

let span =
  Decode.obj (fun o : span ->
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type overlapping_item = {
  start : int;
  end_ : int;
  page : int;
  x : float;
  y : float;
  width : int;
  height : int;
}

let overlapping_item =
  Decode.obj (fun o : overlapping_item ->
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
        page = Decode.required o "page" Decode.int;
        x = Decode.required o "x" Decode.number;
        y = Decode.required o "y" Decode.number;
        width = Decode.required o "width" Decode.int;
        height = Decode.required o "height" Decode.int;
      })

type rect = { page : int; x : float; y : float; width : int; height : float }

let rect =
  Decode.obj (fun o : rect ->
      {
        page = Decode.required o "page" Decode.int;
        x = Decode.required o "x" Decode.number;
        y = Decode.required o "y" Decode.number;
        width = Decode.required o "width" Decode.int;
        height = Decode.required o "height" Decode.number;
      })

type case = {
  why : string;
  anchored : anchored;
  span : span;
  overlapping : overlapping_item list;
  rects : rect list;
  fragments : string list;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        anchored = Decode.required o "anchored" anchored;
        span = Decode.required o "span" span;
        overlapping =
          Decode.required o "overlapping" (Decode.list overlapping_item);
        rects = Decode.required o "rects" (Decode.list rect);
        fragments = Decode.required o "fragments" (Decode.list Decode.string);
      })

type claim_span = { start : int; end_ : int }

let claim_span =
  Decode.obj (fun o : claim_span ->
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type claim = {
  why : string;
  text : string;
  claim : string;
  spans : claim_span list;
}

let claim =
  Decode.obj (fun o : claim ->
      {
        why = Decode.required o "why" Decode.string;
        text = Decode.required o "text" Decode.string;
        claim = Decode.required o "claim" Decode.string;
        spans = Decode.required o "spans" (Decode.list claim_span);
      })

type landing_item_item = {
  start : int;
  end_ : int;
  page : int;
  x : int;
  y : int;
  width : int;
  height : int;
}

let landing_item_item =
  Decode.obj (fun o : landing_item_item ->
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
        page = Decode.required o "page" Decode.int;
        x = Decode.required o "x" Decode.int;
        y = Decode.required o "y" Decode.int;
        width = Decode.required o "width" Decode.int;
        height = Decode.required o "height" Decode.int;
      })

type landed = { page : int; x : float; y : int }

let landed =
  Decode.obj (fun o : landed ->
      {
        page = Decode.required o "page" Decode.int;
        x = Decode.required o "x" Decode.number;
        y = Decode.required o "y" Decode.int;
      })

type landing_item_span = { start : int; end_ : int }

let landing_item_span =
  Decode.obj (fun o : landing_item_span ->
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type landing_item = {
  why : string;
  text : string;
  items : landing_item_item list;
  claim : string;
  landed : landed;
  span : landing_item_span option;
}

let landing_item =
  Decode.obj (fun o : landing_item ->
      {
        why = Decode.required o "why" Decode.string;
        text = Decode.required o "text" Decode.string;
        items = Decode.required o "items" (Decode.list landing_item_item);
        claim = Decode.required o "claim" Decode.string;
        landed = Decode.required o "landed" landed;
        span = Decode.required o "span" (Decode.nullable landing_item_span);
      })

type t = {
  comment : string;
  cases : case list;
  claims : claim list;
  landing : landing_item list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
        claims = Decode.required o "claims" (Decode.list claim);
        landing = Decode.required o "landing" (Decode.list landing_item);
      })
