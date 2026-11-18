// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A graph held in the memory of the one process that is given it: for a test. It cannot be shared between processes, so a service that writes the graph for another to read, or reads what another wrote, refuses it. */
@Serializable
public data class MemoryGraphConfig(
    @EncodeDefault
    public val type: MemoryGraphConfigType = MemoryGraphConfigType.Memory,
) : GraphConfig {
    /** How Java makes a `MemoryGraphConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): MemoryGraphConfig = MemoryGraphConfig()
    }

    public companion object {
        /** A builder of a `MemoryGraphConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
