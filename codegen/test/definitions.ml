(* How a [$ref] names its schema: a whole file, a table's record, or a member
   inside a file, written in place. *)

open Xynolog_codegen

let case name test = Alcotest.test_case name `Quick test

let schema file text =
  match Decode.run ~file (Yojson.Safe.from_string text) Schema.decode with
  | Ok (s, _) -> s
  | Error error -> Alcotest.fail (Decode.error_to_string error)

let request = "components/schemas/Request.json"

let schemas =
  let t = Hashtbl.create 4 in
  Hashtbl.replace t request
    (schema request
       {|{"type":"object","properties":{
           "limit":{"type":"integer","minimum":1},
           "a/b":{"type":"boolean"},
           "names":{"type":"array","items":{"type":"string"}},
           "either":{"oneOf":[{"type":"string"},{"type":"number"}]}}}|});
  Hashtbl.replace t "client/registry.json#/properties/types/0"
    (schema "client/registry.json" {|{"title":"Entry","type":"object"}|});
  t

let from_client target =
  { Decode.target; file = "client/types/Options.json"; pointer = "" }

let type_of = function
  | Some (Schema.Schema { type_ = Some [ t ]; _ }) -> Some t
  | _ -> None

let type_name =
  Alcotest.testable
    (fun f t ->
      Format.pp_print_string f
        (match t with
        | Schema.String -> "string"
        | Integer -> "integer"
        | Number -> "number"
        | Boolean -> "boolean"
        | Array -> "array"
        | Object -> "object"
        | Null -> "null"))
    ( = )

(* The references here name schemas by path, so they need no index of [$id]s. *)
let ids = Result.get_ok (Decode.ids [])

let at target =
  type_of (Definitions.schema_at ~ids ~schemas (from_client target))

let refused target =
  match Definitions.schema_at ~ids ~schemas (from_client target) with
  | exception Definitions.Refused _ -> ()
  | _ -> Alcotest.failf "%s names a schema" target

let cases =
  [
    case "a member is the schema the pointer names in its file" (fun () ->
        Alcotest.(check (option type_name))
          "limit" (Some Integer)
          (at "../../components/schemas/Request.json#/properties/limit"));
    case "an escaped member name is unescaped" (fun () ->
        Alcotest.(check (option type_name))
          "a/b" (Some Boolean)
          (at "../../components/schemas/Request.json#/properties/a~1b"));
    case "a pointer walks through items and a branch" (fun () ->
        Alcotest.(check (option type_name))
          "names' items" (Some String)
          (at "../../components/schemas/Request.json#/properties/names/items");
        Alcotest.(check (option type_name))
          "either's second" (Some Number)
          (at "../../components/schemas/Request.json#/properties/either/oneOf/1"));
    case "a whole file is its schema" (fun () ->
        Alcotest.(check (option type_name))
          "Request" (Some Object)
          (at "../../components/schemas/Request.json"));
    case "a pointer at no member is refused" (fun () ->
        refused "../../components/schemas/Request.json#/properties/offset");
    case "a pointer past the schema is refused" (fun () ->
        refused "../../components/schemas/Request.json#/properties/limit/items");
    case "a pointer into a file there is none of is refused" (fun () ->
        refused "../../components/schemas/Missing.json#/properties/limit");
    case "a table's record is named by its title, not walked" (fun () ->
        let named key =
          if key = "client/registry.json#/properties/types/0" then Some "Entry"
          else None
        in
        match
          Definitions.referent ~ids ~named ~schemas
            (from_client "../registry.json#/properties/types/0")
        with
        | Some (Definitions.Named "Entry") -> ()
        | _ -> Alcotest.fail "the record is not named Entry");
    case "a member no table names is written in place" (fun () ->
        match
          Definitions.referent ~ids
            ~named:(fun _ -> None)
            ~schemas
            (from_client
               "../../components/schemas/Request.json#/properties/limit")
        with
        | Some (Definitions.In_place (key, s)) ->
            Alcotest.(check string)
              "its key" "components/schemas/Request.json#/properties/limit" key;
            Alcotest.(check (option type_name))
              "its schema" (Some Integer) (type_of (Some s))
        | _ -> Alcotest.fail "the member is not written in place");
  ]

let () = Alcotest.run "definitions" [ ("a $ref's schema", cases) ]
