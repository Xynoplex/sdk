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
let quoted = Text.quoted
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
  let comment = Text.python_comment ~indent:"" in
  let table = t.table in
  let field (f : field) =
    let python = snake f.name in
    let plain = if f.required then f.type_ else f.type_ ^ " | None" in
    let said =
      (if python = f.name then [] else [ "alias=" ^ quoted f.name ])
      @ match f.least with None -> [] | Some n -> [ "ge=" ^ string_of_int n ]
    in
    let annotated =
      match said with
      | [] -> plain
      | said ->
          "Annotated[" ^ plain ^ ", Field(" ^ String.concat ", " said ^ ")]"
    in
    Text.python_comment ~indent:"    " f.description
    ^ "\n    " ^ python ^ ": " ^ annotated
    ^ if f.required then "" else " = None"
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
      @ [ "CACHE_DOCUMENT_VERSION"; "KEPT_QUERIES"; "WHOLE_KEY" ])
    @ List.sort compare
        [
          t.session.title;
          table.open_resource.title;
          table.last_event_ids.title;
          "KeptQuery";
          "WholeKey";
        ]
    @ [
        "cache_key";
        "kb_of_session_key";
        "last_event_id_key";
        "person_key";
        "session_key";
      ]
  in
  let kept_as k =
    "Keyed by "
    ^ (match k.keyed_by with None -> "WHOLE_KEY alone" | Some key -> key)
    ^ "; its value is " ^ k.value ^ "."
  in
  let imports what = function
    | [] -> ""
    | names -> "\nfrom xynolog." ^ what ^ " import " ^ String.concat ", " names
  in
  {
    Output.path = "python/sdk/src/xynolog/stored.py";
    text =
      String.concat ""
        [
          Banner.python ~from_:("protocol/specs/src/" ^ file) __FILE__;
          {|
"""What a registry of knowledge bases keeps in a `SessionStorage` (`protocol/specs/src/session/stored.json`):
the key each thing it keeps is kept under, the shape of a knowledge base's
stored session, and the shape of a resource open in one. And what the
sessions it makes keep there: which queries, and the stream's places.
"""

from typing import Annotated, Final, Literal, final

from pydantic import Field

from xynolog._digest import base64url_sha256|};
          imports "identifiers" identifiers;
          "\nfrom xynolog.model import WireModel";
          imports "types" components;
          "\n\n__all__ = [\n";
          String.concat ""
            (List.map (fun n -> "    " ^ quoted n ^ ",\n") exported);
          "]\n\n";
          String.concat "\n\n"
            (List.map
               (fun (name, key, docs) ->
                 comment docs ^ "\n" ^ name ^ ": Final = " ^ quoted key)
               constants);
          "\n\n";
          comment table.session_key_prefix.docs;
          "\n_SESSION_KEY_PREFIX: Final = "
          ^ quoted table.session_key_prefix.prefix;
          {|


def session_key(kb_id: str) -> str:
    """The key a knowledge base's session is kept under."""
    return f"{_SESSION_KEY_PREFIX}{kb_id}"


def kb_of_session_key(key: str) -> str | None:
    """The knowledge base a key is the session of; nothing when it is no session's key."""
    return key.removeprefix(_SESSION_KEY_PREFIX) if key.startswith(_SESSION_KEY_PREFIX) else None


|};
          comment table.last_event_id_key_prefix.docs;
          "\n_LAST_EVENT_ID_KEY_PREFIX: Final = "
          ^ quoted table.last_event_id_key_prefix.prefix;
          {|


def person_key(did: str) -> str:
    """The key of the person whose did the gateway answered: what their caches and stream's places are kept under."""
    return base64url_sha256(did)


def last_event_id_key(kb_id: str, person_key: str) -> str:
    """The key a person's stream's places in a knowledge base are kept under, as `|};
          table.last_event_ids.title;
          {|`."""
    return f"{_LAST_EVENT_ID_KEY_PREFIX}{kb_id}.{person_key}"


|};
          comment table.last_event_ids.description;
          "\ntype " ^ table.last_event_ids.title ^ " = dict[" ^ t.scope ^ ", "
          ^ t.place ^ "]\n\n\n";
          comment table.cache_key_prefix.docs;
          "\n_CACHE_KEY_PREFIX: Final = " ^ quoted table.cache_key_prefix.prefix;
          {|

# The queries a client keeps across a restart, each by its name in
# protocol/specs/src/client/refresh.json, and each as one document under `cache_key`.
type KeptQuery = Literal[
|};
          String.concat "\n"
            (List.map
               (fun k ->
                 Text.python_comment ~indent:"    " (kept_as k)
                 ^ "\n    " ^ quoted k.query ^ ",")
               t.kept);
          "\n]\n\n";
          Python_layout.statement ~indent:0
            ~prefix:"KEPT_QUERIES: Final[tuple[KeptQuery, ...]] = " ~suffix:""
            (Python_layout.Rows
               (List.map (fun k -> Python_layout.Atom (quoted k.query)) t.kept));
          {|


def cache_key(kb_id: str, person_key: str, query: KeptQuery) -> str:
    """The key what a person's client keeps of `query` in a knowledge base is kept under."""
    return f"{_CACHE_KEY_PREFIX}{kb_id}.{person_key}.{query}"


|};
          comment table.whole_key.docs;
          "\ntype WholeKey = Literal[" ^ quoted table.whole_key.key
          ^ "]\nWHOLE_KEY: Final[WholeKey] = " ^ quoted table.whole_key.key
          ^ "\n\n";
          comment table.cache_document.properties.version.description;
          "\nCACHE_DOCUMENT_VERSION: Final = "
          ^ string_of_int table.cache_document.properties.version.const
          ^ "\n\n\n@final\nclass " ^ t.session.title
          ^ "(WireModel, frozen=True):\n";
          Text.python_docstring ~indent:"    " t.session.description;
          "\n\n";
          String.concat "\n\n" (List.map session_field t.session.fields);
          "\n\n\n@final\nclass " ^ table.open_resource.title
          ^ "(WireModel, frozen=True):\n";
          Text.python_docstring ~indent:"    " table.open_resource.description;
          "\n\n";
          String.concat "\n\n" (List.map field t.open_resource);
          "\n";
        ];
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
  Ok [ python t ]
