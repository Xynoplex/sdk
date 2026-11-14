// refused: cannot convert value of type 'BrowseResourceOpenEvent' to expected argument type 'BeckonFocusEvent'
import Xynoplex

func wrongPayload(_ wire: Bus, _ resource: ResourceId) async throws {
  _ = try await wire.emit(Channels.beckonFocus, BrowseResourceOpenEvent(resourceId: resource))
}
