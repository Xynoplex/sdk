//! The testing kit's facts and records, as Protocol states them
//! (`client/testing.json`): what a faulty transport does to a request, the
//! bounds a schedule is drawn within, the slack a case is given, the steps a
//! delivery check interleaves, and the records the harnesses take and give.

use super::liveness::Respond;
use crate::transport::BoxFuture;
use proptest::strategy::BoxedStrategy;
use serde_json::{Map, Value};
use std::sync::Arc;
use std::time::Duration;

include!("../generated/testing.rs");
