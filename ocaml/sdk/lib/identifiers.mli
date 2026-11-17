(* Generated from protocol/specs/src/identifiers/kinds.json and the kinds' required shapes. Do not edit.
   Regenerate: make generate (codegen/lib/identifiers/ocaml.ml) *)

[@@@ocamlformat "disable"]
module Resource_id : sig
  type t
  val of_string : string -> (t, string) result
  val to_string : t -> string
  val compare : t -> t -> int
  val equal : t -> t -> bool
end

module Annotation_id : sig
  type t
  val of_string : string -> (t, string) result
  val to_string : t -> string
  val compare : t -> t -> int
  val equal : t -> t -> bool
end

module Job_id : sig
  type t
  val of_string : string -> (t, string) result
  val to_string : t -> string
  val compare : t -> t -> int
  val equal : t -> t -> bool
end

module User_id : sig
  type t
  val of_string : string -> (t, string) result
  val to_string : t -> string
  val compare : t -> t -> int
  val equal : t -> t -> bool
end
