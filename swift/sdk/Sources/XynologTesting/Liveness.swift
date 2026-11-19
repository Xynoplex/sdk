import Foundation
import Xynolog

public struct AxiomViolation: Error, Sendable, CustomStringConvertible {
  public let description: String
  init(_ description: String) { self.description = description }
}

public func faultActions(using random: inout some RandomNumberGenerator) -> FaultAction {
  switch faults[Int.random(in: faults.indices, using: &random)] {
  case .delay: .delay(.milliseconds(Int.random(in: delayMs, using: &random)))
  case let fault: fault
  }
}

public func faultSchedules(_ count: Int) -> [[FaultAction]] {
  precondition(count >= 0)
  var random = ScheduleRandom()
  return (0..<count).map { _ in
    (0..<Int.random(in: scheduleLength, using: &random)).map { _ in faultActions(using: &random) }
  }
}

/// Runs the output, settlement and retry axioms on each fresh composition, under the spec's
/// schedules or, with none, `cases` drawn ones.
public func assertLivenessAxioms(_ spec: LivenessSpec) async throws {
  let schedules = spec.schedules.isEmpty ? faultSchedules(spec.cases) : spec.schedules
  guard !schedules.isEmpty, spec.retryBudget >= 0, spec.retryBudget != Int.max,
    spec.timeout > .zero
  else { throw AxiomViolation("Liveness needs a timeout, retry budget and at least one schedule") }

  for schedule in schedules {
    let transport = ScriptedTransport(
      channels: bridgedChannels, schedule: schedule, clock: spec.clock, respond: spec.makeResponse)
    defer { transport.dispose() }
    let scenario = try await spec.setup(transport)
    defer { scenario.dispose() }
    guard !scenario.outputs.isEmpty || !scenario.settlements.isEmpty else {
      throw AxiomViolation("A liveness scenario must observe an output or a settlement")
    }
    let delays = schedule.reduce(Duration.zero) { total, fault in
      if case .delay(let delay) = fault { return total + delay }
      return total
    }
    let bound = (spec.timeout * (spec.retryBudget + 1) + delays) * slack
    let (observations, observation) = AsyncStream<Observation>.makeStream()
    var tasks: [Task<Void, Never>] = []
    for (index, output) in scenario.outputs.enumerated() {
      tasks.append(
        spawn {
          await output()
          observation.yield(.output(index))
        })
    }
    for (index, settlement) in scenario.settlements.enumerated() {
      tasks.append(
        spawn {
          await settlement()
          observation.yield(.settlement(index))
        })
    }
    let clock = spec.clock
    tasks.append(
      spawn {
        do {
          try await clock.sleep(for: bound)
          observation.yield(.deadline)
        } catch {}
      })
    defer {
      observation.finish()
      for task in tasks { task.cancel() }
    }
    var outcomes: Set<Observation> = []
    let count = scenario.outputs.count + scenario.settlements.count
    for await next in observations {
      if next == .deadline { break }
      outcomes.insert(next)
      if outcomes.count == count { break }
    }
    try Task.checkCancellation()
    if let index = scenario.settlements.indices.first(where: { !outcomes.contains(.settlement($0)) }
    ) {
      throw AxiomViolation("L2: settlement \(index) timed out under \(schedule)")
    }
    let requests = Dictionary(grouping: transport.requestLog, by: \.retryKey)
    if let exceeded = requests.values.first(where: { $0.count > spec.retryBudget + 1 }) {
      throw AxiomViolation(
        "L2: \(exceeded[0].channel) exceeded its retry budget under \(schedule)")
    }
    if let index = scenario.outputs.indices.first(where: { !outcomes.contains(.output($0)) }) {
      throw AxiomViolation("L1: output \(index) stayed silent under \(schedule)")
    }
  }
}

private enum Observation: Hashable, Sendable {
  case output(Int)
  case settlement(Int)
  case deadline
}

public protocol DeliverySubject: Sendable {
  func write(_ eventId: String) async throws
  func transition() async throws
  func delivered() async throws -> [String]
}

public func deliveryOps(_ count: Int, longest: Int) -> [[DeliveryOp]] {
  precondition(count >= 0 && longest > 0)
  var random = ScheduleRandom()
  return (0..<count).map { _ in
    var operations: [DeliveryOp] = (0..<Int.random(in: 1...longest, using: &random)).map { _ in
      DeliveryOp.allCases[Int.random(in: DeliveryOp.allCases.indices, using: &random)]
    }
    if !operations.contains(.write) { operations[0] = .write }
    return operations
  }
}

public func assertExactlyOnceDelivery(
  _ interleavings: [[DeliveryOp]], setup: @Sendable () async throws -> any DeliverySubject
) async throws {
  guard !interleavings.isEmpty else {
    throw AxiomViolation("Delivery needs at least one interleaving")
  }
  for operations in interleavings {
    let subject = try await setup()
    var written: [String] = []
    for (index, operation) in operations.enumerated() {
      switch operation {
      case .write:
        let id = "e\(index)"
        try await subject.write(id)
        written.append(id)
      case .transition:
        try await subject.transition()
      }
    }
    let delivered = try await subject.delivered()
    guard !written.isEmpty, delivered == written else {
      throw AxiomViolation("L3: wrote \(written) and received \(delivered) under \(operations)")
    }
  }
}

private struct ScheduleRandom: RandomNumberGenerator {
  private var state: UInt64 = 7

  mutating func next() -> UInt64 {
    state &+= 0x9e37_79b9_7f4a_7c15
    var mixed = state
    mixed = (mixed ^ (mixed >> 30)) &* 0xbf58_476d_1ce4_e5b9
    mixed = (mixed ^ (mixed >> 27)) &* 0x94d0_49bb_1331_11eb
    return mixed ^ (mixed >> 31)
  }
}
