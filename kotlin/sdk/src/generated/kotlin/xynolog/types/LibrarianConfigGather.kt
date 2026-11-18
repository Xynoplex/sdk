// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** The bound on a gather. */
@Serializable
public data class LibrarianConfigGather(
    /** How long a gather around a resource waits for the Smelter's decision on it before answering without similar passages, in milliseconds. */
    public val settleTimeoutMs: Long,
) {
    /** How Java makes a `LibrarianConfigGather`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val settleTimeoutMs: Long,
    ) {
        public fun build(): LibrarianConfigGather = LibrarianConfigGather(settleTimeoutMs = settleTimeoutMs)
    }

    public companion object {
        /** A builder of a `LibrarianConfigGather` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(settleTimeoutMs: Long): Builder = Builder(settleTimeoutMs)
    }
}
