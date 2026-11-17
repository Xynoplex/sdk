(* Layout as ruff format lays a Python expression out, so a generated file is
   ruff's fixed point. The width is python/sdk/pyproject.toml's line-length;
   test-python's `ruff format --check` holds every generated file to both.
   Python_syntax builds these from its expressions.

   Ruff breaks a bracket's outer group first: its contents go on a line of
   their own, and only if they don't fit there are they one a line, with a
   comma after the last when there are two or more. Each item is then laid
   out in turn, in what its line leaves. *)

let width = 140

(* A comment line: prose wrapped to 96 columns, or a line as it is given. *)
type line = Prose of string | Line of string

(* [Break] is nothing on a line and a new line where its group is broken;
   [Space] is a space or a new line; [Broken_text] is text only where its
   group is broken (a magic comma, an import's parentheses). A [Comment] is
   its lines, each at the indentation, and breaks every group around it. *)
type doc =
  | Text of string
  | Break
  | Space
  | Broken_text of string
  | Comment of line list
  | Indent of doc list
  | Group of { broken : bool; docs : doc list }

let rec is_broken = function
  | Group { broken; _ } -> broken
  | Indent docs -> List.exists is_broken docs
  | Comment _ -> true
  | Text _ | Break | Space | Broken_text _ -> false

let group ?(broken = false) docs =
  Group { broken = broken || List.exists is_broken docs; docs }

(* [comment]'s lines behind [lead], wrapped to 96 columns. *)
let comment_lines ~indent lines =
  let lead = String.make indent ' ' ^ "#" in
  List.concat_map
    (function
      | Prose text ->
          List.map
            (fun l -> "# " ^ l)
            (Text.wrapped ~lead:(lead ^ " ") ~width:96 text)
      | Line "" -> [ "#" ]
      | Line text ->
          if String.contains text '\n' then
            invalid_arg
              (Printf.sprintf "Python_layout: comment line %S is two" text)
          else [ "# " ^ text ])
    lines

type mode = Flat | Broken

(* Whether [docs], laid out flat from where the line is, fit in [room],
   counting what follows them up to the next new line. *)
let fits room docs rest =
  let rec go room = function
    | _ when room < 0 -> false
    | [] -> true
    | (mode, d) :: more -> (
        match d with
        | Text text -> go (room - Text.length text) more
        | Break -> mode = Broken || go room more
        | Space -> mode = Broken || go (room - 1) more
        | Broken_text text ->
            go (if mode = Broken then room - Text.length text else room) more
        | Comment _ -> false
        | Indent docs -> go room (List.map (fun d -> (mode, d)) docs @ more)
        | Group { broken; docs } ->
            let mode = if broken then Broken else mode in
            go room (List.map (fun d -> (mode, d)) docs @ more))
  in
  go room (List.map (fun d -> (Flat, d)) docs @ rest)

let render ~indent docs =
  let out = Buffer.create 256 in
  let column = ref indent in
  let text s =
    Buffer.add_string out s;
    column := !column + Text.length s
  in
  let newline at =
    Buffer.add_char out '\n';
    Buffer.add_string out (String.make at ' ');
    column := at
  in
  let rec go = function
    | [] -> ()
    | (at, mode, d) :: more -> (
        match d with
        | Text s ->
            text s;
            go more
        | Break ->
            if mode = Broken then newline at;
            go more
        | Space ->
            if mode = Broken then newline at else text " ";
            go more
        | Broken_text s ->
            if mode = Broken then text s;
            go more
        | Comment lines ->
            List.iteri
              (fun i l ->
                if i > 0 then newline at;
                text l)
              (comment_lines ~indent:at lines);
            go more
        | Indent docs -> go (List.map (fun d -> (at + 4, mode, d)) docs @ more)
        | Group { broken; docs } ->
            let rest = List.map (fun (_, mode, d) -> (mode, d)) more in
            let mode =
              if mode = Flat then Flat
              else if (not broken) && fits (width - !column) docs rest then Flat
              else Broken
            in
            go (List.map (fun d -> (at, mode, d)) docs @ more))
  in
  Buffer.add_string out (String.make indent ' ');
  go (List.map (fun d -> (indent, Broken, d)) docs);
  Buffer.contents out

(* [docs] on one line, however long. *)
let rec flat docs =
  String.concat ""
    (List.map
       (function
         | Text s -> s
         | Break | Broken_text _ -> ""
         | Space -> " "
         | Comment _ -> invalid_arg "Python_layout: a comment on one line"
         | Indent docs | Group { docs; _ } -> flat docs)
       docs)
