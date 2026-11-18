(* The imports between generated and hand-written modules run one way. A
   hand-written module that a generated one imports when it runs is a base
   module, and nothing a base module imports when it runs comes back to the
   generated module that imports it: the public modules, which import
   generated ones, stand above both. A generated module is one the generator
   writes.

   An import of types only is no import at run time: in TypeScript it is
   erased, and in Python it is under [if TYPE_CHECKING:]. The base modules are
   listed nowhere; they are whatever generated code imports, so a generated
   module that comes to import a public one is refused here rather than
   failing in a cycle at run time. A module is named by its path from the sdk
   checkout's root. *)

let read path = In_channel.with_open_bin path In_channel.input_all

let is_word = function
  | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '_' -> true
  | _ -> false

let is_space c = c = ' ' || c = '\t' || c = '\n' || c = '\r'

(* The path from the checkout's root, its [.] and [..] segments taken. *)
let normal path =
  List.fold_left
    (fun kept segment ->
      match (segment, kept) with
      | ("" | "."), _ -> kept
      | "..", _ :: rest -> rest
      | _ -> segment :: kept)
    []
    (String.split_on_char '/' path)
  |> List.rev |> String.concat "/"

(* A scanner over [text] from [at]: each step gives the position after what it
   read, or None when [text] does not hold it there. *)
let spaces text at =
  let n = String.length text in
  let rec from i = if i < n && is_space text.[i] then from (i + 1) else i in
  let i = from at in
  if i > at then Some i else None

let word text at =
  let n = String.length text in
  let rec from i = if i < n && is_word text.[i] then from (i + 1) else i in
  let i = from at in
  if i > at then Some i else None

let literal part text at =
  if
    at + String.length part <= String.length text
    && String.sub text at (String.length part) = part
  then Some (at + String.length part)
  else None

let until c text at =
  Option.map (fun i -> i + 1) (String.index_from_opt text at c)

let ( let* ) = Option.bind

(* Each line start of [text]. *)
let line_starts text =
  0
  :: List.filter_map
       (fun i -> if text.[i] = '\n' then Some (i + 1) else None)
       (List.init (String.length text) Fun.id)

(* TypeScript: the [*.ts] files directly in typescript/core/src. An import or
   re-export of a relative module at a line's start is made at run time
   unless it is of types only: [import type], or braces whose every name is
   [type]-marked. *)
module Typescript = struct
  let directory = "typescript/core/src"

  (* The names in braces, or None for a clause of one name or [* as name]. *)
  let clause text at =
    match text.[at] with
    | '{' ->
        let* close = until '}' text at in
        Some (close, Some (String.sub text (at + 1) (close - at - 2)))
    | '*' ->
        let* at = literal "*" text at in
        let* at = Option.bind (spaces text at) (literal "as" text) in
        let* at = Option.bind (spaces text at) (word text) in
        Some (at, None)
    | _ ->
        let* at = word text at in
        Some (at, None)
    | exception Invalid_argument _ -> None

  (* A single-quoted relative module, after [from]: the quotes hold a [.] and
     at least one more character. *)
  let target text at =
    let* at = Option.bind (spaces text at) (literal "from" text) in
    let* at = Option.bind (spaces text at) (literal "'" text) in
    let* _ = literal "." text at in
    let* close = String.index_from_opt text at '\'' in
    if close > at + 1 then Some (String.sub text at (close - at)) else None

  let types_only names =
    let named =
      List.filter
        (fun n -> n <> "")
        (List.map String.trim (String.split_on_char ',' names))
    in
    List.for_all (String.starts_with ~prefix:"type ") named

  (* At a line's start: whether the import is made at run time, and what it
     names. A clause may itself be named [type], so a [type] that leaves no
     import after it is read as the clause. *)
  let import text at =
    let* at =
      match literal "import" text at with
      | Some _ as found -> found
      | None -> literal "export" text at
    in
    let* at = spaces text at in
    let typed =
      let* after = literal "type" text at in
      let* after = spaces text after in
      let* after, _ = clause text after in
      let* named = target text after in
      Some (false, named)
    in
    match typed with
    | Some _ -> typed
    | None ->
        let* after, names = clause text at in
        let* named = target text after in
        Some
          ( (match names with Some n -> not (types_only n) | None -> true),
            named )

  (* The module a relative target names: its last suffix replaced by .ts. *)
  let resolve file named =
    let path = normal (Filename.dirname file ^ "/" ^ named) in
    if Filename.check_suffix path ".ts" then path
    else Filename.remove_extension path ^ ".ts"

  let modules ~root =
    Sys.readdir (Filename.concat root directory)
    |> Array.to_list
    |> List.filter (fun name -> Filename.check_suffix name ".ts")
    |> List.map (fun name -> directory ^ "/" ^ name)
    |> List.filter (fun path ->
        not (Sys.is_directory (Filename.concat root path)))

  let imports ~root file =
    let text = read (Filename.concat root file) in
    List.filter_map
      (fun at ->
        match import text at with
        | Some (true, named) -> Some (resolve file named)
        | Some (false, _) | None -> None)
      (line_starts text)
end

(* Python: the modules under python/sdk/src. An import at a line's start is
   made when its module is; one indented is under [if TYPE_CHECKING:] or in a
   function, and makes no cycle at import time. Only the SDK's own modules,
   under xynolog, are followed. *)
module Python = struct
  let directory = "python/sdk/src"

  let rec files ~root path =
    let full = Filename.concat root path in
    if Sys.is_directory full then
      Sys.readdir full |> Array.to_list |> List.sort String.compare
      |> List.concat_map (fun name -> files ~root (path ^ "/" ^ name))
    else if Filename.check_suffix path ".py" then [ path ]
    else []

  let modules ~root = files ~root directory

  (* The file a dotted module name names, a module's or a package's. *)
  let module_file ~root name =
    let base =
      directory ^ "/" ^ String.concat "/" (String.split_on_char '.' name)
    in
    List.find_opt
      (fun candidate -> Sys.file_exists (Filename.concat root candidate))
      [ base ^ ".py"; base ^ "/__init__.py" ]

  let dotted text at =
    let n = String.length text in
    let rec from i =
      if i < n && (is_word text.[i] || text.[i] = '.') then from (i + 1) else i
    in
    from at

  let rest_of_line text at =
    match String.index_from_opt text at '\n' with
    | Some i -> i
    | None -> String.length text

  (* The names a [from ... import] lists: in parentheses across lines, or the
     rest of the line; each without its comment or its [as]. *)
  let names text at =
    let* listed =
      match text.[at] with
      | '(' ->
          let* close = until ')' text at in
          Some (String.sub text (at + 1) (close - at - 2))
      | _ ->
          let close = rest_of_line text at in
          if close > at then Some (String.sub text at (close - at)) else None
      | exception Invalid_argument _ -> None
    in
    let uncommented =
      String.split_on_char '\n' listed
      |> List.map (fun line ->
          match String.index_opt line '#' with
          | Some i -> String.sub line 0 i
          | None -> line)
      |> String.concat " "
    in
    let alias entry = String.trim (List.hd (Text.split ~sub:" as " entry)) in
    Some
      (List.filter (( <> ) "")
         (List.map alias (String.split_on_char ',' uncommented)))

  let sdk name = String.starts_with ~prefix:"xynolog" name

  (* The module [from source import ...] names, in [path]'s package: each
     leading dot past the first climbs out of one package. *)
  let absolute path source =
    let n = String.length source in
    let rec dots i = if i < n && source.[i] = '.' then dots (i + 1) else i in
    let level = dots 0 in
    let name = String.sub source level (n - level) in
    if level = 0 then name
    else
      let within =
        String.sub path
          (String.length directory + 1)
          (String.length path - String.length directory - 1)
      in
      let package =
        List.rev (List.tl (List.rev (String.split_on_char '/' within)))
      in
      let kept =
        List.filteri (fun i _ -> i < List.length package - level + 1) package
      in
      String.concat "." (kept @ if name = "" then [] else [ name ])

  let import ~root path text at =
    match literal "from" text at with
    | Some after ->
        let* start = spaces text after in
        let stop = dotted text start in
        let source = String.sub text start (stop - start) in
        let* after = Option.bind (spaces text stop) (literal "import" text) in
        let* after = spaces text after in
        let* listed = names text after in
        let name = absolute path source in
        if not (sdk name) then None
        else
          Some
            (List.filter_map
               (fun alias ->
                 match module_file ~root (name ^ "." ^ alias) with
                 | Some _ as found -> found
                 | None -> module_file ~root name)
               listed)
    | None ->
        let* after = literal "import" text at in
        let* start = spaces text after in
        let stop = dotted text start in
        let name = String.sub text start (stop - start) in
        if stop > start && sdk name then
          Option.map (fun m -> [ m ]) (module_file ~root name)
        else None

  let imports ~root path =
    let text = read (Filename.concat root path) in
    List.concat_map
      (fun at -> Option.value (import ~root path text at) ~default:[])
      (line_starts text)
end

type language = {
  label : string;
  modules : root:string -> string list;
  imports : root:string -> string -> string list;
}

let languages =
  [
    {
      label = "TypeScript";
      modules = Typescript.modules;
      imports = Typescript.imports;
    };
    { label = "Python"; modules = Python.modules; imports = Python.imports };
  ]

module Graph = Map.Make (String)

(* A path of imports from [start] to [goal], when there is one. *)
let path_to graph start goal =
  let rec search seen = function
    | [] -> None
    | (at, path) :: stack ->
        if at = goal then Some (List.rev path)
        else if List.mem at seen then search seen stack
        else
          let next =
            Option.value (Graph.find_opt at graph) ~default:[]
            |> List.filter (fun n -> not (List.mem n seen))
            |> List.map (fun n -> (n, n :: path))
          in
          search (at :: seen) (next @ stack)
  in
  search [] [ (start, [ start ]) ]

(* Each of [language]'s modules, with those it imports at run time. *)
let graph ~root language =
  List.fold_left
    (fun graph m ->
      Graph.add m
        (List.sort_uniq String.compare (language.imports ~root m))
        graph)
    Graph.empty (language.modules ~root)

(* Of the generated files the generator writes, those of [language]'s
   modules, and each refusal: a base module one imports that comes back to
   it. *)
let check ~root ~generated language =
  let graph = graph ~root language in
  let generated =
    List.filter
      (fun m -> List.mem m generated)
      (List.map fst (Graph.bindings graph))
  in
  let refusals =
    List.concat_map
      (fun g ->
        Graph.find g graph
        |> List.filter (fun base -> not (List.mem base generated))
        |> List.filter_map (fun base ->
            Option.map
              (fun back ->
                Printf.sprintf
                  "%s: generated %s imports %s, which comes back to it: %s"
                  language.label g base
                  (String.concat " -> " back))
              (path_to graph base g)))
      generated
  in
  (generated, refusals)
