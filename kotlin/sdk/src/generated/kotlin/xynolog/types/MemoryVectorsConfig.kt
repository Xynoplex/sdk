// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A vector index held in the memory of the one process that is given it: for a test. It cannot be shared between processes, so a service that writes the index for another to search, or searches what another wrote, refuses it. */
@Serializable
public data class MemoryVectorsConfig(
    @EncodeDefault
    public val type: MemoryVectorsConfigType = MemoryVectorsConfigType.Memory,
) : VectorsConfig {
    /** How Java makes a `MemoryVectorsConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): MemoryVectorsConfig = MemoryVectorsConfig()
    }

    public companion object {
        /** A builder of a `MemoryVectorsConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
