(* A Python expression laid out as ruff format lays one out, so a generated
   file is ruff's fixed point. The width is python/sdk/pyproject.toml's
   line-length; test-python's `ruff format --check` holds every generated file
   to both.

   Ruff breaks a bracket's outer group first: its contents go on a line of
   their own, and only if they don't fit there are they one a line, with a
   comma after the last when there are two or more. Each item is then laid
   out in turn, in what its line leaves. *)

let width = 140

type t =
  | Atom of string
  | Keyword of string * t
  | Call of string * t list
  | Tuple of t list
  | Rows of t list
      (** A tuple written one item a line, which ruff keeps: the comma after the
          last of two or more is its magic trailing comma. A tuple of one has no
          magic comma, so ruff lays it out as any other. *)

(* The layout's own terms: [Break] is nothing on a line and a new line where
   its group is broken; [Space] is a space or a new line; [Comma] is a comma
   only where its group is broken. *)
type doc =
  | Text of string
  | Break
  | Space
  | Comma
  | Indent of doc list
  | Group of { broken : bool; docs : doc list }

let rec is_broken = function
  | Group { broken; _ } -> broken
  | Indent docs -> List.exists is_broken docs
  | Text _ | Break | Space | Comma -> false

let group ?(broken = false) docs =
  Group { broken = broken || List.exists is_broken docs; docs }

let rec doc = function
  | Atom text -> Text text
  | Keyword (name, value) -> group [ Text (name ^ "="); doc value ]
  | Call (callee, []) -> Text (callee ^ "()")
  | Call (callee, args) -> bracket (callee ^ "(") ")" args ~last:(comma args)
  | Tuple [] | Rows [] -> Text "()"
  | Tuple [ one ] -> bracket "(" ")" [ one ] ~last:(Text ",")
  | Tuple items -> bracket "(" ")" items ~last:Comma
  | Rows [ one ] -> doc (Tuple [ one ])
  | Rows items -> bracket "(" ")" items ~last:Comma ~one_a_line:true

and comma = function [ _ ] -> Text "" | _ -> Comma

and bracket ?(one_a_line = false) opening closing items ~last =
  let rec separated = function
    | [] -> []
    | [ item ] -> [ doc item; last ]
    | item :: rest -> doc item :: Text "," :: Space :: separated rest
  in
  group
    [
      Text opening;
      Indent [ Break; group ~broken:one_a_line (separated items) ];
      Break;
      Text closing;
    ]

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
        | Comma -> go (if mode = Broken then room - 1 else room) more
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
        | Comma ->
            if mode = Broken then text ",";
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

(* [expr] as the statement or item it is, from column [indent]: [prefix] is
   what comes before it on its line, and [suffix] after. *)
let statement ~indent ~prefix ~suffix expr =
  render ~indent [ group [ Text prefix; doc expr; Text suffix ] ]
