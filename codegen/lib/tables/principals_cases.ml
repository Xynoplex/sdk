(* specs/src/principals/cases.json *)

type people_item = {
  why : string;
  domain : string;
  subject : string;
  did : string;
}

let people_item =
  Decode.obj (fun o : people_item ->
      {
        why = Decode.required o "why" Decode.string;
        domain = Decode.required o "domain" Decode.string;
        subject = Decode.required o "subject" Decode.string;
        did = Decode.required o "did" Decode.string;
      })

type agent = { why : string; domain : string; subject : string; did : string }

let agent =
  Decode.obj (fun o : agent ->
      {
        why = Decode.required o "why" Decode.string;
        domain = Decode.required o "domain" Decode.string;
        subject = Decode.required o "subject" Decode.string;
        did = Decode.required o "did" Decode.string;
      })

type t = {
  comment : string;
  run_by : Case_table.run_by;
  absent : Case_table.explanations;
  person : string;
  people : people_item list;
  agent : string;
  agents : agent list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        absent = Decode.required o "absent" Case_table.explanations;
        person = Decode.required o "person" Decode.string;
        people = Decode.required o "people" (Decode.list people_item);
        agent = Decode.required o "agent" Decode.string;
        agents = Decode.required o "agents" (Decode.list agent);
      })
