// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** The dispatcher's liveness answer. It answers only once its queue has connected and its bus pumps are attached, so a 200 means it can take work. */
@Serializable
public data class DispatcherHealth(
    @EncodeDefault
    public val status: DispatcherHealthStatus = DispatcherHealthStatus.Ok,
    /** The queue it holds. */
    @EncodeDefault
    public val queue: DispatcherHealthQueue = DispatcherHealthQueue.Jetstream,
) {
    /** How Java makes a `DispatcherHealth`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): DispatcherHealth = DispatcherHealth()
    }

    public companion object {
        /** A builder of a `DispatcherHealth` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
