(* The records Protocol states inside a table rather than in files of their
   own, and how a [$ref] names one. *)

(* Where a [$ref] points: the file it names, and the place in it when it names
   one. A record stated inside a table is named by both. *)
let key (r : Decode.reference) =
  match Decode.resolve r with
  | file, "" -> file
  | file, pointer -> file ^ "#" ^ pointer

(* Each record, by the file and pointer a [$ref] names it by, and named by its
   title: the types a registry of knowledge bases hands its caller, what the
   state units' signals say, why a session ended, and the stored session. *)
let all (spec : Spec.t) : ((string * string * Schema.t) list, string) result =
  let t = spec.tables in
  let within file member =
    List.map (fun (name, s) ->
        (file ^ "#/" ^ member ^ "/" ^ Decode.escape name, s))
  in
  let titled found (key, s) =
    Result.bind found (fun found ->
        match s with
        | Schema.Schema { title = Some title; _ } ->
            Ok ((key, title, s) :: found)
        | _ -> Error (key ^ " states a record with no title"))
  in
  Result.map List.rev
  @@ List.fold_left titled (Ok [])
       (within "client/registry.json" "types" t.client_registry.types
       @ within "client/state-units.json" "notices" t.client_state_units.notices
       @ [
           ("session/cases.json#/told", t.session_cases.told);
           ( "session/stored.json#/storedSession",
             t.session_stored.stored_session );
         ])
