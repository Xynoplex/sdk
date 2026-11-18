(* A kind of id's pattern, as the check that holds a value to it. The patterns
   it knows are the ones the kinds use: anchored at both ends, text every
   value begins with, and then one set of characters a stated number of
   times, counted in code points. Anything else is refused. *)

module K = Kotlin_syntax

type t = {
  prefix : string;
  admitted : K.expr;  (** Whether the code point [c] is admitted. *)
  least : int;
  most : int option;
}

let refuse = Names.refuse
let code c = K.Member (K.Char c, "code")
let either a b = K.Binary (a, K.Or, b)

(* A character set ([A-Za-z0-9_-]) as a predicate over [c]: ranges and
   single characters, a [-] at either end being itself. *)
let set text =
  if
    text = ""
    || text.[0] = '^'
    || String.exists (fun c -> c = '\\' || c = '[' || c = '\'') text
  then None
  else
    let n = String.length text in
    let rec arms at =
      if at >= n then []
      else if at + 2 < n && text.[at + 1] = '-' then
        K.Binary
          ( K.Name "c",
            K.In,
            K.Binary (code text.[at], K.Range, code text.[at + 2]) )
        :: arms (at + 3)
      else K.Binary (K.Name "c", K.Eq, code text.[at]) :: arms (at + 1)
    in
    match arms 0 with
    | [] -> None
    | first :: rest -> Some (List.fold_left either first rest)

let of_pattern kind pattern =
  let cannot () =
    refuse "%s: a pattern the generator cannot write as a check: %s" kind
      pattern
  in
  let n = String.length pattern in
  if n < 2 || pattern.[0] <> '^' || pattern.[n - 1] <> '$' then cannot ();
  let body = String.sub pattern 1 (n - 2) in
  let set_at =
    match
      (String.index_from_opt body 0 '[', String.index_from_opt body 0 '\\')
    with
    | Some a, Some b -> min a b
    | Some a, None | None, Some a -> a
    | None, None -> cannot ()
  in
  let prefix = String.sub body 0 set_at in
  if String.exists (fun c -> String.contains ".|?*+(){}^$]" c) prefix then
    cannot ();
  let rest = String.sub body set_at (String.length body - set_at) in
  let after k = String.sub rest k (String.length rest - k) in
  let admitted, times =
    if String.starts_with ~prefix:"\\S" rest then
      (K.Not (K.call (K.Name "isWhitespace") [ K.Name "c" ]), after 2)
    else
      match (rest.[0], String.index_opt rest ']') with
      | '[', Some close -> (
          match set (String.sub rest 1 (close - 1)) with
          | Some admitted -> (admitted, after (close + 1))
          | None -> cannot ())
      | _ -> cannot ()
  in
  let number text =
    match int_of_string_opt text with
    | Some n when n >= 0 && String.for_all (fun c -> c >= '0' && c <= '9') text
      ->
        n
    | _ -> cannot ()
  in
  let least, most =
    match times with
    | "+" -> (1, None)
    | "*" -> (0, None)
    | _
      when String.length times >= 2
           && times.[0] = '{'
           && times.[String.length times - 1] = '}' -> (
        let bounds = String.sub times 1 (String.length times - 2) in
        match String.index_opt bounds ',' with
        | Some comma ->
            let low = String.sub bounds 0 comma in
            let high =
              String.sub bounds (comma + 1) (String.length bounds - comma - 1)
            in
            (number low, if high = "" then None else Some (number high))
        | None ->
            let exactly = number bounds in
            (exactly, Some exactly))
    | _ -> cannot ()
  in
  { prefix; admitted; least; most }

(* The body of [admits(value: String): Boolean]. *)
let check { prefix; admitted; least; most } : K.body =
  let subject = if prefix = "" then "value" else "rest" in
  let count =
    K.call
      (K.Name (subject ^ ".codePointCount"))
      [ K.Int 0; K.Name (subject ^ ".length") ]
  in
  let counted =
    match (least, most) with
    | 0, None -> None
    | least, None -> Some (K.Binary (count, K.Ge, K.Int least))
    | least, Some most ->
        Some
          (K.Binary (count, K.In, K.Binary (K.Int least, K.Range, K.Int most)))
  in
  let all =
    K.call
      ~lambda:(K.Lambda ([ "c" ], admitted))
      (K.Member (K.call (K.Name (subject ^ ".codePoints")) [], "allMatch"))
      []
  in
  let returned =
    match counted with
    | None -> all
    | Some counted -> K.Binary (counted, K.And, all)
  in
  if prefix = "" then K.Same_line returned
  else
    K.Block
      [
        K.If_then
          ( K.Not (K.call (K.Name "value.startsWith") [ K.Str prefix ]),
            K.Return (K.Bool false) );
        K.Val
          ( "rest",
            K.call (K.Name "value.substring") [ K.Int (String.length prefix) ]
          );
        K.Return returned;
      ]
