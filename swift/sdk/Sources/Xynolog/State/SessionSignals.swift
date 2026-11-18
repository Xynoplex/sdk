public protocol StateUnit: Sendable {
  func dispose()
}

public final class SessionSignals: StateUnit {
  public let sessionEnded = Watched<SessionEnded?>(nil)
  public let permissionDenied = Watched<PermissionDenied?>(nil)
  public let kbIdentityConflict = Watched<KbIdentityConflict?>(nil)

  public init() {}

  public func notifySessionEnded(_ reason: SessionEndReason) {
    sessionEnded.set(SessionEnded(reason: reason))
  }

  public func notifyPermissionDenied(_ detail: String?) {
    permissionDenied.set(PermissionDenied(detail: detail))
  }

  public func notifyKbIdentityConflict(_ conflict: KbIdentityConflict) {
    kbIdentityConflict.set(conflict)
  }

  public func acknowledgeSessionEnded() { sessionEnded.set(nil) }
  public func acknowledgePermissionDenied() { permissionDenied.set(nil) }
  public func acknowledgeKbIdentityConflict() { kbIdentityConflict.set(nil) }

  public func dispose() {
    sessionEnded.finish()
    permissionDenied.finish()
    kbIdentityConflict.finish()
  }

  deinit { dispose() }
}
