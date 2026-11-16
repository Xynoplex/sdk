(* specs/src/stack/cases.json *)

type signal = { type_ : string }

let signal =
  Decode.obj (fun o : signal ->
      { type_ = Decode.required o "type" Decode.string })

type user = { from_env : string }

let user =
  Decode.obj (fun o : user ->
      { from_env = Decode.required o "fromEnv" Decode.string })

type password = { from_env : string }

let password =
  Decode.obj (fun o : password ->
      { from_env = Decode.required o "fromEnv" Decode.string })

type external_ = { servers : string; user : user; password : password }

let external_ =
  Decode.obj (fun o : external_ ->
      {
        servers = Decode.required o "servers" Decode.string;
        user = Decode.required o "user" user;
        password = Decode.required o "password" password;
      })

type messaging = {
  signal : signal option;
  image : unit option;
  resources : unit option;
  external_ : external_;
}

let messaging =
  Decode.obj (fun o : messaging ->
      {
        signal = Decode.optional o "signal" signal;
        image = Decode.optional o "image" Decode.null;
        resources = Decode.optional o "resources" Decode.null;
        external_ = Decode.required o "external" external_;
      })

type shared = { access_token_lifespan : unit }

let shared =
  Decode.obj (fun o : shared ->
      {
        access_token_lifespan =
          Decode.required o "accessTokenLifespan" Decode.null;
      })

type issuer_external_ = { type_ : string; url : string }

let issuer_external_ =
  Decode.obj (fun o : issuer_external_ ->
      {
        type_ = Decode.required o "type" Decode.string;
        url = Decode.required o "url" Decode.string;
      })

type issuer = {
  shared : shared option option;
  external_ : issuer_external_ option;
  ref : string option;
}

let issuer =
  Decode.obj (fun o : issuer ->
      {
        shared = Decode.optional o "shared" (Decode.nullable shared);
        external_ = Decode.optional o "external" issuer_external_;
        ref = Decode.optional o "ref" Decode.string;
      })

type gateway = { imgae : string option; port : string option }

let gateway =
  Decode.obj (fun o : gateway ->
      {
        imgae = Decode.optional o "imgae" Decode.string;
        port = Decode.optional o "port" Decode.string;
      })

type dispatcher = { image : unit }

let dispatcher =
  Decode.obj (fun o : dispatcher ->
      { image = Decode.required o "image" Decode.null })

type limits = { memory : string }

let limits =
  Decode.obj (fun o : limits ->
      { memory = Decode.required o "memory" Decode.string })

type resources = { limits : limits }

let resources =
  Decode.obj (fun o : resources ->
      { limits = Decode.required o "limits" limits })

type smelter = { resources : resources option; pdfs_at_once : int option }

let smelter =
  Decode.obj (fun o : smelter ->
      {
        resources = Decode.optional o "resources" resources;
        pdfs_at_once = Decode.optional o "pdfsAtOnce" Decode.int;
      })

type graph_external__password = { from_env : string }

let graph_external__password =
  Decode.obj (fun o : graph_external__password ->
      { from_env = Decode.required o "fromEnv" Decode.string })

type graph_external_ = { uri : string; password : graph_external__password }

let graph_external_ =
  Decode.obj (fun o : graph_external_ ->
      {
        uri = Decode.required o "uri" Decode.string;
        password = Decode.required o "password" graph_external__password;
      })

type graph = {
  image : unit;
  resources : unit;
  external_ : graph_external_ option;
}

let graph =
  Decode.obj (fun o : graph ->
      {
        image = Decode.required o "image" Decode.null;
        resources = Decode.required o "resources" Decode.null;
        external_ = Decode.optional o "external" graph_external_;
      })

type vectors_shared = { port : int }

let vectors_shared =
  Decode.obj (fun o : vectors_shared ->
      { port = Decode.required o "port" Decode.int })

type smelter_token = { from_env : string }

let smelter_token =
  Decode.obj (fun o : smelter_token ->
      { from_env = Decode.required o "fromEnv" Decode.string })

type librarian_token = { from_env : string }

let librarian_token =
  Decode.obj (fun o : librarian_token ->
      { from_env = Decode.required o "fromEnv" Decode.string })

type vectors_external_ = {
  host : string;
  port : int;
  smelter_token : smelter_token;
  librarian_token : librarian_token option;
}

let vectors_external_ =
  Decode.obj (fun o : vectors_external_ ->
      {
        host = Decode.required o "host" Decode.string;
        port = Decode.required o "port" Decode.int;
        smelter_token = Decode.required o "smelterToken" smelter_token;
        librarian_token = Decode.optional o "librarianToken" librarian_token;
      })

type vectors_resources_limits = { memory : string }

let vectors_resources_limits =
  Decode.obj (fun o : vectors_resources_limits ->
      { memory = Decode.required o "memory" Decode.string })

type vectors_resources = { limits : vectors_resources_limits }

let vectors_resources =
  Decode.obj (fun o : vectors_resources ->
      { limits = Decode.required o "limits" vectors_resources_limits })

type vectors = {
  shared : vectors_shared option option;
  external_ : vectors_external_ option;
  image : string option;
  resources : vectors_resources option;
}

let vectors =
  Decode.obj (fun o : vectors ->
      {
        shared = Decode.optional o "shared" (Decode.nullable vectors_shared);
        external_ = Decode.optional o "external" vectors_external_;
        image = Decode.optional o "image" Decode.string;
        resources = Decode.optional o "resources" vectors_resources;
      })

type spec_external_ = { host : string; port : int }

let spec_external_ =
  Decode.obj (fun o : spec_external_ ->
      {
        host = Decode.required o "host" Decode.string;
        port = Decode.required o "port" Decode.int;
      })

type search = { semantic_floor : float }

let search =
  Decode.obj (fun o : search ->
      { semantic_floor = Decode.required o "semanticFloor" Decode.number })

type librarian = { search : search }

let librarian =
  Decode.obj (fun o : librarian ->
      { search = Decode.required o "search" search })

type database_external__password = { from_env : string }

let database_external__password =
  Decode.obj (fun o : database_external__password ->
      { from_env = Decode.required o "fromEnv" Decode.string })

type database_external_ = {
  host : string;
  port : int;
  password : database_external__password;
}

let database_external_ =
  Decode.obj (fun o : database_external_ ->
      {
        host = Decode.required o "host" Decode.string;
        port = Decode.required o "port" Decode.int;
        password = Decode.required o "password" database_external__password;
      })

type database = {
  name : string option;
  external_ : database_external_ option;
  image : unit option;
  resources : unit option;
  port : unit option;
}

let database =
  Decode.obj (fun o : database ->
      {
        name = Decode.optional o "name" Decode.string;
        external_ = Decode.optional o "external" database_external_;
        image = Decode.optional o "image" Decode.null;
        resources = Decode.optional o "resources" Decode.null;
        port = Decode.optional o "port" Decode.null;
      })

type api_key_api_key = { from_env : string }

let api_key_api_key =
  Decode.obj (fun o : api_key_api_key ->
      { from_env = Decode.required o "fromEnv" Decode.string })

type api_key = String of string | Object of api_key_api_key

let api_key =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : api_key)
  | Decode.Object -> (Object (api_key_api_key c) : api_key)
  | _ -> Decode.refuse c "expected a string or an object"

type anthropic = { api_key : api_key }

let anthropic =
  Decode.obj (fun o : anthropic ->
      { api_key = Decode.required o "apiKey" api_key })

type providers = { mistral : unit option; anthropic : anthropic option }

let providers =
  Decode.obj (fun o : providers ->
      {
        mistral = Decode.optional o "mistral" (Decode.obj (fun _ -> ()));
        anthropic = Decode.optional o "anthropic" anthropic;
      })

type yield = { provider : string }

let yield =
  Decode.obj (fun o : yield ->
      { provider = Decode.required o "provider" Decode.string })

type jobs = { yield : yield }

let jobs =
  Decode.obj (fun o : jobs -> { yield = Decode.required o "yield" yield })

type engines = { actors : unit option; jobs : jobs option }

let engines =
  Decode.obj (fun o : engines ->
      {
        actors = Decode.optional o "actors" Decode.null;
        jobs = Decode.optional o "jobs" jobs;
      })

type spec = {
  messaging : messaging option;
  issuer : issuer option;
  gateway : gateway option;
  dispatcher : dispatcher option;
  smelter : smelter option;
  graph : graph option;
  vectors : vectors option;
  type_ : unit option;
  image : unit option;
  resources : unit option;
  port : unit option;
  external_ : spec_external_ option;
  librarian : librarian option;
  database : database option option;
  access_token_lifespan : int option;
  providers : providers option;
  engines : engines option;
}

let spec =
  Decode.obj (fun o : spec ->
      {
        messaging = Decode.optional o "messaging" messaging;
        issuer = Decode.optional o "issuer" issuer;
        gateway = Decode.optional o "gateway" gateway;
        dispatcher = Decode.optional o "dispatcher" dispatcher;
        smelter = Decode.optional o "smelter" smelter;
        graph = Decode.optional o "graph" graph;
        vectors = Decode.optional o "vectors" vectors;
        type_ = Decode.optional o "type" Decode.null;
        image = Decode.optional o "image" Decode.null;
        resources = Decode.optional o "resources" Decode.null;
        port = Decode.optional o "port" Decode.null;
        external_ = Decode.optional o "external" spec_external_;
        librarian = Decode.optional o "librarian" librarian;
        database = Decode.optional o "database" (Decode.nullable database);
        access_token_lifespan =
          Decode.optional o "accessTokenLifespan" Decode.int;
        providers = Decode.optional o "providers" providers;
        engines = Decode.optional o "engines" engines;
      })

type project = { version : unit }

let project =
  Decode.obj (fun o : project ->
      { version = Decode.required o "version" Decode.null })

type site = { admin_email : string option; domain : unit option }

let site =
  Decode.obj (fun o : site ->
      {
        admin_email = Decode.optional o "adminEmail" Decode.string;
        domain = Decode.optional o "domain" Decode.null;
      })

type patch = {
  spec : spec option;
  api_version : string option;
  kind : string option;
  project : project option;
  site : site option;
}

let patch =
  Decode.obj (fun o : patch ->
      {
        spec = Decode.optional o "spec" spec;
        api_version = Decode.optional o "apiVersion" Decode.string;
        kind = Decode.optional o "kind" Decode.string;
        project = Decode.optional o "project" project;
        site = Decode.optional o "site" site;
      })

type case = {
  why : string;
  schema : string;
  base : string option;
  patch : patch option;
  verdict : string;
  at : string option;
  reason : string option;
  document : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        schema = Decode.required o "schema" Decode.string;
        base = Decode.optional o "base" Decode.string;
        patch = Decode.optional o "patch" patch;
        verdict = Decode.required o "verdict" Decode.string;
        at = Decode.optional o "at" Decode.string;
        reason = Decode.optional o "reason" Decode.string;
        document = Decode.optional o "document" Decode.string;
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
