(* Shared worker filter cases from jobs/filter-cases.json. *)
let () =
  let open Yojson.Safe.Util in
  Protocol.member "jobs/filter-cases.json" "cases"
  |> to_list
  |> List.iter (fun row ->
      let filters = `List [ member "filter" row ] in
      let announcement = member "job" row in
      Alcotest.(check bool)
        (member "why" row |> to_string)
        (member "matches" row |> to_bool)
        (Xynolog.Worker.accepts ~filters ~announcement))
