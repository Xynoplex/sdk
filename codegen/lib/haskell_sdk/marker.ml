(* A section of a hand-written source the Haskell SDK derives from, found
   between two markers. A source that lacks either, or states the opening
   marker more than once, is refused, so a section that moves or is copied
   stops the run. *)

let find ?(from = 0) sub text =
  let n = String.length sub and length = String.length text in
  let rec go i =
    if i > length - n then None
    else if String.sub text i n = sub then Some i
    else go (i + 1)
  in
  go from

let count sub text =
  let rec go from found =
    match find ~from sub text with
    | Some i -> go (i + String.length sub) (found + 1)
    | None -> found
  in
  go 0 0

let drop n text = String.sub text n (String.length text - n)

let between start end_ source =
  match find start source with
  | None -> Error ("missing authority marker: " ^ start)
  | Some i -> (
      let rest = drop (i + String.length start) source in
      match find end_ rest with
      | None -> Error "unterminated authority section"
      | Some j ->
          let body = String.sub rest 0 j in
          let trailing = drop (j + String.length end_) rest in
          if count start body = 0 && count start trailing = 0 then Ok body
          else Error "ambiguous authority section")

let read ~root path =
  In_channel.with_open_bin (Filename.concat root path) In_channel.input_all
