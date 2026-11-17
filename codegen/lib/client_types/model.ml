(* The client types group: the shapes an SDK hands its callers that no wire
   message carries (protocol/specs/src/client/types), and the form a service
   account posts with a client secret (session/ClientSecretForm.json), for the
   Haskell SDK. Each is read once into a model of its members, refusing a
   keyword the model does not know, so a type that grows a shape the writers
   cannot state stops the run. *)

let types = "client/types/"
let form = "session/ClientSecretForm.json"

(* What a member holds: a scalar by its JSON Schema type, one of some words,
   another schema by its name (and whether that is a union of branches), a
   list whose items the schema leaves open, or an object stated in place. *)
type held =
  | Scalar of Schema.type_name
  | Word of string list
  | Named of { name : string; union : bool }
  | Open_list
  | Inline of member list

and member = { name : string; held : held; required : bool }

(* A type: words, an object's members, or a union told apart by one member
   whose value names each branch. *)
type shape =
  | Words of string list
  | Fields of member list
  | Union of { tag : string; branches : (string * member list) list }

type t = {
  shapes : (string * shape) list;  (** Each client type, by its name. *)
  form : member list;  (** The client secret form's members, in order. *)
  grant_type : string;  (** The client assertion's grant. *)
}

let name_of file = Filename.remove_extension (Filename.basename file)

let words_of literals =
  List.fold_right
    (fun literal rest ->
      match (literal, rest) with
      | Schema.String_literal w, Some rest -> Some (w :: rest)
      | _ -> None)
    literals (Some [])

let derive (spec : Spec.t) =
  let refusals = ref [] in
  let refuse file pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  let schema file = List.assoc_opt file spec.schemas in
  (* The keywords a member's schema may state beyond what it holds: what is
     said of it, and a scalar's bounds, which no writer reads. *)
  let described s =
    List.filter (fun k -> k <> "description") (Schema.keywords s)
  in
  let rec held file pointer = function
    | Schema.Schema ({ ref_ = Some ref_; _ } as s) when described s = [ "$ref" ]
      ->
        let target, _ = Decode.resolve ref_ in
        let union =
          match schema target with
          | Some (Schema.Schema { one_of = Some _; _ }) -> true
          | _ -> false
        in
        Some (Named { name = name_of target; union })
    | Schema.Schema ({ type_ = Some [ Array ]; items = None; _ } as s)
      when described s = [ "type" ] ->
        Some Open_list
    | Schema.Schema ({ type_ = Some [ String ]; enum = Some literals; _ } as s)
      when described s = [ "type"; "enum" ] -> (
        match words_of literals with
        | Some words -> Some (Word words)
        | None ->
            refuse file pointer "is no enum of words";
            None)
    | Schema.Schema ({ type_ = Some [ Object ]; _ } as s) ->
        Option.map (fun members -> Inline members) (fields file pointer s)
    | Schema.Schema ({ type_ = Some [ t ]; _ } as s)
      when List.for_all
             (fun k -> List.mem k [ "type"; "minimum"; "maximum" ])
             (described s)
           && t <> Schema.Array ->
        Some (Scalar t)
    | _ ->
        refuse file pointer "holds what no client type's member is stated as";
        None
  and fields file pointer (s : Schema.schema) =
    match (s.properties, described s) with
    | Some properties, keywords
      when List.for_all
             (fun k -> List.mem k [ "title"; "type"; "properties"; "required" ])
             keywords ->
        let required = Option.value s.required ~default:[] in
        List.iter
          (fun r ->
            if not (List.mem_assoc r properties) then
              refuse file (pointer ^ "/required")
                ("requires " ^ r ^ ", which it has not"))
          required;
        Some
          (List.filter_map
             (fun (name, member) ->
               Option.map
                 (fun held -> { name; held; required = List.mem name required })
                 (held file
                    (pointer ^ "/properties/" ^ Decode.escape name)
                    member))
             properties)
    | _ ->
        refuse file pointer "is no object of named members";
        None
  in
  (* An object's members, with those of each schema it is all of, in order. *)
  let rec object_ file pointer = function
    | Schema.Schema ({ all_of = Some parts; _ } as s)
      when List.for_all (fun k -> List.mem k [ "title"; "allOf" ]) (described s)
      ->
        let members =
          List.concat
            (List.mapi
               (fun i part ->
                 let at = Printf.sprintf "%s/allOf/%d" pointer i in
                 match part with
                 | Schema.Schema ({ ref_ = Some ref_; _ } as r)
                   when Schema.keywords r = [ "$ref" ] -> (
                     let target, _ = Decode.resolve ref_ in
                     match schema target with
                     | Some s -> Option.value (object_ target "" s) ~default:[]
                     | None -> [])
                 | part -> Option.value (object_ file at part) ~default:[])
               parts)
        in
        let names = List.map (fun m -> m.name) members in
        if List.length (List.sort_uniq compare names) <> List.length names then
          refuse file pointer "states a member twice among what it is all of";
        Some members
    | Schema.Schema ({ type_ = Some [ Object ]; _ } as s) ->
        fields file pointer s
    | _ ->
        refuse file pointer "is no object";
        None
  in
  let shape file = function
    | Schema.Schema ({ type_ = Some [ String ]; enum = Some literals; _ } as s)
      when List.for_all
             (fun k -> List.mem k [ "title"; "type"; "enum" ])
             (described s) -> (
        match words_of literals with
        | Some words -> Some (Words words)
        | None ->
            refuse file "/enum" "is no enum of words";
            None)
    | Schema.Schema ({ one_of = Some branches; discriminator = Some d; _ } as s)
      when d.mapping = None
           && List.for_all
                (fun k -> List.mem k [ "title"; "oneOf"; "discriminator" ])
                (described s) ->
        let tag = d.property_name in
        let branches =
          List.filter_map Fun.id
            (List.mapi
               (fun i branch ->
                 let at = Printf.sprintf "/oneOf/%d" i in
                 match branch with
                 | Schema.Schema
                     ({ type_ = Some [ Object ]; properties = Some p; _ } as b)
                   -> (
                     match List.assoc_opt tag p with
                     | Some
                         (Schema.Schema
                            ({ enum = Some [ Schema.String_literal word ]; _ }
                             as e))
                       when described e = [ "type"; "enum" ]
                            && List.mem tag
                                 (Option.value b.required ~default:[]) ->
                         Option.map
                           (fun members ->
                             (word, List.filter (fun m -> m.name <> tag) members))
                           (fields file at b)
                     | _ ->
                         refuse file at
                           ("is no branch whose required " ^ tag
                          ^ " is one word");
                         None)
                 | _ ->
                     refuse file at "is no object stated in place";
                     None)
               branches)
        in
        let words = List.map fst branches in
        if List.length (List.sort_uniq compare words) <> List.length words then
          refuse file "/oneOf" ("names two branches by one " ^ tag);
        Some (Union { tag; branches })
    | s -> Option.map (fun members -> Fields members) (object_ file "" s)
  in
  let shapes =
    List.filter_map
      (fun (file, s) ->
        if String.starts_with ~prefix:types file then
          Option.map (fun shape -> (name_of file, shape)) (shape file s)
        else None)
      spec.schemas
  in
  let form =
    match schema form with
    | Some (Schema.Schema s) -> Option.value (fields form "" s) ~default:[]
    | _ ->
        refuse form "" "is no JSON Schema";
        []
  in
  let grant_type = spec.tables.session_client_assertion_cases.grant_type in
  match List.rev !refusals with
  | [] -> Ok { shapes; form; grant_type }
  | errors -> Error errors

let shape t name = List.assoc_opt name t.shapes
