(* The testing kit's table (protocol/specs/src/client/testing.json), held to
   what every writer reads of it. What a fault holds is a whole number of
   milliseconds drawn from the delay bounds, the only thing the table lets a
   fault hold, and each range is one. A record's members are the table's, each
   of the type a writer gives it in its language, which is that language's
   own: a member the table has and the writer gives no type, or one the writer
   types and the table no longer has, is refused. *)

module T = Tables.Client_testing

let file = "client/testing.json"
let from_ = "protocol/specs/src/" ^ file
let refusal pointer message = { Decode.file; pointer; message }

let derive (table : T.t) =
  let refusals = ref [] in
  let refuse pointer message =
    refusals := refusal pointer message :: !refusals
  in
  List.iteri
    (fun i (fault : T.fault_actions_item) ->
      match fault.holds with
      | [] | [ "ms" ] -> ()
      | _ ->
          refuse
            (Printf.sprintf "/faultActions/%d/holds" i)
            "holds what is not one delay of milliseconds")
    table.fault_actions;
  (* JSON Schema cannot bound one member by another, so the schema leaves a
     range's maximum free of its minimum. *)
  List.iter
    (fun (at, minimum, maximum) ->
      if maximum < minimum then
        refuse at
          (Printf.sprintf "is from %d up to %d, which is no range" minimum
             maximum))
    [
      ("/delayMs", table.delay_ms.minimum, table.delay_ms.maximum);
      ( "/scheduleLength",
        table.schedule_length.minimum,
        table.schedule_length.maximum );
    ];
  match List.rev !refusals with [] -> Ok table | errors -> Error errors

(* Each of [table]'s records, with its members each of the type [types]
   gives it in [language], in the table's order. *)
let typed ~language types (table : T.t) =
  let refusals = ref [] in
  let refuse pointer message =
    refusals := refusal pointer message :: !refusals
  in
  let records =
    List.mapi
      (fun i (record : T.records_item) ->
        let at = Printf.sprintf "/records/%d" i in
        match List.assoc_opt record.name types with
        | None ->
            refuse at
              (Printf.sprintf "%s is a record no %s type is given for"
                 record.name language);
            (record, [])
        | Some members ->
            List.iter
              (fun (member, _) ->
                if not (List.mem member record.members) then
                  refuse at
                    (Printf.sprintf "%s has no %s, and %s types one" record.name
                       member language))
              members;
            ( record,
              List.filter_map
                (fun member ->
                  match List.assoc_opt member members with
                  | Some t -> Some (member, t)
                  | None ->
                      refuse at
                        (Printf.sprintf "%s's %s is a member %s gives no type"
                           record.name member language);
                      None)
                record.members ))
      table.records
  in
  List.iter
    (fun (name, _) ->
      if
        not
          (List.exists
             (fun (r : T.records_item) -> r.name = name)
             table.records)
      then
        refuse "/records"
          (Printf.sprintf "%s is no record, and %s types one" name language))
    types;
  match List.rev !refusals with [] -> Ok records | errors -> Error errors

let record name = List.find (fun ((r : T.records_item), _) -> r.name = name)
