(* How a schema says that its value may be null, in JSON Schema 2020-12 as
   Protocol writes it: ["null"] its second [type]; an [anyOf] of one [$ref]
   and [{ "type": "null" }]; or a [oneOf] whose last member is
   [{ "type": "null" }], beside two others or more. Every writer reads null
   through [without_null], and decides nothing of it itself. *)

let is_null = function
  | Schema.Schema l ->
      Schema.keywords l = [ "type" ] && l.type_ = Some [ Schema.Null ]
  | Boolean_schema _ -> false

(* What [l] is beside null, when it may be null: [l] with null taken from its
   types, the [$ref] of its [anyOf] with [l]'s annotations beside it, or [l]
   with its [oneOf]'s last member gone. [schema] is the schema of a member of
   [l], for a layer whose members carry more than their schemas. An [anyOf]
   or a [oneOf] that holds null in any other way is refused. *)
let without_null (schema : 'a -> Schema.t) (l : 'a Schema.layer) :
    ('a Schema.layer option, string) result =
  let null member = is_null (schema member) in
  match l with
  | { type_ = Some [ t; Null ]; _ } when t <> Null ->
      Ok (Some { l with type_ = Some [ t ] })
  | { any_of = Some members; _ } when List.exists null members -> (
      match List.map schema members with
      | [ Schema ({ ref_ = Some r; _ } as named); last ]
        when Schema.keywords named = [ "$ref" ] && is_null last ->
          Ok (Some { l with any_of = None; ref_ = Some r })
      | _ ->
          Error
            "an anyOf that holds null is of one $ref and { \"type\": \"null\" }"
      )
  | { one_of = Some members; _ } when List.exists null members -> (
      match List.rev members with
      | last :: (_ :: _ :: _ as others)
        when null last && not (List.exists null others) ->
          Ok (Some { l with one_of = Some (List.rev others) })
      | _ ->
          Error
            "a oneOf that holds null holds { \"type\": \"null\" } last, beside \
             two members or more")
  | _ -> Ok None
