// Generated from protocol/specs/src/client/testing.json; do not edit.
// Regenerate: make generate (codegen/lib/testing/swift.ml)
import Xynolog

/// What the wire does to one request.
public enum FaultAction: Sendable, Equatable {
  /// The request's reply is delivered.
  case deliver
  /// The request's reply is lost.
  case dropReply
  /// The request's reply is delivered after `ms` milliseconds.
  case delay(Duration)
  /// The request's reply is delivered twice.
  case duplicateReply
  /// The emit itself is refused: the request never reaches the gateway.
  case rejectEmit
  /// The word a request log names it by.
  public var kind: String {
    switch self {
    case .deliver: "deliver"
    case .dropReply: "drop-reply"
    case .delay: "delay"
    case .duplicateReply: "duplicate-reply"
    case .rejectEmit: "reject-emit"
    }
  }
}

/// Every fault: what a schedule is drawn from, a delay's own duration drawn apart.
let faults: [FaultAction] = [.deliver, .dropReply, .delay(.zero), .duplicateReply, .rejectEmit]

/// The delays a drawn fault is of, in milliseconds.
let delayMs = 0...5

/// How many faults a drawn schedule is of.
let scheduleLength = 1...8

/// How many times its reckoned bound a case is given: the room a scheduler's jitter takes.
let slack = 4

/// One step of an interleaving: a write, or a client-initiated transition.
public enum DeliveryOp: String, Sendable, CaseIterable {
  case write
  case transition
}

/// One request the transport was sent.
public struct RequestLogEntry: Sendable {
  /// The channel it was sent on.
  public let channel: String
  /// What the schedule did to it.
  public let action: FaultAction
  /// What pairs it with its reply; nil for a request that awaits none.
  public let correlationId: String?
  /// Its identity across retries: two entries with the same key are one logical request, sent
  /// again.
  public let retryKey: String
  /// Its payload, as it was sent.
  public let payload: [String: JSONValue]
}

/// What one fresh run of a composition exposes to the axioms.
public struct LivenessScenario: Sendable {
  /// One per output: each returns when the output has said something, a value or a failure (L1).
  public let outputs: [@Sendable () async -> Void]
  /// One per awaited path: each returns when the path has settled, by returning or by throwing
  /// (L2).
  public let settlements: [@Sendable () async -> Void]
  /// Ends what the run opened; called once its case is checked.
  public let dispose: @Sendable () -> Void
  public init(
    outputs: [@Sendable () async -> Void], settlements: [@Sendable () async -> Void],
    dispose: @escaping @Sendable () -> Void
  ) {
    self.outputs = outputs
    self.settlements = settlements
    self.dispose = dispose
  }
}

/// A composition, and the schedules it is run under.
public struct LivenessSpec: Sendable {
  /// Builds a fresh composition over the transport it is given, which keeps no deadline, and gives
  /// what it exposes. Called once per case.
  public let setup: @Sendable (ScriptedTransport) async throws -> LivenessScenario
  /// The time the composition gives a bus request, its client's `busRequestTimeoutMs`. A case's
  /// bound is derived from it: the timeout times one more than `retryBudget`, and the schedule's
  /// delays, all of it `slack` times over.
  public let timeout: Duration
  /// How often the composition may send a logical request again.
  public let retryBudget: Int
  /// How many schedules are drawn (`faultSchedules`) when `schedules` states none.
  public let cases: Int
  /// The fault schedules to run, one case each, in place of drawn ones.
  public let schedules: [[FaultAction]]
  /// What the gateway answers a request no queued reply answers, as `ScriptedTransport`'s `respond`
  /// does.
  public let makeResponse: Respond
  /// The clock a case's bound and the schedule's delays are timed by.
  let clock: any Clock<Duration>
  public init(
    setup: @escaping @Sendable (ScriptedTransport) async throws -> LivenessScenario,
    timeout: Duration, retryBudget: Int, cases: Int, schedules: [[FaultAction]] = [],
    makeResponse: @escaping Respond, clock: any Clock<Duration> = ContinuousClock()
  ) {
    self.setup = setup
    self.timeout = timeout
    self.retryBudget = retryBudget
    self.cases = cases
    self.schedules = schedules
    self.makeResponse = makeResponse
    self.clock = clock
  }
}
