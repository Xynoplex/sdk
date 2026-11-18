(* Every sdk path Protocol names is one the sdk checkout has. Protocol says who
   writes or holds each of its tables by naming sdk files, as [sdk/<path>] in
   its prose and tables and as links to github.com/xynolog/sdk/tree/main/<path>
   (or blob/main) in its contract docs; nothing else holds those names to the
   files.

   A link names the sdk repository whatever its path. A bare [sdk/<path>]
   names it when the path's first segment is one of the sdk checkout's own
   top-level entries: Protocol's own conformance/sdk/ is the other sdk/ its
   prose names ([sdk/wire/...], [sdk/live/...]), and holding those is
   Protocol's. So a bare path under a top-level entry this checkout no longer
   has goes unread here. A path with [{a,b}] names each path the braces expand
   to, and one with [*] names at least one file.

   Every file of the Protocol checkout is read, but no checkout nested in it. *)

let read path = In_channel.with_open_bin path In_channel.input_all

let is_path_character = function
  | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '_' | '.' | '*' | '/' | '-' -> true
  | _ -> false

let is_word = function
  | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '_' -> true
  | _ -> false

(* The end of the path that starts at [at]: path characters, and braces that
   hold path characters and commas. *)
let path_end text at =
  let n = String.length text in
  let rec braced i =
    if i < n && (is_path_character text.[i] || text.[i] = ',') then
      braced (i + 1)
    else if i < n && text.[i] = '}' then Some (i + 1)
    else None
  in
  let rec from i =
    if i < n && is_path_character text.[i] then from (i + 1)
    else if i < n && text.[i] = '{' then
      match braced (i + 1) with Some j -> from j | None -> i
    else i
  in
  from at

let starts_with_at text at part =
  at + String.length part <= String.length text
  && String.sub text at (String.length part) = part

(* Each [(start, end, path)] where [text] holds [prefix] and then a path,
   each read on from where the one before it ends; with [boundary], a prefix
   that ends a word is none. *)
let after prefix ~boundary text =
  let n = String.length text and m = String.length prefix in
  let rec from at found =
    if at + m > n then List.rev found
    else if
      starts_with_at text at prefix
      && ((not boundary) || at = 0 || not (is_word text.[at - 1]))
      && path_end text (at + m) > at + m
    then
      let stop = path_end text (at + m) in
      from stop ((at, stop, String.sub text (at + m) (stop - at - m)) :: found)
    else from (at + 1) found
  in
  from 0 []

let links text =
  List.concat_map
    (fun kind ->
      after ("github.com/xynolog/sdk/" ^ kind ^ "/main/") ~boundary:false text)
    [ "tree"; "blob" ]
  |> List.sort compare

let top_level ~sdk =
  List.filter (( <> ) ".git") (Array.to_list (Sys.readdir sdk))

let rec strip_dots text =
  if String.ends_with ~suffix:"." text then
    strip_dots (String.sub text 0 (String.length text - 1))
  else text

(* Each sdk path [text] names, by where it starts: the links, then each bare
   form outside a link, for a link holds [sdk/tree/main/...] too. *)
let references ~top_level text =
  let linked = links text in
  let bare =
    List.filter
      (fun (start, _, path) ->
        (not (List.exists (fun (s, e, _) -> s <= start && start < e) linked))
        && List.mem
             (strip_dots (List.hd (String.split_on_char '/' path)))
             top_level)
      (after "sdk/" ~boundary:true text)
  in
  List.map (fun (start, _, path) -> (start, path)) (linked @ bare)

(* Each path [path] names, its first braces expanded, and theirs in turn. *)
let rec expansions path =
  match String.index_opt path '{' with
  | None -> [ path ]
  | Some open_ -> (
      match String.index_from_opt path open_ '}' with
      | None -> [ path ]
      | Some close ->
          let head = String.sub path 0 open_
          and tail =
            String.sub path (close + 1) (String.length path - close - 1)
          in
          String.split_on_char ','
            (String.sub path (open_ + 1) (close - open_ - 1))
          |> List.concat_map (fun alternative ->
              expansions (head ^ alternative ^ tail)))

(* Whether [name] matches [pattern], whose [*] matches any run of
   characters. *)
let matches pattern name =
  let p = String.length pattern and n = String.length name in
  let rec at i j =
    if i = p then j = n
    else if pattern.[i] = '*' then at (i + 1) j || (j < n && at i (j + 1))
    else j < n && pattern.[i] = name.[j] && at (i + 1) (j + 1)
  in
  at 0 0

let entries directory =
  match Sys.readdir directory with
  | names -> Array.to_list names
  | exception Sys_error _ -> []

(* Whether a file under [directory] answers the segments of a pattern: [**]
   is any number of directories, and [*] in a segment any run of
   characters. *)
let rec found directory = function
  | [] -> Sys.file_exists directory
  | "**" :: rest ->
      found directory rest
      || List.exists
           (fun name ->
             let path = Filename.concat directory name in
             Sys.is_directory path && found path ("**" :: rest))
           (entries directory)
  | segment :: rest when String.contains segment '*' ->
      List.exists
        (fun name ->
          matches segment name && found (Filename.concat directory name) rest)
        (entries directory)
  | segment :: rest -> found (Filename.concat directory segment) rest

let present ~sdk path =
  if String.contains path '*' then
    found sdk (List.filter (( <> ) "") (String.split_on_char '/' path))
  else Sys.file_exists (Filename.concat sdk path)

(* Each file of the Protocol checkout, by its path from [protocol], but none
   of a checkout nested in it. *)
let rec files ~protocol path =
  let full = Filename.concat protocol path in
  List.sort String.compare (entries full)
  |> List.filter (( <> ) ".git")
  |> List.concat_map (fun name ->
      let inner = if path = "" then name else path ^ "/" ^ name in
      let full = Filename.concat protocol inner in
      if Sys.is_directory full then
        if Sys.file_exists (Filename.concat full ".git") then []
        else files ~protocol inner
      else [ inner ])

let line text offset =
  let rec count i lines =
    if i >= offset then lines
    else count (i + 1) (if text.[i] = '\n' then lines + 1 else lines)
  in
  count 0 1

(* How many sdk paths the Protocol checkout names, and a refusal for each
   path one expands to that the sdk checkout lacks. *)
let check ~sdk ~protocol =
  let top_level = top_level ~sdk in
  List.fold_left
    (fun (named, refusals) file ->
      let text = read (Filename.concat protocol file) in
      let references = references ~top_level text in
      ( named + List.length references,
        refusals
        @ List.concat_map
            (fun (offset, raw) ->
              List.filter_map
                (fun expanded ->
                  if present ~sdk expanded then None
                  else
                    Some
                      (Printf.sprintf
                         "protocol/%s:%d: sdk/%s is not in the SDK checkout"
                         file (line text offset) expanded))
                (expansions (strip_dots raw)))
            references ))
    (0, []) (files ~protocol "")
