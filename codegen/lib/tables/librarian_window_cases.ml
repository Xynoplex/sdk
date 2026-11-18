(* specs/src/librarian/window-cases.json *)

type selector_item_text_position_selector = { start : int; end_ : int }

let selector_item_text_position_selector =
  Decode.obj (fun o : selector_item_text_position_selector ->
      Decode.required o "type" (Decode.literal "TextPositionSelector");
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type selector_item_text_quote_selector = {
  exact : string;
  prefix : string;
  suffix : string;
}

let selector_item_text_quote_selector =
  Decode.obj (fun o : selector_item_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      {
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type selector_item =
  | Text_position_selector of selector_item_text_position_selector
  | Text_quote_selector of selector_item_text_quote_selector

let selector_item =
  Decode.variant "type"
    [
      ( "TextPositionSelector",
        fun c ->
          (Text_position_selector (selector_item_text_position_selector c)
            : selector_item) );
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector (selector_item_text_quote_selector c)
            : selector_item) );
    ]

type selector_selector_text_position_selector = { start : int; end_ : int }

let selector_selector_text_position_selector =
  Decode.obj (fun o : selector_selector_text_position_selector ->
      Decode.required o "type" (Decode.literal "TextPositionSelector");
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type selector_selector_text_quote_selector = {
  exact : string;
  suffix : string option;
}

let selector_selector_text_quote_selector =
  Decode.obj (fun o : selector_selector_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      {
        exact = Decode.required o "exact" Decode.string;
        suffix = Decode.optional o "suffix" Decode.string;
      })

type selector_selector =
  | Text_position_selector of selector_selector_text_position_selector
  | Text_quote_selector of selector_selector_text_quote_selector

let selector_selector =
  Decode.variant "type"
    [
      ( "TextPositionSelector",
        fun c ->
          (Text_position_selector (selector_selector_text_position_selector c)
            : selector_selector) );
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector (selector_selector_text_quote_selector c)
            : selector_selector) );
    ]

type selector = Array of selector_item list | Object of selector_selector

let selector =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list selector_item c) : selector)
  | Decode.Object -> (Object (selector_selector c) : selector)
  | _ -> Decode.refuse c "expected an array or an object"

type window = { before : int; after : int }

let window =
  Decode.obj (fun o : window ->
      {
        before = Decode.required o "before" Decode.int;
        after = Decode.required o "after" Decode.int;
      })

type context = { before : string; selected : string; after : string }

let context =
  Decode.obj (fun o : context ->
      {
        before = Decode.required o "before" Decode.string;
        selected = Decode.required o "selected" Decode.string;
        after = Decode.required o "after" Decode.string;
      })

type around = {
  text : string;
  selector : selector option;
  window : window;
  context : context option;
  refused : bool option;
}

let around =
  Decode.obj (fun o : around ->
      {
        text = Decode.required o "text" Decode.string;
        selector = Decode.optional o "selector" selector;
        window = Decode.required o "window" window;
        context = Decode.optional o "context" context;
        refused = Decode.optional o "refused" Decode.bool;
      })

type gathered_selector_selector_item_text_position_selector = {
  start : int;
  end_ : int;
}

let gathered_selector_selector_item_text_position_selector =
  Decode.obj (fun o : gathered_selector_selector_item_text_position_selector ->
      Decode.required o "type" (Decode.literal "TextPositionSelector");
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type gathered_selector_selector_item_text_quote_selector = {
  exact : string;
  prefix : string option;
  suffix : string option;
}

let gathered_selector_selector_item_text_quote_selector =
  Decode.obj (fun o : gathered_selector_selector_item_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      {
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.optional o "prefix" Decode.string;
        suffix = Decode.optional o "suffix" Decode.string;
      })

type gathered_selector_selector_item_svg_selector = { value : string }

let gathered_selector_selector_item_svg_selector =
  Decode.obj (fun o : gathered_selector_selector_item_svg_selector ->
      Decode.required o "type" (Decode.literal "SvgSelector");
      { value = Decode.required o "value" Decode.string })

type gathered_selector_selector_item =
  | Text_position_selector of
      gathered_selector_selector_item_text_position_selector
  | Text_quote_selector of gathered_selector_selector_item_text_quote_selector
  | Svg_selector of gathered_selector_selector_item_svg_selector

let gathered_selector_selector_item =
  Decode.variant "type"
    [
      ( "TextPositionSelector",
        fun c ->
          (Text_position_selector
             (gathered_selector_selector_item_text_position_selector c)
            : gathered_selector_selector_item) );
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector
             (gathered_selector_selector_item_text_quote_selector c)
            : gathered_selector_selector_item) );
      ( "SvgSelector",
        fun c ->
          (Svg_selector (gathered_selector_selector_item_svg_selector c)
            : gathered_selector_selector_item) );
    ]

type gathered_selector_selector_text_position_selector = {
  start : int;
  end_ : int;
}

let gathered_selector_selector_text_position_selector =
  Decode.obj (fun o : gathered_selector_selector_text_position_selector ->
      Decode.required o "type" (Decode.literal "TextPositionSelector");
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type gathered_selector_selector_text_quote_selector = {
  exact : string;
  prefix : string option;
}

let gathered_selector_selector_text_quote_selector =
  Decode.obj (fun o : gathered_selector_selector_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      {
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.optional o "prefix" Decode.string;
      })

type gathered_selector_selector_svg_selector = { value : string }

let gathered_selector_selector_svg_selector =
  Decode.obj (fun o : gathered_selector_selector_svg_selector ->
      Decode.required o "type" (Decode.literal "SvgSelector");
      { value = Decode.required o "value" Decode.string })

type gathered_selector_selector =
  | Text_position_selector of gathered_selector_selector_text_position_selector
  | Text_quote_selector of gathered_selector_selector_text_quote_selector
  | Svg_selector of gathered_selector_selector_svg_selector

let gathered_selector_selector =
  Decode.variant "type"
    [
      ( "TextPositionSelector",
        fun c ->
          (Text_position_selector
             (gathered_selector_selector_text_position_selector c)
            : gathered_selector_selector) );
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector
             (gathered_selector_selector_text_quote_selector c)
            : gathered_selector_selector) );
      ( "SvgSelector",
        fun c ->
          (Svg_selector (gathered_selector_selector_svg_selector c)
            : gathered_selector_selector) );
    ]

type gathered_selector =
  | Array of gathered_selector_selector_item list
  | Object of gathered_selector_selector

let gathered_selector =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list gathered_selector_selector_item c)
        : gathered_selector)
  | Decode.Object -> (Object (gathered_selector_selector c) : gathered_selector)
  | _ -> Decode.refuse c "expected an array or an object"

type gathered_context = { before : string; selected : string; after : string }

let gathered_context =
  Decode.obj (fun o : gathered_context ->
      {
        before = Decode.required o "before" Decode.string;
        selected = Decode.required o "selected" Decode.string;
        after = Decode.required o "after" Decode.string;
      })

type gathered = {
  text : string;
  selector : gathered_selector option;
  window : int;
  context : gathered_context option option;
  refused : bool option;
}

let gathered =
  Decode.obj (fun o : gathered ->
      {
        text = Decode.required o "text" Decode.string;
        selector = Decode.optional o "selector" gathered_selector;
        window = Decode.required o "window" Decode.int;
        context = Decode.optional o "context" (Decode.nullable gathered_context);
        refused = Decode.optional o "refused" Decode.bool;
      })

type case = { why : string; around : around option; gathered : gathered option }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        around = Decode.optional o "around" around;
        gathered = Decode.optional o "gathered" gathered;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
