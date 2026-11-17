(* The job storage group: the names and subjects every implementation of the
   job queue uses on the broker (protocol/specs/src/jobs/storage.json), with
   the job types (JobType) and the motivations a mark job is told apart by
   (MarkJobParams), for the TypeScript SDK. Work queued by one implementation
   survives a switch to another only if both name these alike. Each name is
   stated; the bucket's record is a component; JobType is an enum of words;
   and MarkJobParams is told apart by a mapping. *)

module T = Tables.Jobs_storage

let file = "jobs/storage.json"
let job_type = "components/schemas/JobType.json"
let mark_params = "components/schemas/MarkJobParams.json"

type t = {
  table : T.t;
  job_types : string list;
  mark_motivations : string list;
}

let derive (spec : Spec.t) =
  let table = spec.tables.jobs_storage in
  let refusals = ref [] in
  let refuse file pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  List.iter
    (fun (pointer, name) -> if name = "" then refuse file pointer "is empty")
    [
      ("/stream/name", table.stream.name);
      ("/stream/subjectRoot", table.stream.subject_root);
      ("/consumer/durableName", table.consumer.durable_name);
      ("/bucket/name", table.bucket.name);
    ];
  if
    not
      (List.mem_assoc
         ("components/schemas/" ^ table.bucket.record ^ ".json")
         spec.schemas)
  then
    refuse file "/bucket/record"
      (Printf.sprintf "is %s, which is no component" table.bucket.record);
  let job_types =
    match List.assoc_opt job_type spec.schemas with
    | Some (Schema.Schema { enum = Some words; _ }) ->
        List.filter_map
          (function
            | Schema.String_literal w -> Some w
            | _ ->
                refuse job_type "/enum" "has a member that is not a word";
                None)
          words
    | _ ->
        refuse job_type "" "states no enum";
        []
  in
  let mark_motivations =
    match List.assoc_opt mark_params spec.schemas with
    | Some
        (Schema.Schema { discriminator = Some { mapping = Some mapping; _ }; _ })
      ->
        List.map fst mapping
    | _ ->
        refuse mark_params "/discriminator/mapping" "is absent";
        []
  in
  match List.rev !refusals with
  | [] -> Ok { table; job_types; mark_motivations }
  | errors -> Error errors

let typescript t =
  let module S = Typescript_syntax in
  let s = t.table in
  let constant ?(as_const = false) name about value =
    S.const name ~as_const ~about:[ Doc about ] value
  in
  let str text = S.Str (Double, text) in
  let words = S.strings ~quote:Double Packed in
  {
    Output.path = "typescript/core/src/job-storage.ts";
    text =
      S.text
        {
          banner =
            Banner.typescript_lines
              ~authority:
                [
                  "protocol/specs/src/" ^ file ^ ", protocol/specs/src/"
                  ^ job_type ^ ",";
                  "protocol/specs/src/" ^ mark_params;
                ]
              __FILE__;
          body =
            [
              constant "JOBS_STREAM"
                "The work-queue stream every job is published into."
                (str s.stream.name);
              constant "JOBS_SUBJECT_ROOT"
                "The root of every job subject: a job is published on \
                 `<root>.<jobType>`."
                (str s.stream.subject_root);
              constant "JOBS_STREAM_SUBJECTS" ~as_const:true
                "The stream's capture filter: every subject under the root."
                (words [ s.stream.subject_root ^ ".>" ]);
              constant "JOBS_CONSUMER"
                "The durable consumer that holds each job's message as its \
                 lease."
                (str s.consumer.durable_name);
              constant "JOBS_BUCKET"
                ("The KV bucket holding one " ^ s.bucket.record
               ^ " per job, keyed by the job's id.")
                (str s.bucket.name);
              constant "JOB_TYPES" ~as_const:true "Every job type."
                (words t.job_types);
              constant "MARK_MOTIVATIONS" ~as_const:true
                "Every motivation a `mark` job has: the ones MarkJobParams is \
                 told apart by."
                (words t.mark_motivations);
            ];
        };
  }

let files ~root:_ (spec : Spec.t) =
  Result.map (fun t -> [ typescript t ]) (derive spec)
