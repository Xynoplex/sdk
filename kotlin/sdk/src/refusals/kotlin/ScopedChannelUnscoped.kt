// refused: argument type mismatch: actual type is 'ScopedChannel<EnrichedResourceEvent>', but 'Channel<uninferred P (of fun <P> frames)>' was expected
// A channel of a resource's frames is read for a resource.
import xynolog.XynologClient
import xynolog.channels.Channels

fun everyResource(client: XynologClient) = client.wire.frames(Channels.MARK_ADDED)
