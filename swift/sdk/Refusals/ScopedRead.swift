// refused: cannot convert value of type 'ScopedChannel<EnrichedResourceEvent>' to expected argument type 'Channel<Payload>'
import Xynoplex

func missingScope(_ wire: Bus) async throws {
  _ = try await wire.frames(Channels.markAdded)
}
