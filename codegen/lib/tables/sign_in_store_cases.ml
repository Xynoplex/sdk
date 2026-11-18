(* specs/src/sign-in-store/cases.json *)

type case = {
  why : string;
  os : string;
  home : string option;
  xdg_state_home : string option;
  dir : string option;
  local_app_data : string option option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        os = Decode.required o "os" Decode.string;
        home = Decode.required o "home" (Decode.nullable Decode.string);
        xdg_state_home =
          Decode.required o "xdgStateHome" (Decode.nullable Decode.string);
        dir = Decode.required o "dir" (Decode.nullable Decode.string);
        local_app_data =
          Decode.optional o "localAppData" (Decode.nullable Decode.string);
      })

type kept = { token : string; refresh_token : string }

let kept =
  Decode.obj (fun o : kept ->
      {
        token = Decode.required o "token" Decode.string;
        refresh_token = Decode.required o "refreshToken" Decode.string;
      })

type theirs = { token : string; refresh_token : string }

let theirs =
  Decode.obj (fun o : theirs ->
      {
        token = Decode.required o "token" Decode.string;
        refresh_token = Decode.required o "refreshToken" Decode.string;
      })

type meanwhile = { when_ : string; does : string; theirs : theirs option }

let meanwhile =
  Decode.obj (fun o : meanwhile ->
      {
        when_ = Decode.required o "when" Decode.string;
        does = Decode.required o "does" Decode.string;
        theirs = Decode.optional o "theirs" theirs;
      })

type issues = { token : string; refresh_token : string option }

let issues =
  Decode.obj (fun o : issues ->
      {
        token = Decode.required o "token" Decode.string;
        refresh_token = Decode.optional o "refreshToken" Decode.string;
      })

type leaves = { token : string; refresh_token : string }

let leaves =
  Decode.obj (fun o : leaves ->
      {
        token = Decode.required o "token" Decode.string;
        refresh_token = Decode.required o "refreshToken" Decode.string;
      })

type renewal = {
  why : string;
  kept : kept;
  holding : string option;
  meanwhile : meanwhile option;
  expired : string list;
  issues : issues;
  spends : string option;
  leaves : leaves option;
  gives : string option;
}

let renewal =
  Decode.obj (fun o : renewal ->
      {
        why = Decode.required o "why" Decode.string;
        kept = Decode.required o "kept" kept;
        holding = Decode.required o "holding" (Decode.nullable Decode.string);
        meanwhile = Decode.required o "meanwhile" (Decode.nullable meanwhile);
        expired = Decode.required o "expired" (Decode.list Decode.string);
        issues = Decode.required o "issues" issues;
        spends = Decode.required o "spends" (Decode.nullable Decode.string);
        leaves = Decode.required o "leaves" (Decode.nullable leaves);
        gives = Decode.required o "gives" (Decode.nullable Decode.string);
      })

type t = { comment : string; cases : case list; renewals : renewal list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
        renewals = Decode.required o "renewals" (Decode.list renewal);
      })
