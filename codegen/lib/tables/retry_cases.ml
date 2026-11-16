(* specs/src/retry/cases.json *)

type rule_boot = { why : string; status : int; retries : bool }

let rule_boot =
  Decode.obj (fun o : rule_boot ->
      Decode.required o "rule" (Decode.literal "boot");
      {
        why = Decode.required o "why" Decode.string;
        status = Decode.required o "status" Decode.int;
        retries = Decode.required o "retries" Decode.bool;
      })

type rule_job = { why : string; status : int; retries : bool }

let rule_job =
  Decode.obj (fun o : rule_job ->
      Decode.required o "rule" (Decode.literal "job");
      {
        why = Decode.required o "why" Decode.string;
        status = Decode.required o "status" Decode.int;
        retries = Decode.required o "retries" Decode.bool;
      })

type rule_transport = {
  why : string;
  status : int option;
  method_ : string option;
  retries : bool;
  keyed : bool option;
}

let rule_transport =
  Decode.obj (fun o : rule_transport ->
      Decode.required o "rule" (Decode.literal "transport");
      {
        why = Decode.required o "why" Decode.string;
        status = Decode.optional o "status" Decode.int;
        method_ = Decode.optional o "method" Decode.string;
        retries = Decode.required o "retries" Decode.bool;
        keyed = Decode.optional o "keyed" Decode.bool;
      })

type rule_refresh = { why : string; retries : bool; status : int option }

let rule_refresh =
  Decode.obj (fun o : rule_refresh ->
      Decode.required o "rule" (Decode.literal "refresh");
      {
        why = Decode.required o "why" Decode.string;
        retries = Decode.required o "retries" Decode.bool;
        status = Decode.optional o "status" Decode.int;
      })

type rule =
  | Boot of rule_boot
  | Job of rule_job
  | Transport of rule_transport
  | Refresh of rule_refresh

let rule =
  Decode.variant "rule"
    [
      ("boot", fun c -> (Boot (rule_boot c) : rule));
      ("job", fun c -> (Job (rule_job c) : rule));
      ("transport", fun c -> (Transport (rule_transport c) : rule));
      ("refresh", fun c -> (Refresh (rule_refresh c) : rule));
    ]

type retry_after_item = {
  why : string;
  header : string option;
  ms : int option;
}

let retry_after_item =
  Decode.obj (fun o : retry_after_item ->
      {
        why = Decode.required o "why" Decode.string;
        header = Decode.required o "header" (Decode.nullable Decode.string);
        ms = Decode.required o "ms" (Decode.nullable Decode.int);
      })

type t = {
  comment : string;
  run_by : Case_table.run_by;
  rules : rule list;
  retry_after : retry_after_item list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        rules = Decode.required o "rules" (Decode.list rule);
        retry_after =
          Decode.required o "retryAfter" (Decode.list retry_after_item);
      })
