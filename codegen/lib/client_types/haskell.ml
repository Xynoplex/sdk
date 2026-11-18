(* The Haskell SDK's client types. The schemas of nine, which the haskell-sdk
   group writes models of into Xynolog.Types; and four modules: the
   records of a pending annotation and of a search's state, the events a
   delegation and an upload report, and the form a client secret proves an
   account with.

   Haskell's own choices are this writer's rules: a scalar's type, a record's
   field names (the type's name, then the member's), an open list's items as
   the record's one type variable, a member that names a union of branches
   as the type variable each operation instantiates at its own branch, the
   refused frame a report names as the transport's FrameRefusal, and the
   upload's events named UploadEvent, which leaves UploadProgress to be one of
   them. *)

module H = Haskell_syntax
open Model

let generated = "haskell/sdk/generated/Xynolog/Internal/Generated/"
let from_type name = "protocol/specs/src/" ^ types ^ name ^ ".json"

let refusal name message =
  { Decode.file = types ^ name ^ ".json"; pointer = ""; message }

let ( let* ) = Result.bind

let all results =
  List.fold_right
    (fun result rest ->
      match (result, rest) with
      | Ok x, Ok xs -> Ok (x :: xs)
      | Error e, Ok _ | Ok _, Error e -> Error e
      | Error a, Error b -> Error (a @ b))
    results (Ok [])

let found ~shape name =
  match shape name with
  | Some s -> Ok s
  | None ->
      Error [ refusal name "is no client type, and a Haskell writer reads it" ]

(* A client type as the haskell-sdk group models one: words, or an object's
   members, each a scalar or another type's schema. *)
let adapter name =
  let schema (s : Schema.schema) = Schema.Schema { s with title = Some name } in
  function
  | Words words ->
      Ok
        (schema
           {
             Schema.empty with
             type_ = Some [ String ];
             enum = Some (List.map (fun w -> Schema.String_literal w) words);
           })
  | Fields members ->
      let* properties =
        all
          (List.map
             (fun m ->
               match m.held with
               | Scalar t ->
                   Ok
                     ( m.name,
                       Schema.Schema { Schema.empty with type_ = Some [ t ] } )
               | Named { name = n; union = false } ->
                   Ok
                     ( m.name,
                       Schema.Schema
                         {
                           Schema.empty with
                           ref_ =
                             Some
                               {
                                 Decode.target = n ^ ".json";
                                 file = "";
                                 pointer = "";
                               };
                         } )
               | _ -> Error [ refusal name (m.name ^ " is no scalar or type") ])
             members)
      in
      Ok
        (schema
           {
             Schema.empty with
             type_ = Some [ Object ];
             properties = Some properties;
             required =
               Some
                 (List.filter_map
                    (fun m -> if m.required then Some m.name else None)
                    members);
           })
  | Union _ -> Error [ refusal name "is a union, which an adapter is not" ]

(* The client types the Haskell SDK models, each by its name. *)
let adapters ~shape =
  all
    (List.map
       (fun name ->
         let* s = found ~shape name in
         Result.map (fun a -> (name, a)) (adapter name s))
       [
         "QuotedText";
         "TextSpan";
         "ReconciledSpan";
         "AnchorMethod";
         "MatchQuality";
         "PdfCoordinate";
         "IssuedTokens";
         "DeviceCode";
         "BeginAuthorizationOptions";
       ])

let scalar name : Schema.type_name -> (H.type_, Decode.error list) result =
  function
  | String -> Ok (T_name "Text")
  | Integer -> Ok (T_name "Integer")
  | Number -> Ok (T_name "Scientific")
  | Boolean -> Ok (T_name "Bool")
  | Object | Array -> Error [ refusal name "holds an open object or list" ]

let lower name = String.uncapitalize_ascii name
let accessor type_name member = lower type_name ^ String.capitalize_ascii member

let aeson_records =
  H.import "Data.Aeson"
    ~items:
      [
        All "FromJSON";
        All "ToJSON";
        Plain "withObject";
        Plain "object";
        Op ".:";
        Op ".=";
      ]

(* A record of a client type, read from and written to its JSON: every member
   required, and an open list's items the record's one type variable. *)
let record_module ~shape name =
  let* s = found ~shape name in
  let* members =
    match s with
    | Fields members -> Ok members
    | _ -> Error [ refusal name "is no record" ]
  in
  let variable = "value" in
  let* fields =
    all
      (List.map
         (fun m ->
           let field t = Ok (accessor name m.name, t) in
           if not m.required then
             Error
               [ refusal name (m.name ^ " is optional, and a record's is not") ]
           else
             match m.held with
             | Scalar t -> Result.bind (scalar name t) field
             | Named { name = n; _ } -> field (H.T_name n)
             | Open_list -> field (H.T_list (H.T_name variable))
             | _ ->
                 Error [ refusal name (m.name ^ " is no scalar, type or list") ])
         members)
  in
  let params =
    if List.exists (fun m -> m.held = Open_list) members then [ variable ]
    else []
  in
  let instance class_ =
    H.instance class_
      ~context:(List.map (fun v -> (class_, v)) params)
      (match params with
      | [] -> H.T_name name
      | vs -> H.T_apply (name, List.map (fun v -> H.T_name v) vs))
  in
  let named =
    List.sort_uniq compare
      (List.filter_map
         (fun m ->
           match m.held with Named { name = n; _ } -> Some n | _ -> None)
         members)
  in
  let module_ = "Xynolog.Internal.Generated." ^ name in
  Ok
    {
      Output.path = generated ^ name ^ ".hs";
      text =
        H.text
          {
            banner = Banner.lines ~from_:(from_type name) __FILE__;
            extensions = [ "OverloadedStrings" ];
            name = module_;
            imports =
              aeson_records
              ::
              (if named = [] then []
               else
                 [
                   H.import "Xynolog.Types"
                     ~items:(List.map (fun n -> H.Plain n) named);
                 ]);
            body =
              [
                H.record name ~params ~deriving:[ "Eq"; "Show" ] fields;
                instance "FromJSON"
                  [
                    H.method_ "parseJSON"
                      (Apply
                         ( Name "withObject",
                           [
                             Str name;
                             Lambda
                               ( "fields",
                                 Infix
                                   ( Name name,
                                     List.mapi
                                       (fun i m ->
                                         ( (if i = 0 then "<$>" else "<*>"),
                                           H.Infix
                                             ( Name "fields",
                                               [ (".:", Str m.name) ] ) ))
                                       members ) );
                           ] ));
                  ];
                instance "ToJSON"
                  [
                    ( "toJSON",
                      {
                        patterns = [ Var "record" ];
                        body =
                          Apply
                            ( Name "object",
                              [
                                List
                                  (List.map
                                     (fun (m, (field, _)) ->
                                       H.Infix
                                         ( Str m.name,
                                           [
                                             ( ".=",
                                               Apply
                                                 (Name field, [ Name "record" ])
                                             );
                                           ] ))
                                     (List.combine members fields));
                              ] );
                      } );
                  ];
              ];
          };
    }

let pending_annotation ~shape = record_module ~shape "PendingAnnotation"
let search_state ~shape = record_module ~shape "SearchState"

(* How the transport's FrameRefusal states each member of a refused frame's
   report. *)
let refused_member value = function
  | "channel" -> Some (H.Apply (Name "refusedChannel", [ value ]))
  | "member" ->
      Some (H.Apply (Name "member", [ Apply (Name "fault", [ value ]) ]))
  | "reason" ->
      Some
        (H.Apply
           ( Name "refusalReason",
             [ Apply (Name "reason", [ Apply (Name "fault", [ value ]) ]) ] ))
  | _ -> None

(* The reports' sums: each branch a constructor holding its members but the
   tag, in order, and written back to the branch's JSON. *)
let report ~shape ~native ~prefix name =
  let* s = found ~shape name in
  let* tag, branches =
    match s with
    | Union { tag; branches } -> Ok (tag, branches)
    | _ -> Error [ refusal name "is no union" ]
  in
  let completion = "completion" in
  let held branch (m : member) :
      (H.type_ * (H.expr -> H.expr), Decode.error list) result =
    let plain t = Ok (t, fun v -> v) in
    match m.held with
    | Scalar t -> Result.bind (scalar name t) plain
    | Named { name = _; union = true } -> plain (H.T_name completion)
    | Named { name = n; union = false } -> plain (H.T_name n)
    | Inline refused -> (
        let encoded =
          List.map
            (fun (r : member) -> (r.name, refused_member (H.Name "v") r.name))
            refused
        in
        match List.find_opt (fun (_, e) -> e = None) encoded with
        | Some (unknown, _) ->
            Error
              [
                refusal name
                  (branch ^ "'s " ^ m.name ^ " reports " ^ unknown
                 ^ ", which no FrameRefusal states");
              ]
        | None ->
            Ok
              ( T_name "FrameRefusal",
                fun value ->
                  Apply
                    ( Name "object",
                      [
                        List
                          (List.map
                             (fun (r : member) ->
                               H.Infix
                                 ( Str r.name,
                                   [
                                     ( ".=",
                                       Option.get (refused_member value r.name)
                                     );
                                   ] ))
                             refused);
                      ] ) ))
    | _ ->
        Error
          [ refusal name (branch ^ "'s " ^ m.name ^ " is no report member") ]
  in
  let* rows =
    all
      (List.map
         (fun (word, members) ->
           let* fields = all (List.map (held word) members) in
           Ok (word, prefix ^ String.capitalize_ascii word, members, fields))
         branches)
  in
  let generic =
    List.exists
      (fun (_, _, _, fields) ->
        List.exists (fun (t, _) -> t = H.T_name completion) fields)
      rows
  in
  let params = if generic then [ completion ] else [] in
  let value i = Printf.sprintf "value%d" i in
  Ok
    [
      H.data native ~params ~deriving:[ "Eq"; "Show" ]
        (List.map
           (fun (_, constructor, _, fields) ->
             H.constructor constructor ~fields:(List.map fst fields))
           rows);
      H.instance "ToJSON"
        ~context:(List.map (fun v -> ("ToJSON", v)) params)
        (match params with
        | [] -> H.T_name native
        | vs -> H.T_apply (native, List.map (fun v -> H.T_name v) vs))
        (List.map
           (fun (word, constructor, members, fields) ->
             ( "toJSON",
               {
                 H.patterns =
                   [
                     Constructor
                       ( constructor,
                         List.mapi (fun i _ -> H.Var (value i)) fields );
                   ];
                 body =
                   Apply
                     ( Name "object",
                       [
                         List
                           (H.Infix
                              ( Str tag,
                                [ (".=", Typed (Str word, T_name "Text")) ] )
                           :: List.mapi
                                (fun i ((m : member), (_, encode)) ->
                                  H.Infix
                                    ( Str m.name,
                                      [ (".=", encode (H.Name (value i))) ] ))
                                (List.combine members fields));
                       ] );
               } ))
           rows);
    ]

let operation_reports ~shape =
  let* reasons =
    match shape "FrameRefusalReason" with
    | Some (Words words) -> Ok words
    | _ -> Error [ refusal "FrameRefusalReason" "is no enum of words" ]
  in
  let* jobs = report ~shape ~native:"JobEvent" ~prefix:"" "JobEvent" in
  let* uploads =
    report ~shape ~native:"UploadEvent" ~prefix:"Upload" "UploadProgress"
  in
  Ok
    {
      Output.path = generated ^ "OperationReports.hs";
      text =
        H.text
          {
            banner =
              Banner.lines
                ~from_:
                  (from_type "JobEvent" ^ ", " ^ from_type "UploadProgress"
                 ^ " and "
                  ^ from_type "FrameRefusalReason")
                __FILE__;
            extensions = [ "OverloadedStrings" ];
            name = "Xynolog.Internal.Generated.OperationReports";
            imports =
              [
                H.import "Data.Aeson"
                  ~items:[ All "ToJSON"; Plain "object"; Op ".=" ];
                H.import "Data.Text" ~items:[ Plain "Text" ];
                H.import "Xynolog.Types";
                H.import "Xynolog.Internal.Transport"
                  ~items:[ All "FrameRefusal" ];
                H.import "Xynolog.Internal.Required"
                  ~items:[ All "Fault"; All "FaultReason" ];
              ];
            body =
              H.Value
                {
                  about = [];
                  name = "refusalReason";
                  type_ = T_fun (T_name "FaultReason", T_name "Text");
                  clauses =
                    List.map
                      (fun word ->
                        {
                          H.patterns =
                            [ Constructor (String.capitalize_ascii word, []) ];
                          body = Str word;
                        })
                      reasons;
                }
              :: (jobs @ uploads);
          };
    }

(* The client secret form, as the account's id and secret make it: its grant
   the client assertion's, by the constant ClientAssertion states. *)
let service_proof ~grant_type (form : member list) =
  let refused message =
    Error [ { Decode.file = Model.form; pointer = ""; message } ]
  in
  let* pairs =
    all
      (List.map
         (fun (m : member) ->
           match (m.name, m.held) with
           | "grant_type", Word [ word ] when word = grant_type ->
               Ok (H.Tuple [ Str m.name; Name "Policy.grantType" ])
           | "grant_type", _ ->
               refused "grant_type is not the client assertion's grant"
           | "client_id", Scalar String ->
               Ok (H.Tuple [ Str m.name; Name "identity" ])
           | "client_secret", Scalar String ->
               Ok (H.Tuple [ Str m.name; Name "secret" ])
           | name, _ ->
               refused (name ^ " is no member a secret proof is made of"))
         form)
  in
  Ok
    {
      Output.path = generated ^ "ServiceProof.hs";
      text =
        H.text
          {
            banner =
              Banner.lines
                ~from_:("protocol/specs/src/" ^ Model.form)
                __FILE__;
            extensions = [ "OverloadedStrings" ];
            name = "Xynolog.Internal.Generated.ServiceProof";
            imports =
              [
                H.import "Data.Text" ~items:[ Plain "Text" ];
                H.import "Xynolog.Internal.Generated.ClientAssertion"
                  ~qualified:"Policy";
              ];
            body =
              [
                H.Value
                  {
                    about = [];
                    name = "secretProof";
                    type_ =
                      T_fun
                        ( T_name "Text",
                          T_fun
                            ( T_name "Text",
                              T_list (T_tuple [ T_name "Text"; T_name "Text" ])
                            ) );
                    clauses =
                      [
                        {
                          patterns = [ Var "identity"; Var "secret" ];
                          body = List pairs;
                        };
                      ];
                  };
              ];
          };
    }
