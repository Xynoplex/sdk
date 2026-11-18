(* specs/src/session/client-assertion-cases.json *)

type jwk = { kty : string; n : string; e : string }

let jwk =
  Decode.obj (fun o : jwk ->
      {
        kty = Decode.required o "kty" Decode.string;
        n = Decode.required o "n" Decode.string;
        e = Decode.required o "e" Decode.string;
      })

type thumbprint = { why : string; jwk : jwk; thumbprint : string }

let thumbprint =
  Decode.obj (fun o : thumbprint ->
      {
        why = Decode.required o "why" Decode.string;
        jwk = Decode.required o "jwk" jwk;
        thumbprint = Decode.required o "thumbprint" Decode.string;
      })

type case_jwk = { kty : string; n : string; e : string }

let case_jwk =
  Decode.obj (fun o : case_jwk ->
      {
        kty = Decode.required o "kty" Decode.string;
        n = Decode.required o "n" Decode.string;
        e = Decode.required o "e" Decode.string;
      })

type header = { alg : string; kid : string }

let header =
  Decode.obj (fun o : header ->
      {
        alg = Decode.required o "alg" Decode.string;
        kid = Decode.required o "kid" Decode.string;
      })

type claims = {
  iss : string;
  sub : string;
  aud : string;
  jti : string;
  iat : int;
  exp : int;
}

let claims =
  Decode.obj (fun o : claims ->
      {
        iss = Decode.required o "iss" Decode.string;
        sub = Decode.required o "sub" Decode.string;
        aud = Decode.required o "aud" Decode.string;
        jti = Decode.required o "jti" Decode.string;
        iat = Decode.required o "iat" Decode.int;
        exp = Decode.required o "exp" Decode.int;
      })

type case = {
  why : string;
  jwk : case_jwk;
  client_id : string;
  token_endpoint : string;
  issued_at : int;
  jti : string;
  header : header;
  claims : claims;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        jwk = Decode.required o "jwk" case_jwk;
        client_id = Decode.required o "clientId" Decode.string;
        token_endpoint = Decode.required o "tokenEndpoint" Decode.string;
        issued_at = Decode.required o "issuedAt" Decode.int;
        jti = Decode.required o "jti" Decode.string;
        header = Decode.required o "header" header;
        claims = Decode.required o "claims" claims;
      })

type t = {
  comment : string;
  form : string list;
  grant_type : string;
  assertion_type : string;
  lifetime_seconds : int;
  thumbprints : thumbprint list;
  cases : case list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        form = Decode.required o "form" (Decode.list Decode.string);
        grant_type = Decode.required o "grantType" Decode.string;
        assertion_type = Decode.required o "assertionType" Decode.string;
        lifetime_seconds = Decode.required o "lifetimeSeconds" Decode.int;
        thumbprints = Decode.required o "thumbprints" (Decode.list thumbprint);
        cases = Decode.required o "cases" (Decode.list case);
      })
