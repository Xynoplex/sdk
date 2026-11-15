// refused: var 'shared' is not concurrency-safe because it is nonisolated global shared mutable state
#if XYNOLOG_SENDABLE_CANARY
  var shared = 0
#endif
