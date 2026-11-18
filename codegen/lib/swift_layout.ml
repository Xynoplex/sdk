(* Layout as swift-format 6.4.2 lays Swift out, so a generated file is its
   fixed point under swift/sdk/.swift-format: lines of 100 columns, an indent
   of 2, at most one blank line, and existing line breaks respected. Swift_syntax
   turns its tree into the tokens swift-format's TokenStreamCreator makes of the
   same source, and this prints them as its PrettyPrinter does: an Oppen
   printer, whose every break and group is measured to the next break at its
   own depth.

   A [Break] fires where what follows it to the next break does not fit, or
   where it must: its group is consistent and does not fit, its newline is one
   the source had, or it closes a scope opened on an earlier line. What it adds
   to the indentation is its kind's: an [Open_break] opens a scope whose lines
   are indented a block (only the last open on a line indents) and a
   continuation more where it opened on a continuation line; a [Continue] makes
   the line it starts a continuation; a [Reset] fires where the line is one. *)

let width = 100
let unit = 2

type consistency = Consistent | Inconsistent
type open_kind = Block | Continuation

type break_kind =
  | Open_break of open_kind
  | Close_break of { must : bool }
  | Continue
  | Same
  | Reset
  | Contextual

(* A break's newline: [Elective] is the printer's to choose; [Soft] is one
   the source has ([discretionary]) or the formatter adds, at most [count]. *)
type newline =
  | Elective of { ignores_discretionary : bool }
  | Soft of { count : int; discretionary : bool }

type comment_kind = Line_comment | Doc_line

type token =
  | Syntax of string
  | Space of int
  | Break of { kind : break_kind; size : int; newline : newline }
  | Open of consistency
  | Close
  | Comment of { kind : comment_kind; lines : string list }
      (** Each line as written, with its [//] or [///]. *)
  | Comma_start
  | Comma_end of { collection : bool; single : bool }
      (** Where a list's trailing comma goes: a collection of several elements
          has one where it is broken over lines. *)
  | Context_start
  | Context_end
  | Disable_breaking
  | Enable_breaking

(* How long each token is: a syntax token or a space its own width; a group
   what it holds; a break its size and what follows it to the next break at
   its depth or the end of its group. A newline the source has is a line's
   width, so every group around it breaks. *)
let lengths tokens =
  let lengths = Array.make (Array.length tokens) 0 in
  let total = ref 0 in
  let stack = ref [] in
  let is_break i = match tokens.(i) with Break _ -> true | _ -> false in
  Array.iteri
    (fun i token ->
      match token with
      | Open _ ->
          lengths.(i) <- - !total;
          stack := i :: !stack
      | Close -> (
          match !stack with
          | top :: rest -> (
              lengths.(top) <- lengths.(top) + !total;
              stack := rest;
              if is_break top then
                match !stack with
                | o :: rest ->
                    lengths.(o) <- lengths.(o) + !total;
                    stack := rest
                | [] -> invalid_arg "Swift_layout: a close with no open")
          | [] -> invalid_arg "Swift_layout: a close with no open")
      | Break { size; newline; _ } -> (
          (match !stack with
          | top :: rest when is_break top ->
              lengths.(top) <- lengths.(top) + !total;
              stack := rest
          | _ -> ());
          lengths.(i) <- - !total;
          stack := i :: !stack;
          total :=
            !total + match newline with Elective _ -> size | Soft _ -> width)
      | Syntax text ->
          lengths.(i) <- Text.length text;
          total := !total + Text.length text
      | Space size ->
          lengths.(i) <- size;
          total := !total + size
      | Comment { lines; _ } ->
          let length =
            List.fold_left (fun m l -> max m (Text.length l)) 0 lines
          in
          lengths.(i) <- length;
          total := !total + length
      | Comma_end { collection = true; single = false } ->
          lengths.(i) <- 1;
          total := !total + 1
      | Comma_start | Comma_end _ | Context_start | Context_end
      | Disable_breaking | Enable_breaking ->
          ())
    tokens;
  (match !stack with
  | [ top ] when is_break top -> lengths.(top) <- lengths.(top) + !total
  | [] -> ()
  | _ -> invalid_arg "Swift_layout: an open with no close");
  lengths

type active_open = {
  kind : open_kind;
  line : int;
  mutable block : bool;
  continuation : bool;
}

type behavior = Unknown | Continues | Maintains
type context = { context_line : int; mutable behavior : behavior }

let print tokens =
  let tokens = Array.of_list tokens in
  let lengths = lengths tokens in
  let out = Buffer.create (Array.length tokens * 4) in
  let at_start = ref true
  and line = ref 1
  and column = ref 0
  and pending = ref 0
  and newlines = ref 0 in
  let opens = ref [] in
  let forced = ref [ false ] in
  let continuation = ref false and continuations = ref [] in
  let contexts = ref [] and last_ended = ref None in
  let comma_lines = ref [] in
  let suppressed = ref 0 in
  let compensating () = if !at_start then !line - 1 else !line in
  let indentation () =
    List.fold_left
      (fun n o ->
        n + (if o.block then unit else 0) + if o.continuation then unit else 0)
      0 !opens
    + if !continuation then unit else 0
  in
  let write text =
    if !at_start then (
      let indent = indentation () in
      Buffer.add_string out (String.make indent ' ');
      column := indent;
      at_start := false)
    else if !pending > 0 then Buffer.add_string out (String.make !pending ' ');
    Buffer.add_string out text;
    column := !column + Text.length text;
    newlines := 0;
    pending := 0
  in
  let write_newlines = function
    | Elective _ when !newlines = 0 -> 1
    | Elective _ -> 0
    | Soft { count; _ } -> min count 2 - !newlines
  in
  let newline behavior =
    let count = write_newlines behavior in
    if count > 0 then (
      Buffer.add_string out (String.make count '\n');
      line := !line + count;
      at_start := true;
      newlines := !newlines + count;
      pending := 0;
      column := 0)
  in
  let room () = width - !column in
  let can_fit length = !at_start || length <= room () in
  Array.iteri
    (fun i token ->
      let length = lengths.(i) in
      match token with
      | Context_start ->
          contexts := { context_line = !line; behavior = Unknown } :: !contexts;
          last_ended := None
      | Context_end -> (
          match !contexts with
          | c :: rest ->
              contexts := rest;
              last_ended := Some c
          | [] -> invalid_arg "Swift_layout: an unmatched context end")
      | Open consistency ->
          forced :=
            (consistency = Consistent && not (can_fit length)) :: !forced
      | Close -> forced := List.tl !forced
      | Break { kind; size; newline = behavior } ->
          let must = ref (List.hd !forced) in
          let continues_if_fires = ref false in
          (match kind with
          | Open_break open_kind ->
              opens :=
                {
                  kind = open_kind;
                  line = compensating ();
                  block = false;
                  continuation = !continuation && open_kind = Block;
                }
                :: !opens;
              continuations := !continuation :: !continuations;
              continuation := false
          | Close_break { must = close_must } ->
              let matching, rest =
                match !opens with
                | o :: rest -> (o, rest)
                | [] -> invalid_arg "Swift_layout: an unmatched close break"
              in
              opens := rest;
              let elsewhere = compensating () <> matching.line in
              (if matching.block then
                 match rest with
                 | o :: _ when o.line = matching.line && !line = matching.line
                   ->
                     o.block <- true
                 | _ -> ());
              if close_must then must := elsewhere
              else if room () = 0 then must := true;
              let restored = List.hd !continuations in
              continuations := List.tl !continuations;
              continues_if_fires := restored;
              continuation := (matching.block && elsewhere) || restored
          | Continue -> continues_if_fires := true
          | Same -> ()
          | Reset -> must := !continuation
          | Contextual ->
              let fires = ((not !at_start) && length > room ()) || !must in
              (if fires then
                 match (!last_ended, !contexts) with
                 | Some ended, active :: _ when active.behavior = Unknown ->
                     active.behavior <-
                       (if ended.context_line = !line then Continues
                        else Maintains)
                 | _ -> ());
              (match !contexts with
              | { behavior = Maintains; _ } :: _ ->
                  continues_if_fires := !continuation
              | _ -> continues_if_fires := true);
              last_ended := None);
          let overrides =
            match behavior with
            | Elective _ -> false
            | Soft { discretionary; _ } ->
                must := true;
                discretionary
          in
          let suppress = !suppressed > 0 && not overrides in
          if (not suppress) && (((not !at_start) && length > room ()) || !must)
          then (
            continuation := !continues_if_fires;
            (match !opens with
            | o :: _
              when o.line = compensating ()
                   && (o.kind = Block
                      || match kind with Open_break _ -> true | _ -> false) ->
                o.block <- true
            | _ -> ());
            newline behavior)
          else if !at_start then (
            (match (kind, !opens) with
            | Open_break _, o :: _ -> o.block <- true
            | _ -> ());
            continuation := !continuation || !continues_if_fires)
          else (
            pending := !pending + size;
            column := !column + size)
      | Syntax "" -> ()
      | Syntax text -> write text
      | Space size ->
          pending := !pending + size;
          column := !column + size
      | Comment { lines; _ } ->
          List.iteri
            (fun j l ->
              if j > 0 then newline (Soft { count = 1; discretionary = false });
              write l)
            lines
      | Comma_start -> comma_lines := compensating () :: !comma_lines
      | Comma_end { collection; single } -> (
          match !comma_lines with
          | start :: rest ->
              comma_lines := rest;
              if collection && (not single) && start <> compensating () then
                write ","
          | [] -> invalid_arg "Swift_layout: an unmatched comma end")
      | Disable_breaking -> incr suppressed
      | Enable_breaking -> decr suppressed)
    tokens;
  Buffer.contents out
