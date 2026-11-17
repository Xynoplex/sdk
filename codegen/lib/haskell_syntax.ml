(* Haskell as the generator writes it: a generated module's declarations, the
   types and values they hold, and the few expressions a table's own
   dispatch needs, with a printer that writes them. A writer builds a module
   of these and never a line of Haskell: a name is checked to be one, a
   string is escaped by the printer, a comment's markers are the printer's,
   and what an application takes is parenthesised where it must be.

   What a generated module holds is what Protocol derives: types, the table's
   data, and a dispatch whose body is the table. Logic that no table varies
   is the SDK's own, written by hand beside it.

   Each declaration is a line, or a line a clause, with none blank between;
   only a case puts its alternatives on lines of their own. The module
   exports every declaration it holds, in their order. *)

type type_ =
  | T_name of string
  | T_apply of string * type_ list  (** [Map.Map Text Text] *)
  | T_list of type_
  | T_tuple of type_ list
  | T_fun of type_ * type_

(* What a clause or an alternative matches: a constructor matches what it
   holds by a pattern each. *)
type pattern =
  | Constructor of string * pattern list
  | Literal of string
  | Otherwise

type expr =
  | Name of string
  | Str of string
  | Int of int
  | List of expr list
  | Tuple of expr list
  | Apply of expr * expr list
  | Compose of expr * expr  (** [f . g] *)
  | Dollar of expr * expr  (** [f $ x] *)
  | Lambda of string * expr  (** [\x -> e] *)
  | Case of expr * (pattern * expr) list
      (** An alternative a line, indented past the line it opens on. *)

type constructor = { constructor : string; fields : type_ list }
type clause = { patterns : pattern list; body : expr }

(* What an import names of a module: one name, a type with all of its
   constructors, or a type with the ones listed. *)
type item = Plain of string | All of string | With of string * string list

type import = {
  module_ : string;
  qualified : string option;  (** [import qualified M as Q] *)
  items : item list option;  (** [None]: the whole module. *)
}

(* [about] is a doc comment's lines, the first written behind [-- |]. *)
type decl =
  | Data of {
      about : string list;
      name : string;
      constructors : constructor list;
      deriving : string list;
    }
  | Alias of { about : string list; name : string; type_ : type_ }
  | Value of {
      about : string list;
      name : string;
      type_ : type_;
      clauses : clause list;
    }
  | Values of {
      about : string list;
      type_ : type_;
      values : (string * expr) list;
    }  (** Several values of one type, under one signature. *)
  | Instance of {
      class_ : string;
      instance : string;
      methods : (string * expr) list;
    }

type module_ = {
  banner : string list;  (** Line comments, each written after a [--]. *)
  extensions : string list;
  name : string;
  imports : import list;
  body : decl list;
}

let constructor ?(fields = []) constructor = { constructor; fields }

let data ?(about = []) ?(deriving = []) name constructors =
  Data { about; name; constructors; deriving }

let alias ?(about = []) name type_ = Alias { about; name; type_ }

let value ?(about = []) name type_ body =
  Value { about; name; type_; clauses = [ { patterns = []; body } ] }

let import ?qualified ?items module_ = { module_; qualified; items }

let is_word = function
  | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '_' | '\'' -> true
  | _ -> false

let identifier name =
  name <> ""
  && (match name.[0] with 'A' .. 'Z' | 'a' .. 'z' | '_' -> true | _ -> false)
  && String.for_all is_word name

(* A name, or one qualified by the module it is of. *)
let checked name =
  if List.for_all identifier (String.split_on_char '.' name) then name
  else invalid_arg (Printf.sprintf "Haskell_syntax: %S is no name" name)

(* A string literal: a quote and a backslash escaped, printable ASCII as
   itself, and every other character by its code point, ended by \& so a
   digit after it is not read as more of it. *)
let literal text =
  let out = Buffer.create (String.length text + 2) in
  Buffer.add_char out '"';
  Text.fold_uchars
    (fun () u ->
      match Uchar.to_int u with
      | (0x22 | 0x5C) as c ->
          Buffer.add_char out '\\';
          Buffer.add_char out (Char.chr c)
      | c when c >= 0x20 && c <= 0x7E -> Buffer.add_char out (Char.chr c)
      | c -> Buffer.add_string out (Printf.sprintf "\\x%x\\&" c))
    () text;
  Buffer.add_char out '"';
  Buffer.contents out

let indentation depth = String.make (2 * depth) ' '
let tuple items = "(" ^ String.concat ", " items ^ ")"
let listed items = "[" ^ String.concat ", " items ^ "]"

let rec type_ = function
  | T_name name -> checked name
  | T_apply (name, args) ->
      String.concat " " (checked name :: List.map type_argument args)
  | T_list t -> "[" ^ type_ t ^ "]"
  | T_tuple ts -> tuple (List.map type_ ts)
  | T_fun (a, b) ->
      (match a with T_fun _ -> "(" ^ type_ a ^ ")" | _ -> type_ a)
      ^ " -> " ^ type_ b

and type_argument = function
  | (T_apply _ | T_fun _) as t -> "(" ^ type_ t ^ ")"
  | t -> type_ t

let rec pattern = function
  | Constructor (name, []) -> checked name
  | Constructor (name, held) ->
      "(" ^ String.concat " " (checked name :: List.map pattern held) ^ ")"
  | Literal text -> literal text
  | Otherwise -> "_"

let rec expr ~depth = function
  | Name name -> checked name
  | Str text -> literal text
  | Int n -> string_of_int n
  | List items -> listed (List.map (expr ~depth) items)
  | Tuple items -> tuple (List.map (expr ~depth) items)
  | Apply (f, args) ->
      String.concat " " (applied ~depth f :: List.map (argument ~depth) args)
  | Compose (f, g) -> applied ~depth f ^ " . " ^ applied ~depth g
  | Dollar (f, x) -> applied ~depth f ^ " $ " ^ expr ~depth x
  | Lambda (name, body) -> "\\" ^ checked name ^ " -> " ^ expr ~depth body
  | Case (subject, alternatives) ->
      "case " ^ expr ~depth subject ^ " of"
      ^ String.concat ""
          (List.map
             (fun (p, body) ->
               "\n"
               ^ indentation (depth + 1)
               ^ pattern p ^ " -> "
               ^ expr ~depth:(depth + 1) body)
             alternatives)

(* What an operator takes, and what is applied: an application binds tighter
   than either. *)
and applied ~depth = function
  | (Compose _ | Dollar _ | Lambda _ | Case _) as e -> "(" ^ expr ~depth e ^ ")"
  | e -> expr ~depth e

and argument ~depth = function
  | (Apply _ | Compose _ | Dollar _ | Lambda _ | Case _) as e ->
      "(" ^ expr ~depth e ^ ")"
  | e -> expr ~depth e

let doc about =
  List.mapi
    (fun i line ->
      if String.contains line '\n' then
        invalid_arg
          (Printf.sprintf "Haskell_syntax: a doc comment's line %S is two lines"
             line);
      (if i = 0 then "-- | " else "-- ") ^ line)
    about

let item = function
  | Plain name -> checked name
  | All name -> checked name ^ "(..)"
  | With (name, constructors) ->
      checked name ^ "("
      ^ String.concat ", " (List.map checked constructors)
      ^ ")"

let import_line { module_; qualified; items } =
  "import "
  ^ (match qualified with
    | None -> checked module_
    | Some q -> "qualified " ^ checked module_ ^ " as " ^ checked q)
  ^
  match items with
  | None -> ""
  | Some items -> " (" ^ String.concat ", " (List.map item items) ^ ")"

let exports = function
  | Data { name; _ } -> [ All name ]
  | Alias { name; _ } | Value { name; _ } -> [ Plain name ]
  | Values { values; _ } -> List.map (fun (name, _) -> Plain name) values
  | Instance _ -> []

let decl = function
  | Data { about; name; constructors; deriving } ->
      doc about
      @ [
          ("data " ^ checked name ^ " = "
          ^ String.concat " | "
              (List.map
                 (fun { constructor; fields } ->
                   String.concat " "
                     (checked constructor :: List.map type_argument fields))
                 constructors)
          ^
          match deriving with
          | [] -> ""
          | classes -> " deriving " ^ tuple (List.map checked classes));
        ]
  | Alias { about; name; type_ = t } ->
      doc about @ [ "type " ^ checked name ^ " = " ^ type_ t ]
  | Value { about; name; type_ = t; clauses } ->
      doc about
      @ (checked name ^ " :: " ^ type_ t)
        :: List.map
             (fun { patterns; body } ->
               String.concat " " (checked name :: List.map pattern patterns)
               ^ " = " ^ expr ~depth:0 body)
             clauses
  | Values { about; type_ = t; values } ->
      doc about
      @ (String.concat ", " (List.map (fun (name, _) -> checked name) values)
        ^ " :: " ^ type_ t)
        :: List.map
             (fun (name, e) -> checked name ^ " = " ^ expr ~depth:0 e)
             values
  | Instance { class_; instance; methods } -> (
      let head =
        "instance " ^ checked class_ ^ " " ^ checked instance ^ " where"
      in
      let method_ ~depth (name, e) = checked name ^ " = " ^ expr ~depth e in
      match methods with
      | [ m ] when not (String.contains (method_ ~depth:0 m) '\n') ->
          [ head ^ " " ^ method_ ~depth:0 m ]
      | methods ->
          head :: List.map (fun m -> indentation 1 ^ method_ ~depth:1 m) methods
      )

let text m =
  String.concat "\n"
    (List.map (fun l -> if l = "" then "--" else "-- " ^ l) m.banner
    @ List.map (fun e -> "{-# LANGUAGE " ^ checked e ^ " #-}") m.extensions
    @ [
        "module " ^ checked m.name ^ " ("
        ^ String.concat ", " (List.map item (List.concat_map exports m.body))
        ^ ") where";
      ]
    @ List.map import_line m.imports
    @ List.concat_map decl m.body)
  ^ "\n"
