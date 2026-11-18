(* specs/src/session/cases.json *)

type claims = { iat : int option; exp : int option }

let claims =
  Decode.obj (fun o : claims ->
      {
        iat = Decode.optional o "iat" Decode.int;
        exp = Decode.optional o "exp" Decode.int;
      })

type refresh_schedule_item = {
  why : string;
  claims : claims option;
  now : int;
  delay : int option;
  token : string option;
}

let refresh_schedule_item =
  Decode.obj (fun o : refresh_schedule_item ->
      {
        why = Decode.required o "why" Decode.string;
        claims = Decode.optional o "claims" claims;
        now = Decode.required o "now" Decode.int;
        delay = Decode.required o "delay" (Decode.nullable Decode.int);
        token = Decode.optional o "token" Decode.string;
      })

type token_expiry_item = { why : string; token : string; exp : int option }

let token_expiry_item =
  Decode.obj (fun o : token_expiry_item ->
      {
        why = Decode.required o "why" Decode.string;
        token = Decode.required o "token" Decode.string;
        exp = Decode.required o "exp" (Decode.nullable Decode.int);
      })

type then_ = { asks : int; renewals : int; ends : string }

let then_ =
  Decode.obj (fun o : then_ ->
      {
        asks = Decode.required o "asks" Decode.int;
        renewals = Decode.required o "renewals" Decode.int;
        ends = Decode.required o "ends" Decode.string;
      })

type startup_item = {
  why : string;
  stored : string;
  gateway : string list;
  issuer : string list;
  asks : int;
  renewals : int;
  ends : string;
  told : string option;
  error : string option;
  kept : bool;
  then_ : then_ option;
}

let startup_item =
  Decode.obj (fun o : startup_item ->
      {
        why = Decode.required o "why" Decode.string;
        stored = Decode.required o "stored" Decode.string;
        gateway = Decode.required o "gateway" (Decode.list Decode.string);
        issuer = Decode.required o "issuer" (Decode.list Decode.string);
        asks = Decode.required o "asks" Decode.int;
        renewals = Decode.required o "renewals" Decode.int;
        ends = Decode.required o "ends" Decode.string;
        told = Decode.required o "told" (Decode.nullable Decode.string);
        error = Decode.required o "error" (Decode.nullable Decode.string);
        kept = Decode.required o "kept" Decode.bool;
        then_ = Decode.optional o "then" then_;
      })

type refusal_item_then_ = { asks : int; renewals : int; ends : string }

let refusal_item_then_ =
  Decode.obj (fun o : refusal_item_then_ ->
      {
        asks = Decode.required o "asks" Decode.int;
        renewals = Decode.required o "renewals" Decode.int;
        ends = Decode.required o "ends" Decode.string;
      })

type refusal_item = {
  why : string;
  refused : string;
  issuer : string list;
  gateway : string list;
  asks : int;
  renewals : int;
  given : bool;
  ends : string;
  told : string option;
  error : string option;
  kept : bool;
  then_ : refusal_item_then_ option;
}

let refusal_item =
  Decode.obj (fun o : refusal_item ->
      {
        why = Decode.required o "why" Decode.string;
        refused = Decode.required o "refused" Decode.string;
        issuer = Decode.required o "issuer" (Decode.list Decode.string);
        gateway = Decode.required o "gateway" (Decode.list Decode.string);
        asks = Decode.required o "asks" Decode.int;
        renewals = Decode.required o "renewals" Decode.int;
        given = Decode.required o "given" Decode.bool;
        ends = Decode.required o "ends" Decode.string;
        told = Decode.required o "told" (Decode.nullable Decode.string);
        error = Decode.required o "error" (Decode.nullable Decode.string);
        kept = Decode.required o "kept" Decode.bool;
        then_ = Decode.optional o "then" refusal_item_then_;
      })

type t = {
  comment : string;
  told : Schema.t;
  refresh_schedule : refresh_schedule_item list;
  token_expiry : token_expiry_item list;
  startup : startup_item list;
  refusal : refusal_item list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        told = Decode.required o "told" Schema.decode;
        refresh_schedule =
          Decode.required o "refreshSchedule"
            (Decode.list refresh_schedule_item);
        token_expiry =
          Decode.required o "tokenExpiry" (Decode.list token_expiry_item);
        startup = Decode.required o "startup" (Decode.list startup_item);
        refusal = Decode.required o "refusal" (Decode.list refusal_item);
      })
