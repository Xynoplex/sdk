// Generated from protocol/specs/src/client/testing.json; do not edit.
// Regenerate: make generate (codegen/lib/testing/rust.ml)
/// What a faulty transport does to one request.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum FaultAction {
    /// The request's reply is delivered.
    Deliver,
    /// The request's reply is lost.
    DropReply,
    /// The request's reply is delivered after `ms` milliseconds.
    Delay(Duration),
    /// The request's reply is delivered twice.
    DuplicateReply,
    /// The emit itself is refused: the request never reaches the gateway.
    RejectEmit,
}

impl FaultAction {
    /// The word a request log names it by.
    pub const fn kind(&self) -> &'static str {
        match self {
            FaultAction::Deliver => "deliver",
            FaultAction::DropReply => "drop-reply",
            FaultAction::Delay(_) => "delay",
            FaultAction::DuplicateReply => "duplicate-reply",
            FaultAction::RejectEmit => "reject-emit",
        }
    }
}

/// The delays a drawn fault is of, in milliseconds.
pub const DELAY_MS: std::ops::RangeInclusive<u64> = 0..=5;

/// How many faults a drawn schedule is of.
pub const SCHEDULE_LENGTH: std::ops::RangeInclusive<usize> = 1..=8;

/// How many times its reckoned bound a case is given: the room a scheduler's jitter takes.
pub const SLACK: u32 = 4;

/// One step of an interleaving: a write, or a client-initiated transition.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DeliveryOp {
    Write,
    Transition,
}

impl DeliveryOp {
    /// The word the step is named by.
    pub const fn name(&self) -> &'static str {
        match self {
            DeliveryOp::Write => "write",
            DeliveryOp::Transition => "transition",
        }
    }
}

/// Every delivery step.
pub const DELIVERY_OPS: [DeliveryOp; 2] = [DeliveryOp::Write, DeliveryOp::Transition];

/// One request the transport was sent.
#[derive(Debug, Clone, PartialEq)]
pub struct RequestLogEntry {
    pub channel: String,
    pub action: FaultAction,
    pub correlation_id: Option<String>,
    pub retry_key: String,
    pub payload: Map<String, Value>,
}

/// What one fresh run of a composition exposes to the axioms.
#[derive(Default)]
pub struct LivenessScenario {
    pub outputs: Vec<BoxFuture<'static, ()>>,
    pub settlements: Vec<BoxFuture<'static, ()>>,
}

/// A composition, and the schedules it is run under.
pub struct LivenessSpec<Setup> {
    pub setup: Setup,
    pub timeout_ms: Duration,
    pub retry_budget: usize,
    pub cases: u32,
    pub schedules: Option<BoxedStrategy<Vec<FaultAction>>>,
    pub make_response: Option<Arc<Respond>>,
}
