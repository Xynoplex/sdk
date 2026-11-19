//! The names and subjects every implementation of the job queue uses on the
//! broker, generated from protocol/specs/src/jobs/storage.json, so work queued
//! by one survives a switch to another.

include!("generated/job_storage.rs");
