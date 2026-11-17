(** Strict decoding of a JSON file into the model.

    A decoder is a function of a cursor, a JSON value at a place in a file. It
    returns the model's value or refuses, and a refusal names the file, the JSON
    Pointer (RFC 6901) of the value refused, and why. Nothing is defaulted: an
    unknown member, a duplicate member, a wrong type and a missing member are
    each a refusal. *)

type error = { file : string; pointer : string; message : string }

val error_to_string : error -> string

val escape : string -> string
(** A member's name as a token of a JSON Pointer. *)

type cursor

val pointer : cursor -> string

val refuse : cursor -> string -> 'a
(** Refuse the value at the cursor. Only {!val:run} handles a refusal. *)

type reference = { target : string; file : string; pointer : string }
(** A ["$ref"]: what it names, and where it was written. *)

val reference : cursor -> reference
(** Decode a ["$ref"]'s string. {!val:run} returns every reference decoded. *)

val resolve : reference -> string * string
(** The file a reference names, relative to the specs root, and the JSON Pointer
    within it, [""] for the whole file. *)

val run :
  file:string ->
  Yojson.Safe.t ->
  (cursor -> 'a) ->
  ('a * reference list, error) result
(** Decode a file's JSON, returning its references in the order decoded. *)

val parse_file : root:string -> string -> (Yojson.Safe.t, error) result
(** [parse_file ~root relative] reads and parses [root/relative]. *)

val at_pointer : string -> Yojson.Safe.t -> Yojson.Safe.t option
(** The value a JSON Pointer names within a value. *)

(** {1 Scalars} *)

val string : cursor -> string
val non_empty_string : cursor -> string
val bool : cursor -> bool
val int : cursor -> int

val number : cursor -> float
(** A JSON number, written with or without a fraction. *)

val null : cursor -> unit

val literal : string -> cursor -> unit
(** A string that must be exactly the one given. *)

val json : cursor -> Yojson.Safe.t
(** The value itself: an instance of a schema, such as its [example]. *)

(** {1 Shapes} *)

val list : (cursor -> 'a) -> cursor -> 'a list
val non_empty_list : (cursor -> 'a) -> cursor -> 'a list

val nullable : (cursor -> 'a) -> cursor -> 'a option
(** [null] or the value. A member that may be absent is {!val:optional}. *)

val map : (cursor -> 'a) -> cursor -> (string * 'a) list
(** An object whose member names are data, in the file's order. *)

val enum : (string * 'a) list -> cursor -> 'a
(** A string naming one of a closed set. *)

val pair : (cursor -> 'a) -> (cursor -> 'b) -> cursor -> 'a * 'b

val triple :
  (cursor -> 'a) -> (cursor -> 'b) -> (cursor -> 'c) -> cursor -> 'a * 'b * 'c
(** Arrays of exactly two or three elements, each of its own type. *)

type nothing = |

val nothing : cursor -> nothing
(** A place Protocol has only ever left empty, such as the element of an array
    every instance of which is empty. Any value there is refused until the model
    knows what it is. *)

type kind = Null | Bool | Int | Number | String | Array | Object

val kind : cursor -> kind
(** What JSON kind the value is. A decoder of a union reads it to choose its
    case, rather than trying one case and then another. *)

val has_member : string -> cursor -> bool
(** Whether the value is an object with the member, for choosing a case. *)

val variant : string -> (string * (cursor -> 'a)) list -> cursor -> 'a
(** An object whose case a member names: [variant "type" cases] reads the string
    member [type] and decodes the whole object with that case's decoder, which
    reads the member too. *)

val keyed : (string * (cursor -> 'a)) list -> cursor -> 'a
(** An object whose case is the one member it has of a closed set. *)

(** {1 Objects} *)

type members

val obj : (members -> 'a) -> cursor -> 'a
(** An object whose members the function reads with {!val:required} and
    {!val:optional}. A member it did not read is refused as unknown. *)

val required : members -> string -> (cursor -> 'a) -> 'a
val optional : members -> string -> (cursor -> 'a) -> 'a option

val at : members -> cursor
(** The object's own cursor, for refusing it as a whole. *)
