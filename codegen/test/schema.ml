(* The one recursion over a schema: [children] names every schema a layer
   holds, [map] rewrites exactly those in that order, and [cata] and [para]
   fold over them. Checked over schemas drawn from a seeded generator. *)

open Xynolog_codegen

let case name test = Alcotest.test_case name `Quick test

(* A schema of at most [depth] levels, each keyword that holds schemas
   stated or not at random. *)
let rec draw state depth : Schema.t =
  let chance () = Random.State.int state 3 = 0 in
  if depth = 0 || Random.State.int state 5 = 0 then
    if chance () then Boolean_schema (Random.State.bool state)
    else
      Schema
        {
          Schema.empty with
          title = Some (string_of_int (Random.State.bits state));
        }
  else
    let child () = draw state (depth - 1) in
    let some f = if chance () then Some (f ()) else None in
    let several () =
      List.init (1 + Random.State.int state 3) (fun _ -> child ())
    in
    Schema
      {
        Schema.empty with
        ref_ =
          some (fun () ->
              { Decode.target = "a.json"; file = "b.json"; pointer = "/$ref" });
        title = some (fun () -> string_of_int (Random.State.bits state));
        properties =
          some (fun () ->
              List.mapi (fun i s -> (Printf.sprintf "p%d" i, s)) (several ()));
        additional_properties = some child;
        property_names = some child;
        items = some child;
        all_of = some several;
        any_of = some several;
        one_of = some several;
        not_ = some child;
      }

let drawn =
  let state = Random.State.make [| 20261117 |] in
  List.init 500 (fun _ -> draw state 5)

let identity schema =
  Schema.cata
    ~boolean:(fun b -> Schema.Boolean_schema b)
    ~schema:(fun l -> Schema.Schema l)
    schema

let layers =
  List.filter_map
    (function Schema.Schema l -> Some l | Boolean_schema _ -> None)
    drawn

let size =
  Schema.cata
    ~boolean:(fun _ -> 1)
    ~schema:(fun l -> List.fold_left ( + ) 1 (Schema.children l))

let rec counted = function
  | Schema.Boolean_schema _ -> 1
  | Schema l -> List.fold_left (fun n c -> n + counted c) 1 (Schema.children l)

let () =
  Alcotest.run "schema"
    [
      ( "fold",
        [
          case "cata with the identity algebra rebuilds the schema" (fun () ->
              List.iter
                (fun s -> Alcotest.(check bool) "rebuilt" true (identity s = s))
                drawn);
          case "para with the identity algebra rebuilds the schema" (fun () ->
              List.iter
                (fun s ->
                  let rebuilt =
                    Schema.para
                      ~boolean:(fun b -> Schema.Boolean_schema b)
                      ~schema:(fun l -> Schema.Schema (Schema.map fst l))
                      s
                  in
                  Alcotest.(check bool) "rebuilt" true (rebuilt = s))
                drawn);
          case "para's results are cata's" (fun () ->
              List.iter
                (fun s ->
                  let folded =
                    Schema.para
                      ~boolean:(fun _ -> 1)
                      ~schema:(fun l ->
                        List.fold_left ( + ) 1
                          (Schema.children (Schema.map snd l)))
                      s
                  in
                  Alcotest.(check int) "size" (size s) folded)
                drawn);
          case "cata visits every schema once" (fun () ->
              List.iter
                (fun s -> Alcotest.(check int) "size" (counted s) (size s))
                drawn);
        ] );
      ( "children",
        [
          case "map rewrites exactly the children, in their order" (fun () ->
              List.iter
                (fun l ->
                  let seen = ref [] in
                  let mapped =
                    Schema.map
                      (fun c ->
                        seen := c :: !seen;
                        Some c)
                      l
                  in
                  Alcotest.(check bool)
                    "children of map" true
                    (Schema.children mapped
                    = List.map Option.some (Schema.children l));
                  Alcotest.(check bool)
                    "visited in order" true
                    (List.rev !seen = Schema.children l))
                layers);
          case "every keyword that holds schemas is a child" (fun () ->
              let leaf n : Schema.t =
                Schema { Schema.empty with title = Some (string_of_int n) }
              in
              let every =
                {
                  Schema.empty with
                  properties = Some [ ("a", leaf 0); ("b", leaf 1) ];
                  additional_properties = Some (leaf 2);
                  property_names = Some (leaf 3);
                  items = Some (leaf 4);
                  all_of = Some [ leaf 5 ];
                  any_of = Some [ leaf 6 ];
                  one_of = Some [ leaf 7 ];
                  not_ = Some (leaf 8);
                }
              in
              Alcotest.(check bool)
                "children" true
                (Schema.children every = List.init 9 leaf));
        ] );
    ]
