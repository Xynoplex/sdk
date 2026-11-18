(** How a record of {!Records} reads an object's members, the gateway having
    decoded the object as the record's schema: each read names the member it
    reads, and the members no read named are the record's [extra]. *)

type t

val start : (string * Yojson.Raw.t) list -> t

val fields_of : Yojson.Raw.t -> (string * Yojson.Raw.t) list
(** An object's members. *)

val string : Yojson.Raw.t -> string
val bool : Yojson.Raw.t -> bool

val raw : Yojson.Raw.t -> Yojson.Raw.t
(** A member kept as its JSON, numbers exactly. *)

val required : t -> (Yojson.Raw.t -> 'a) -> string -> 'a
val optional : t -> (Yojson.Raw.t -> 'a) -> string -> 'a Types.presence

val rest : t -> (string * Yojson.Raw.t) list
(** The members no read named, in the object's order. *)
