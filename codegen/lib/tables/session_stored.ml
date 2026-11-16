(* specs/src/session/stored.json *)

type key = { member : string; key : string; docs : string }

let key =
  Decode.obj (fun o : key ->
      {
        member = Decode.required o "member" Decode.string;
        key = Decode.required o "key" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type session_key_prefix = { prefix : string; docs : string }

let session_key_prefix =
  Decode.obj (fun o : session_key_prefix ->
      {
        prefix = Decode.required o "prefix" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type example = { kb_id : string; did : string; key : string }

let example =
  Decode.obj (fun o : example ->
      {
        kb_id = Decode.required o "kbId" Decode.string;
        did = Decode.required o "did" Decode.string;
        key = Decode.required o "key" Decode.string;
      })

type last_event_id_key_prefix = {
  prefix : string;
  docs : string;
  example : example;
}

let last_event_id_key_prefix =
  Decode.obj (fun o : last_event_id_key_prefix ->
      {
        prefix = Decode.required o "prefix" Decode.string;
        docs = Decode.required o "docs" Decode.string;
        example = Decode.required o "example" example;
      })

type cache_key_prefix_example = {
  kb_id : string;
  did : string;
  query : string;
  key : string;
}

let cache_key_prefix_example =
  Decode.obj (fun o : cache_key_prefix_example ->
      {
        kb_id = Decode.required o "kbId" Decode.string;
        did = Decode.required o "did" Decode.string;
        query = Decode.required o "query" Decode.string;
        key = Decode.required o "key" Decode.string;
      })

type cache_key_prefix = {
  prefix : string;
  docs : string;
  example : cache_key_prefix_example;
}

let cache_key_prefix =
  Decode.obj (fun o : cache_key_prefix ->
      {
        prefix = Decode.required o "prefix" Decode.string;
        docs = Decode.required o "docs" Decode.string;
        example = Decode.required o "example" cache_key_prefix_example;
      })

type whole_key = { key : string; docs : string }

let whole_key =
  Decode.obj (fun o : whole_key ->
      {
        key = Decode.required o "key" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type state = { type_ : string; description : string }

let state =
  Decode.obj (fun o : state ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type verifier = { type_ : string; description : string }

let verifier =
  Decode.obj (fun o : verifier ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type redirect_uri = { type_ : string; description : string }

let redirect_uri =
  Decode.obj (fun o : redirect_uri ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type all_of_item = { ref : string }

let all_of_item =
  Decode.obj (fun o : all_of_item ->
      { ref = Decode.required o "$ref" Decode.string })

type target = { all_of : all_of_item list; description : string }

let target =
  Decode.obj (fun o : target ->
      {
        all_of = Decode.required o "allOf" (Decode.list all_of_item);
        description = Decode.required o "description" Decode.string;
      })

type issuer_properties_issuer = { type_ : string; description : string }

let issuer_properties_issuer =
  Decode.obj (fun o : issuer_properties_issuer ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type authorization = { type_ : string; description : string }

let authorization =
  Decode.obj (fun o : authorization ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type token = { type_ : string; description : string }

let token =
  Decode.obj (fun o : token ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type device = { type_ : string; description : string }

let device =
  Decode.obj (fun o : device ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type revocation = { type_ : string; description : string }

let revocation =
  Decode.obj (fun o : revocation ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type issuer_properties = {
  issuer : issuer_properties_issuer;
  authorization : authorization;
  token : token;
  device : device;
  revocation : revocation;
}

let issuer_properties =
  Decode.obj (fun o : issuer_properties ->
      {
        issuer = Decode.required o "issuer" issuer_properties_issuer;
        authorization = Decode.required o "authorization" authorization;
        token = Decode.required o "token" token;
        device = Decode.required o "device" device;
        revocation = Decode.required o "revocation" revocation;
      })

type issuer = {
  type_ : string;
  description : string;
  properties : issuer_properties;
  required : string list;
}

let issuer =
  Decode.obj (fun o : issuer ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
        properties = Decode.required o "properties" issuer_properties;
        required = Decode.required o "required" (Decode.list Decode.string);
      })

type kb_id = { type_ : string; description : string }

let kb_id =
  Decode.obj (fun o : kb_id ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type expected_did = { type_ : string; description : string }

let expected_did =
  Decode.obj (fun o : expected_did ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type expected_name = { type_ : string; description : string }

let expected_name =
  Decode.obj (fun o : expected_name ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type properties = {
  state : state;
  verifier : verifier;
  redirect_uri : redirect_uri;
  target : target;
  issuer : issuer;
  kb_id : kb_id;
  expected_did : expected_did;
  expected_name : expected_name;
}

let properties =
  Decode.obj (fun o : properties ->
      {
        state = Decode.required o "state" state;
        verifier = Decode.required o "verifier" verifier;
        redirect_uri = Decode.required o "redirectUri" redirect_uri;
        target = Decode.required o "target" target;
        issuer = Decode.required o "issuer" issuer;
        kb_id = Decode.required o "kbId" kb_id;
        expected_did = Decode.required o "expectedDid" expected_did;
        expected_name = Decode.required o "expectedName" expected_name;
      })

type pending_authorization = {
  title : string;
  type_ : string;
  description : string;
  properties : properties;
  required : string list;
}

let pending_authorization =
  Decode.obj (fun o : pending_authorization ->
      {
        title = Decode.required o "title" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
        properties = Decode.required o "properties" properties;
        required = Decode.required o "required" (Decode.list Decode.string);
      })

type id_all_of_item = { ref : string }

let id_all_of_item =
  Decode.obj (fun o : id_all_of_item ->
      { ref = Decode.required o "$ref" Decode.string })

type id = { all_of : id_all_of_item list; description : string }

let id =
  Decode.obj (fun o : id ->
      {
        all_of = Decode.required o "allOf" (Decode.list id_all_of_item);
        description = Decode.required o "description" Decode.string;
      })

type name = { type_ : string; description : string }

let name =
  Decode.obj (fun o : name ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type opened_at = { type_ : string; minimum : int; description : string }

let opened_at =
  Decode.obj (fun o : opened_at ->
      {
        type_ = Decode.required o "type" Decode.string;
        minimum = Decode.required o "minimum" Decode.int;
        description = Decode.required o "description" Decode.string;
      })

type order = { type_ : string; minimum : int; description : string }

let order =
  Decode.obj (fun o : order ->
      {
        type_ = Decode.required o "type" Decode.string;
        minimum = Decode.required o "minimum" Decode.int;
        description = Decode.required o "description" Decode.string;
      })

type media_type = { type_ : string; description : string }

let media_type =
  Decode.obj (fun o : media_type ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type storage_uri = { type_ : string; description : string }

let storage_uri =
  Decode.obj (fun o : storage_uri ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
      })

type open_resource_properties = {
  id : id;
  name : name;
  opened_at : opened_at;
  order : order;
  media_type : media_type;
  storage_uri : storage_uri;
}

let open_resource_properties =
  Decode.obj (fun o : open_resource_properties ->
      {
        id = Decode.required o "id" id;
        name = Decode.required o "name" name;
        opened_at = Decode.required o "openedAt" opened_at;
        order = Decode.required o "order" order;
        media_type = Decode.required o "mediaType" media_type;
        storage_uri = Decode.required o "storageUri" storage_uri;
      })

type open_resource = {
  title : string;
  type_ : string;
  description : string;
  properties : open_resource_properties;
  required : string list;
}

let open_resource =
  Decode.obj (fun o : open_resource ->
      {
        title = Decode.required o "title" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
        properties = Decode.required o "properties" open_resource_properties;
        required = Decode.required o "required" (Decode.list Decode.string);
      })

type version = { const : int; description : string }

let version =
  Decode.obj (fun o : version ->
      {
        const = Decode.required o "const" Decode.int;
        description = Decode.required o "description" Decode.string;
      })

type prefix_item = {
  description : string;
  type_ : string option;
  minimum : int option;
}

let prefix_item =
  Decode.obj (fun o : prefix_item ->
      {
        description = Decode.required o "description" Decode.string;
        type_ = Decode.optional o "type" Decode.string;
        minimum = Decode.optional o "minimum" Decode.int;
      })

type items = {
  type_ : string;
  prefix_items : prefix_item list;
  min_items : int;
  max_items : int;
}

let items =
  Decode.obj (fun o : items ->
      {
        type_ = Decode.required o "type" Decode.string;
        prefix_items = Decode.required o "prefixItems" (Decode.list prefix_item);
        min_items = Decode.required o "minItems" Decode.int;
        max_items = Decode.required o "maxItems" Decode.int;
      })

type entries = { type_ : string; description : string; items : items }

let entries =
  Decode.obj (fun o : entries ->
      {
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
        items = Decode.required o "items" items;
      })

type cache_document_properties = { version : version; entries : entries }

let cache_document_properties =
  Decode.obj (fun o : cache_document_properties ->
      {
        version = Decode.required o "version" version;
        entries = Decode.required o "entries" entries;
      })

type cache_document = {
  title : string;
  type_ : string;
  description : string;
  properties : cache_document_properties;
  required : string list;
}

let cache_document =
  Decode.obj (fun o : cache_document ->
      {
        title = Decode.required o "title" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
        properties = Decode.required o "properties" cache_document_properties;
        required = Decode.required o "required" (Decode.list Decode.string);
      })

type property_names = { ref : string }

let property_names =
  Decode.obj (fun o : property_names ->
      { ref = Decode.required o "$ref" Decode.string })

type additional_properties = { ref : string }

let additional_properties =
  Decode.obj (fun o : additional_properties ->
      { ref = Decode.required o "$ref" Decode.string })

type last_event_ids = {
  title : string;
  type_ : string;
  description : string;
  property_names : property_names;
  additional_properties : additional_properties;
}

let last_event_ids =
  Decode.obj (fun o : last_event_ids ->
      {
        title = Decode.required o "title" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        description = Decode.required o "description" Decode.string;
        property_names = Decode.required o "propertyNames" property_names;
        additional_properties =
          Decode.required o "additionalProperties" additional_properties;
      })

type t = {
  comment : string;
  keys : key list;
  session_key_prefix : session_key_prefix;
  last_event_id_key_prefix : last_event_id_key_prefix;
  cache_key_prefix : cache_key_prefix;
  whole_key : whole_key;
  stored_session : Schema.t;
  pending_authorization : pending_authorization;
  open_resource : open_resource;
  cache_document : cache_document;
  last_event_ids : last_event_ids;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        keys = Decode.required o "keys" (Decode.list key);
        session_key_prefix =
          Decode.required o "sessionKeyPrefix" session_key_prefix;
        last_event_id_key_prefix =
          Decode.required o "lastEventIdKeyPrefix" last_event_id_key_prefix;
        cache_key_prefix = Decode.required o "cacheKeyPrefix" cache_key_prefix;
        whole_key = Decode.required o "wholeKey" whole_key;
        stored_session = Decode.required o "storedSession" Schema.decode;
        pending_authorization =
          Decode.required o "pendingAuthorization" pending_authorization;
        open_resource = Decode.required o "openResource" open_resource;
        cache_document = Decode.required o "cacheDocument" cache_document;
        last_event_ids = Decode.required o "lastEventIds" last_event_ids;
      })
