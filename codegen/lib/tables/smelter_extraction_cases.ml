(* specs/src/smelter/extraction-cases.json *)

type case_bytes = { utf8 : string option; length : int option }

let case_bytes =
  Decode.obj (fun o : case_bytes ->
      {
        utf8 = Decode.optional o "utf8" Decode.string;
        length = Decode.optional o "length" Decode.int;
      })

type case = {
  why : string;
  fixture : string option;
  pdf_class : string option;
  method_ : string option;
  pages_with_items : int option;
  words : string list option;
  on_page : (string * int) list option;
  absent : string list option;
  rows : string list list option;
  unread_pages : int list option;
  declined : string option;
  bytes : case_bytes option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        fixture = Decode.optional o "fixture" Decode.string;
        pdf_class = Decode.optional o "pdfClass" Decode.string;
        method_ = Decode.optional o "method" Decode.string;
        pages_with_items = Decode.optional o "pagesWithItems" Decode.int;
        words = Decode.optional o "words" (Decode.list Decode.string);
        on_page = Decode.optional o "onPage" (Decode.map Decode.int);
        absent = Decode.optional o "absent" (Decode.list Decode.string);
        rows =
          Decode.optional o "rows" (Decode.list (Decode.list Decode.string));
        unread_pages = Decode.optional o "unreadPages" (Decode.list Decode.int);
        declined = Decode.optional o "declined" Decode.string;
        bytes = Decode.optional o "bytes" case_bytes;
      })

type t = {
  comment : string;
  fixtures : string;
  largest_pdf_bytes : int;
  cases : case list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        fixtures = Decode.required o "fixtures" Decode.string;
        largest_pdf_bytes = Decode.required o "largestPdfBytes" Decode.int;
        cases = Decode.required o "cases" (Decode.list case);
      })
