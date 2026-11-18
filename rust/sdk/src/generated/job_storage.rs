// Generated from protocol/specs/src/jobs/storage.json; do not edit.
// Regenerate: make generate (codegen/lib/job_storage/job_storage.ml)
/// The work-queue stream every job is published into.
pub const JOBS_STREAM: &str = "JOBS";
/// The root of every job subject: a job is published on `<root>.<jobType>`.
pub const JOBS_SUBJECT_ROOT: &str = "jobs";
/// The durable consumer that holds each job's message as its lease.
pub const JOBS_CONSUMER: &str = "dispatcher-leases";
/// The key-value bucket holding one JobRecord per job, keyed by its id.
pub const JOBS_BUCKET: &str = "jobs";
