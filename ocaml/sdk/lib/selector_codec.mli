(** How {!Selector} reads and writes a branch's members. Each read names the
    member it reads, and the members no read named are the branch's [extra]; a
    write states each member once, and [extra] adds the members it does not
    state. *)

type fault = Schema_codec.fault
type t

val start : (string * Yojson.Safe.t) list -> t
val ( let* ) : ('a, 'e) result -> ('a -> ('b, 'e) result) -> ('b, 'e) result
val malformed : string -> ('a, fault) result
val string : string -> Yojson.Safe.t -> (string, fault) result
val integer : string -> Yojson.Safe.t -> (Z.t, fault) result
val integer_at_least : int -> string -> Yojson.Safe.t -> (Z.t, fault) result

val required :
  t ->
  (string -> Yojson.Safe.t -> ('a, fault) result) ->
  string ->
  ('a, fault) result

val optional :
  t ->
  (string -> Yojson.Safe.t -> ('a, fault) result) ->
  string ->
  ('a option, fault) result

val rest : t -> (string * Yojson.Safe.t) list
(** The members no read named, in the object's order. *)

val json_string : string -> Yojson.Safe.t
val json_integer : Z.t -> Yojson.Safe.t

val write :
  (string * Yojson.Safe.t option) list ->
  (string * Yojson.Safe.t) list ->
  Yojson.Safe.t
(** The stated members that are present, then each [extra] member no stated one
    names, present or not. *)
