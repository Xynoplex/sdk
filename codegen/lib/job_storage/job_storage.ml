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
let quoted = Text.quoted

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
  let array words = "[" ^ String.concat "," (List.map quoted words) ^ "]" in
  let s = t.table in
  {
    Output.path = "typescript/core/src/job-storage.ts";
    text =
      String.concat ""
        [
          "// ⚠ GENERATED FILE — do not edit.\n\
           //\n\
           // Authority:   protocol/specs/src/" ^ file ^ ", protocol/specs/src/"
          ^ job_type ^ ",\n//              protocol/specs/src/" ^ mark_params
          ^ "\n// Regenerate:  make generate  (";
          Banner.writer __FILE__;
          ")\n\n\
           /** The work-queue stream every job is published into. */\n\
           export const JOBS_STREAM = ";
          quoted s.stream.name;
          ";\n\n\
           /** The root of every job subject: a job is published on \
           `<root>.<jobType>`. */\n\
           export const JOBS_SUBJECT_ROOT = ";
          quoted s.stream.subject_root;
          ";\n\n\
           /** The stream's capture filter: every subject under the root. */\n\
           export const JOBS_STREAM_SUBJECTS = [";
          quoted (s.stream.subject_root ^ ".>");
          "] as const;\n\n\
           /** The durable consumer that holds each job's message as its \
           lease. */\n\
           export const JOBS_CONSUMER = ";
          quoted s.consumer.durable_name;
          ";\n\n/** The KV bucket holding one ";
          s.bucket.record;
          " per job, keyed by the job's id. */\nexport const JOBS_BUCKET = ";
          quoted s.bucket.name;
          ";\n\n/** Every job type. */\nexport const JOB_TYPES = ";
          array t.job_types;
          " as const;\n\n\
           /** Every motivation a `mark` job has: the ones MarkJobParams is \
           told apart by. */\n\
           export const MARK_MOTIVATIONS = ";
          array t.mark_motivations;
          {| as const;

/** The subject a job of this type is published on. */
export function jobSubject(type: string): string {
  return `${JOBS_SUBJECT_ROOT}.${type}`;
}
|};
        ];
  }

let files ~root:_ (spec : Spec.t) =
  Result.map (fun t -> [ typescript t ]) (derive spec)
