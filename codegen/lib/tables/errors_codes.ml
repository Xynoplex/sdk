(* specs/src/errors/codes.json *)

type code = { code : string; docs : string; wire : string option }

let code =
  Decode.obj (fun o : code ->
      {
        code = Decode.required o "code" Decode.string;
        docs = Decode.required o "docs" Decode.string;
        wire = Decode.optional o "wire" Decode.string;
      })

type bus_request = {
  docs : string;
  unrecognized_failure : string;
  codes : code list;
}

let bus_request =
  Decode.obj (fun o : bus_request ->
      {
        docs = Decode.required o "docs" Decode.string;
        unrecognized_failure =
          Decode.required o "unrecognizedFailure" Decode.string;
        codes = Decode.required o "codes" (Decode.list code);
      })

type transport_code = {
  code : string;
  status : int option;
  docs : string;
  status_from : int option;
}

let transport_code =
  Decode.obj (fun o : transport_code ->
      {
        code = Decode.required o "code" Decode.string;
        status = Decode.optional o "status" Decode.int;
        docs = Decode.required o "docs" Decode.string;
        status_from = Decode.optional o "statusFrom" Decode.int;
      })

type transport = {
  docs : string;
  unclassified : string;
  codes : transport_code list;
}

let transport =
  Decode.obj (fun o : transport ->
      {
        docs = Decode.required o "docs" Decode.string;
        unclassified = Decode.required o "unclassified" Decode.string;
        codes = Decode.required o "codes" (Decode.list transport_code);
      })

type job_code = { code : string; docs : string }

let job_code =
  Decode.obj (fun o : job_code ->
      {
        code = Decode.required o "code" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type job = { docs : string; codes : job_code list }

let job =
  Decode.obj (fun o : job ->
      {
        docs = Decode.required o "docs" Decode.string;
        codes = Decode.required o "codes" (Decode.list job_code);
      })

type session_code = { code : string; docs : string }

let session_code =
  Decode.obj (fun o : session_code ->
      {
        code = Decode.required o "code" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type session = { docs : string; codes : session_code list }

let session =
  Decode.obj (fun o : session ->
      {
        docs = Decode.required o "docs" Decode.string;
        codes = Decode.required o "codes" (Decode.list session_code);
      })

type sign_in_code = { code : string; docs : string }

let sign_in_code =
  Decode.obj (fun o : sign_in_code ->
      {
        code = Decode.required o "code" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type sign_in = { docs : string; codes : sign_in_code list }

let sign_in =
  Decode.obj (fun o : sign_in ->
      {
        docs = Decode.required o "docs" Decode.string;
        codes = Decode.required o "codes" (Decode.list sign_in_code);
      })

type kb_identity_code = { code : string; docs : string }

let kb_identity_code =
  Decode.obj (fun o : kb_identity_code ->
      {
        code = Decode.required o "code" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type kb_identity = { docs : string; codes : kb_identity_code list }

let kb_identity =
  Decode.obj (fun o : kb_identity ->
      {
        docs = Decode.required o "docs" Decode.string;
        codes = Decode.required o "codes" (Decode.list kb_identity_code);
      })

type span_refusal_code = { code : string; docs : string }

let span_refusal_code =
  Decode.obj (fun o : span_refusal_code ->
      {
        code = Decode.required o "code" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type span_refusal = { docs : string; codes : span_refusal_code list }

let span_refusal =
  Decode.obj (fun o : span_refusal ->
      {
        docs = Decode.required o "docs" Decode.string;
        codes = Decode.required o "codes" (Decode.list span_refusal_code);
      })

type control_code = { code : string; docs : string }

let control_code =
  Decode.obj (fun o : control_code ->
      {
        code = Decode.required o "code" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type control = { docs : string; codes : control_code list }

let control =
  Decode.obj (fun o : control ->
      {
        docs = Decode.required o "docs" Decode.string;
        codes = Decode.required o "codes" (Decode.list control_code);
      })

type t = {
  comment : string;
  bus_request : bus_request;
  transport : transport;
  job : job;
  session : session;
  sign_in : sign_in;
  kb_identity : kb_identity;
  span_refusal : span_refusal;
  control : control;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        bus_request = Decode.required o "busRequest" bus_request;
        transport = Decode.required o "transport" transport;
        job = Decode.required o "job" job;
        session = Decode.required o "session" session;
        sign_in = Decode.required o "signIn" sign_in;
        kb_identity = Decode.required o "kbIdentity" kb_identity;
        span_refusal = Decode.required o "spanRefusal" span_refusal;
        control = Decode.required o "control" control;
      })
