(* specs/src/errors/codes.json *)

type code = { code : string; docs : string }

let code =
  Decode.obj (fun o : code ->
      let code = Decode.required o "code" Decode.non_empty_string in
      let docs = Decode.required o "docs" Decode.non_empty_string in
      { code; docs })

(* A vocabulary that states nothing of its codes but each one's docs. *)
type vocabulary = { docs : string; codes : code list }

let vocabulary =
  Decode.obj (fun o : vocabulary ->
      let docs = Decode.required o "docs" Decode.non_empty_string in
      let codes = Decode.required o "codes" (Decode.non_empty_list code) in
      { docs; codes })

type bus_code = { code : string; docs : string; wire : string option }

let bus_code =
  Decode.obj (fun o : bus_code ->
      let code = Decode.required o "code" Decode.non_empty_string in
      let docs = Decode.required o "docs" Decode.non_empty_string in
      let wire = Decode.optional o "wire" Decode.non_empty_string in
      { code; docs; wire })

type bus_request = {
  docs : string;
  unrecognized_failure : string;
  codes : bus_code list;
}

let bus_request =
  Decode.obj (fun o : bus_request ->
      let docs = Decode.required o "docs" Decode.non_empty_string in
      let unrecognized_failure =
        Decode.required o "unrecognizedFailure" Decode.non_empty_string
      in
      let codes = Decode.required o "codes" (Decode.non_empty_list bus_code) in
      { docs; unrecognized_failure; codes })

(* The HTTP statuses a transport code is read from: one, every one from a
   status up, or none. *)
type statuses = Status of int | Status_from of int | No_status

let statuses o =
  let cursor = Decode.at o in
  match
    (Decode.has_member "status" cursor, Decode.has_member "statusFrom" cursor)
  with
  | true, true -> Decode.refuse cursor "states both a status and a statusFrom"
  | true, false -> Status (Decode.required o "status" Decode.int)
  | false, true -> Status_from (Decode.required o "statusFrom" Decode.int)
  | false, false -> No_status

type transport_code = { code : string; docs : string; statuses : statuses }

let transport_code =
  Decode.obj (fun o : transport_code ->
      let code = Decode.required o "code" Decode.non_empty_string in
      let docs = Decode.required o "docs" Decode.non_empty_string in
      let statuses = statuses o in
      { code; docs; statuses })

type transport = {
  docs : string;
  unclassified : string;
  codes : transport_code list;
}

let transport =
  Decode.obj (fun o : transport ->
      let docs = Decode.required o "docs" Decode.non_empty_string in
      let unclassified =
        Decode.required o "unclassified" Decode.non_empty_string
      in
      let codes =
        Decode.required o "codes" (Decode.non_empty_list transport_code)
      in
      { docs; unclassified; codes })

type t = {
  comment : string;
  bus_request : bus_request;
  transport : transport;
  job : vocabulary;
  session : vocabulary;
  sign_in : vocabulary;
  kb_identity : vocabulary;
  span_refusal : vocabulary;
  control : vocabulary;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        bus_request = Decode.required o "busRequest" bus_request;
        transport = Decode.required o "transport" transport;
        job = Decode.required o "job" vocabulary;
        session = Decode.required o "session" vocabulary;
        sign_in = Decode.required o "signIn" vocabulary;
        kb_identity = Decode.required o "kbIdentity" vocabulary;
        span_refusal = Decode.required o "spanRefusal" vocabulary;
        control = Decode.required o "control" vocabulary;
      })
