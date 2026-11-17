(* The stored group: what a registry of knowledge bases keeps in a
   SessionStorage (protocol/specs/src/session/stored.json), for the Python
   SDK. A registry in one SDK finds what one in another wrote, over one
   storage, only if both say these alike: the key each thing is kept under,
   the prefixes of the keys made per knowledge base, the stored session's
   shape, an open resource's, the stream's places, and the queries a client
   keeps (those client/refresh.json marks persisted), with the key of one per
   nothing and the version of what keeps them.

   A fixed key is a constant's name ending in Key, stated once, and begins
   with no prefix. The stored session is a flat schema with no date-time. An
   open resource's members are kinds of id, text and whole numbers. The
   stream's places are named by a kind of id, each a component. *)

module T = Tables.Session_stored

let file = "session/stored.json"
let snake name = String.lowercase_ascii (Text.upper_snake name)
let schemas_prefix = "../components/schemas/"

type field = {
  name : string;
  description : string;
  required : bool;
  type_ : string;  (** As Python names it. *)
  kind : string option;  (** The kind of id it is. *)
  least : int option;
}

type kept = { query : string; keyed_by : string option; value : string }

type t = {
  table : T.t;
  session : Sign_in.Flat.t;
  open_resource : field list;
  scope : string;
  place : string;
  kinds : string list;
  kept : kept list;
}

let derive (spec : Spec.t) ~kinds ~(refresh : Cache_refresh.Table.t) =
  let table = spec.tables.session_stored in
  let refusals = ref [] in
  let refuse pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  if table.keys = [] then refuse "/keys" "states none";
  List.iteri
    (fun i (k : T.key) ->
      let at = Printf.sprintf "/keys/%d" i in
      if
        not
          (String.ends_with ~suffix:"Key" k.member
          && Sign_in.Flat.is_property_name k.member)
      then
        refuse (at ^ "/member")
          (Printf.sprintf "is %S, not a constant's name ending in Key" k.member);
      if k.key = "" then refuse (at ^ "/key") "is empty";
      if k.docs = "" then refuse (at ^ "/docs") "is empty";
      match List.find_index (fun (o : T.key) -> o.key = k.key) table.keys with
      | Some j when j < i ->
          refuse (at ^ "/key")
            (Printf.sprintf "is %s, which /keys/%d states already" k.key j)
      | _ -> ())
    table.keys;
  List.iter
    (fun (member, prefix, docs) ->
      if prefix = "" then refuse ("/" ^ member ^ "/prefix") "is empty";
      if docs = "" then refuse ("/" ^ member ^ "/docs") "is empty";
      List.iter
        (fun (k : T.key) ->
          if prefix <> "" && String.starts_with ~prefix k.key then
            refuse
              ("/" ^ member ^ "/prefix")
              (Printf.sprintf
                 "is %S, which the fixed key %s begins with, so it would read \
                  as one of its keys"
                 prefix k.key))
        table.keys)
    [
      ( "sessionKeyPrefix",
        table.session_key_prefix.prefix,
        table.session_key_prefix.docs );
      ( "lastEventIdKeyPrefix",
        table.last_event_id_key_prefix.prefix,
        table.last_event_id_key_prefix.docs );
      ( "cacheKeyPrefix",
        table.cache_key_prefix.prefix,
        table.cache_key_prefix.docs );
    ];
  let session =
    match Sign_in.Flat.read ~file table.stored_session with
    | Error errors ->
        List.iter
          (fun (e : Decode.error) ->
            refuse ("/storedSession" ^ e.pointer) e.message)
          errors;
        None
    | Ok session ->
        if
          List.exists (fun (f : Sign_in.Flat.field) -> f.is_time) session.fields
        then
          refuse "/storedSession"
            "has a date-time, which a stored session does not";
        Some session
  in
  (* The component a reference to one names. *)
  let component at reference =
    let name =
      if
        String.starts_with ~prefix:schemas_prefix reference
        && String.ends_with ~suffix:".json" reference
      then
        let n = String.length schemas_prefix in
        String.sub reference n (String.length reference - n - 5)
      else ""
    in
    if
      name = ""
      || not
           (List.mem_assoc
              ("components/schemas/" ^ name ^ ".json")
              spec.schemas)
    then (
      refuse at
        (Printf.sprintf "is %S, not a reference to a component" reference);
      "")
    else name
  in
  let o = table.open_resource in
  let at_open = "/openResource" in
  if o.type_ <> "object" then refuse (at_open ^ "/type") "is not object";
  if not (Sign_in.Flat.is_type_name o.title) then
    refuse (at_open ^ "/title") "names no type";
  if o.description = "" then refuse (at_open ^ "/description") "is empty";
  if o.required = [] then refuse (at_open ^ "/required") "requires nothing";
  let p = o.properties in
  (* A member of text or a whole number states the JSON type it is; a kind
     of id is its kind's. *)
  let field name ~description ~type_ ?kind ?least ?stated () =
    let at = at_open ^ "/properties/" ^ name in
    if description = "" then refuse (at ^ "/description") "is empty";
    (match stated with
    | Some stated when stated <> if type_ = "int" then "integer" else "string"
      ->
        refuse (at ^ "/type")
          (Printf.sprintf "is %S, which this member is not" stated)
    | _ -> ());
    {
      name;
      description;
      required = List.mem name o.required;
      type_;
      kind;
      least;
    }
  in
  let id =
    let at = at_open ^ "/properties/id/allOf" in
    match p.id.all_of with
    | [ (only : T.id_all_of_item) ] ->
        let kind = component (at ^ "/0/$ref") only.ref in
        if kind <> "" && not (List.mem kind kinds) then
          refuse (at ^ "/0/$ref")
            (Printf.sprintf "names %s, which is no kind of id" kind);
        field "id" ~description:p.id.description ~type_:kind ~kind ()
    | _ ->
        refuse at "is not one kind of id";
        field "id" ~description:p.id.description ~type_:"" ()
  in
  let open_resource =
    [
      id;
      field "name" ~description:p.name.description ~type_:"str"
        ~stated:p.name.type_ ();
      field "openedAt" ~description:p.opened_at.description ~type_:"int"
        ~least:p.opened_at.minimum ~stated:p.opened_at.type_ ();
      field "order" ~description:p.order.description ~type_:"int"
        ~least:p.order.minimum ~stated:p.order.type_ ();
      field "mediaType" ~description:p.media_type.description ~type_:"str"
        ~stated:p.media_type.type_ ();
      field "storageUri" ~description:p.storage_uri.description ~type_:"str"
        ~stated:p.storage_uri.type_ ();
    ]
  in
  List.iteri
    (fun i name ->
      if not (List.exists (fun f -> f.name = name) open_resource) then
        refuse
          (Printf.sprintf "%s/required/%d" at_open i)
          (Printf.sprintf "is %s, which is not a property" name))
    o.required;
  let l = table.last_event_ids in
  let at_last = "/lastEventIds" in
  if l.type_ <> "object" then refuse (at_last ^ "/type") "is not object";
  if not (Sign_in.Flat.is_type_name l.title) then
    refuse (at_last ^ "/title") "names no type";
  if l.description = "" then refuse (at_last ^ "/description") "is empty";
  let scope =
    component (at_last ^ "/propertyNames/$ref") l.property_names.ref
  in
  if scope <> "" && not (List.mem scope kinds) then
    refuse
      (at_last ^ "/propertyNames/$ref")
      (Printf.sprintf "names its members by %s, which is no kind of id" scope);
  let place =
    component
      (at_last ^ "/additionalProperties/$ref")
      l.additional_properties.ref
  in
  if table.whole_key.docs = "" then refuse "/wholeKey/docs" "is empty";
  if table.cache_document.properties.version.description = "" then
    refuse "/cacheDocument/properties/version/description" "is empty";
  (* A cache document is a version and its entries, each a key, a value and a
     whole-number stamp; Haskell's reads it as no more than that. *)
  let d = table.cache_document in
  if d.type_ <> "object" then refuse "/cacheDocument/type" "is not object";
  if d.required <> [ "version"; "entries" ] then
    refuse "/cacheDocument/required"
      "is not the version, then the entries, which is all a cache document is";
  let e = d.properties.entries in
  if e.type_ <> "array" then
    refuse "/cacheDocument/properties/entries/type" "is not array";
  let at_entry = "/cacheDocument/properties/entries/items" in
  if e.items.type_ <> "array" then refuse (at_entry ^ "/type") "is not array";
  if e.items.min_items <> 3 || e.items.max_items <> 3 then
    refuse at_entry "is not exactly three items: a key, a value and a stamp";
  (match e.items.prefix_items with
  | [ key; value; stamp ] ->
      List.iteri
        (fun i (p : T.prefix_item) ->
          if p.type_ <> None || p.minimum <> None then
            refuse
              (Printf.sprintf "%s/prefixItems/%d" at_entry i)
              "states a type, but an entry's key and value are any JSON")
        [ key; value ];
      if stamp.type_ <> Some "integer" || stamp.minimum <> Some 0 then
        refuse
          (at_entry ^ "/prefixItems/2")
          "is not a whole number of at least 0"
  | _ -> refuse (at_entry ^ "/prefixItems") "is not a key, a value and a stamp");
  let kept =
    List.filter_map
      (fun (q : Cache_refresh.Table.query) ->
        if not q.persisted then None
        else
          let members =
            match q.value.members with
            | [] -> q.value.component
            | members ->
                q.value.component ^ "'s `" ^ String.concat "." members ^ "`"
          in
          Some
            {
              query = q.name;
              keyed_by =
                (match q.per with
                | Some Resource -> Some "ResourceId"
                | Some Annotation -> Some "AnnotationId"
                | Some Filters | None -> None);
              value = members;
            })
      refresh.queries
  in
  if kept = [] then
    refuse ""
      (Cache_refresh.Table.file
     ^ " marks no query persisted, so a client keeps none");
  match (List.rev !refusals, session) with
  | [], Some session ->
      Ok { table; session; open_resource; scope; place; kinds; kept }
  | errors, _ -> Error errors

let python t =
  let module P = Python_syntax in
  let table = t.table in
  let optional type_ = P.Binary (type_, P.Or, P.Name "None") in
  let field (f : field) =
    let python = snake f.name in
    let plain =
      if f.required then P.Name f.type_ else optional (P.Name f.type_)
    in
    let said =
      (if python = f.name then [] else [ P.keyword "alias" (P.Str f.name) ])
      @ match f.least with None -> [] | Some n -> [ P.keyword "ge" (P.Int n) ]
    in
    P.assign ~about:[ Prose f.description ] python
      ~annotation:
        (match said with
        | [] -> plain
        | said ->
            P.sub "Annotated" [ P.item plain; P.item (P.call "Field" said) ])
      ?value:(if f.required then None else Some (P.Name "None"))
  in
  let session_field (f : Sign_in.Flat.field) =
    field
      {
        name = f.name;
        description = f.description;
        required = f.required;
        type_ = "str";
        kind = None;
        least = None;
      }
  in
  let model name doc fields =
    P.Class
      {
        decorators = [ P.Name "final" ];
        name;
        bases =
          [ P.item (P.Name "WireModel"); P.keyword "frozen" (P.Name "True") ];
        doc = Some (Wrapped doc);
        spacing = Spaced;
        body = fields;
      }
  in
  let constant ~about name value =
    P.assign ~about:[ Prose about ] name ~annotation:(P.Name "Final") ~value
  in
  let named = [ t.scope; t.place ] in
  let identifiers =
    List.sort_uniq compare
      (List.filter_map (fun f -> f.kind) t.open_resource
      @ List.filter (fun n -> List.mem n t.kinds) named)
  in
  let components =
    List.sort_uniq compare
      (List.filter (fun n -> not (List.mem n t.kinds)) named)
  in
  let constants =
    List.map
      (fun (k : T.key) -> (Text.upper_snake k.member, k.key, k.docs))
      table.keys
  in
  let exported =
    List.sort compare
      (List.map (fun (n, _, _) -> n) constants
      @ [
          "CACHE_DOCUMENT_VERSION";
          "CACHE_KEY_PREFIX";
          "KEPT_QUERIES";
          "LAST_EVENT_ID_KEY_PREFIX";
          "SESSION_KEY_PREFIX";
          "WHOLE_KEY";
        ])
    @ List.sort compare
        [
          t.session.title;
          table.open_resource.title;
          table.last_event_ids.title;
          "KeptQuery";
          "WholeKey";
        ]
  in
  let kept_as k =
    "Keyed by "
    ^ (match k.keyed_by with None -> "WHOLE_KEY alone" | Some key -> key)
    ^ "; its value is " ^ k.value ^ "."
  in
  let from what = function
    | [] -> []
    | names -> [ P.From ("xynolog." ^ what, names) ]
  in
  let whole = P.Str table.whole_key.key in
  {
    Output.path = "python/sdk/src/xynolog/stored.py";
    text =
      P.text
        {
          header =
            Banner.python_lines ~from_:("protocol/specs/src/" ^ file) __FILE__;
          doc =
            As_is
              "What a registry of knowledge bases keeps in a `SessionStorage` \
               (`protocol/specs/src/session/stored.json`):\n\
               the key each thing it keeps is kept under, the shape of a \
               knowledge base's\n\
               stored session, and the shape of a resource open in one. And \
               what the\n\
               sessions it makes keep there: which queries, and the stream's \
               places. The\n\
               keys made of these prefixes are `xynolog.storage_keys`'s.\n";
          imports =
            [
              [
                P.From ("typing", [ "Annotated"; "Final"; "Literal"; "final" ]);
              ];
              [ P.From ("pydantic", [ "Field" ]) ];
              from "identifiers" identifiers
              @ [ P.From ("xynolog.model", [ "WireModel" ]) ]
              @ from "types" components;
            ];
          body =
            P.assign "__all__"
              ~value:
                (P.List
                   (P.items ~magic:true
                      (List.map (fun n -> P.item (P.Str n)) exported)))
            :: List.map
                 (fun (name, key, docs) ->
                   constant ~about:docs name (P.Str key))
                 constants
            @ [
                constant ~about:table.session_key_prefix.docs
                  "SESSION_KEY_PREFIX" (P.Str table.session_key_prefix.prefix);
                constant ~about:table.last_event_id_key_prefix.docs
                  "LAST_EVENT_ID_KEY_PREFIX"
                  (P.Str table.last_event_id_key_prefix.prefix);
                P.alias
                  ~about:[ Prose table.last_event_ids.description ]
                  table.last_event_ids.title
                  (P.sub "dict"
                     [ P.item (P.Name t.scope); P.item (P.Name t.place) ]);
                constant ~about:table.cache_key_prefix.docs "CACHE_KEY_PREFIX"
                  (P.Str table.cache_key_prefix.prefix);
                P.alias
                  ~about:
                    [
                      Prose
                        "The queries a client keeps across a restart, each by \
                         its name in protocol/specs/src/client/refresh.json, \
                         and each as one document under its \
                         `xynolog.storage_keys.cache_key`.";
                    ]
                  "KeptQuery"
                  (P.sub ~magic:true "Literal"
                     (List.map
                        (fun k ->
                          P.element ~about:[ Prose (kept_as k) ] (P.Str k.query))
                        t.kept));
                P.assign "KEPT_QUERIES"
                  ~annotation:
                    (P.sub "Final"
                       [
                         P.item
                           (P.sub "tuple"
                              [ P.item (P.Name "KeptQuery"); P.item P.Ellipsis ]);
                       ])
                  ~value:
                    (P.strings ~magic:true (List.map (fun k -> k.query) t.kept));
                P.Adjacent
                  [
                    P.alias
                      ~about:[ Prose table.whole_key.docs ]
                      "WholeKey"
                      (P.sub "Literal" [ P.item whole ]);
                    P.assign "WHOLE_KEY"
                      ~annotation:(P.sub "Final" [ P.item (P.Name "WholeKey") ])
                      ~value:whole;
                  ];
                constant
                  ~about:table.cache_document.properties.version.description
                  "CACHE_DOCUMENT_VERSION"
                  (P.Int table.cache_document.properties.version.const);
                model t.session.title t.session.description
                  (List.map session_field t.session.fields);
                model table.open_resource.title table.open_resource.description
                  (List.map field t.open_resource);
              ];
        };
  }

(* Haskell's kept queries, the key a whole query keeps its one entry under,
   and the version of a cache document. What reads and writes them is the
   SDK's own (haskell/sdk/internal/Xynolog/Internal/CacheDocument.hs). *)
let haskell t =
  let module H = Haskell_syntax in
  let constructor (k : kept) = String.capitalize_ascii k.query in
  {
    Output.path =
      "haskell/sdk/generated/Xynolog/Internal/Generated/CachePersistence.hs";
    text =
      H.text
        {
          banner =
            Banner.haskell_lines
              ~from_:(file ^ " and " ^ Cache_refresh.Table.file)
              __FILE__;
          extensions = [ "OverloadedStrings" ];
          name = "Xynolog.Internal.Generated.CachePersistence";
          imports = [ H.import "Data.Text" ~items:[ Plain "Text" ] ];
          body =
            [
              H.data "KeptQuery"
                ~about:
                  [
                    "The queries a client keeps across a restart, by their \
                     names in client/refresh.json.";
                  ]
                (List.map (fun k -> H.constructor (constructor k)) t.kept)
                ~deriving:[ "Eq"; "Ord"; "Show"; "Enum"; "Bounded" ];
              Value
                {
                  about = [];
                  name = "keptQueryName";
                  type_ = T_fun (T_name "KeptQuery", T_name "Text");
                  clauses =
                    List.map
                      (fun k ->
                        {
                          H.patterns = [ Constructor (constructor k, []) ];
                          body = Str k.query;
                        })
                      t.kept;
                };
              H.value "wholeKey" (T_name "Text")
                ~about:[ t.table.whole_key.docs ] (Str t.table.whole_key.key);
              H.value "cacheDocumentVersion" (T_name "Integer")
                ~about:[ t.table.cache_document.properties.version.description ]
                (Int t.table.cache_document.properties.version.const);
            ];
        };
  }

(* The keys a Haskell client keeps its registry under, by their members'
   names, and the prefixes of the keys it keeps per session
   (generated/.../Stored.hs). *)
let haskell_keys (table : T.t) =
  let module H = Haskell_syntax in
  {
    Output.path = "haskell/sdk/generated/Xynolog/Internal/Generated/Stored.hs";
    text =
      H.text
        {
          banner = Banner.haskell_lines ~from_:file __FILE__;
          extensions = [ "OverloadedStrings" ];
          name = "Xynolog.Internal.Generated.Stored";
          imports = [ H.import "Data.Text" ~items:[ Plain "Text" ] ];
          body =
            List.map
              (fun (k : T.key) -> H.value k.member (T_name "Text") (Str k.key))
              table.keys
            @ List.map
                (fun (name, prefix) ->
                  H.value name (T_name "Text") (Str prefix))
                [
                  ("sessionKeyPrefix", table.session_key_prefix.prefix);
                  ("lastEventIdKeyPrefix", table.last_event_id_key_prefix.prefix);
                  ("cacheKeyPrefix", table.cache_key_prefix.prefix);
                ];
        };
  }

let files ~root:_ (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let* kinds = Identifiers.Table.derive spec in
  let* context = Cache_refresh.context spec in
  let* refresh =
    Cache_refresh.Table.derive context spec.tables.client_refresh
  in
  let* t =
    derive spec
      ~kinds:(List.map (fun (k : Identifiers.Table.kind) -> k.name) kinds)
      ~refresh
  in
  Ok [ python t; haskell t; haskell_keys t.table ]
