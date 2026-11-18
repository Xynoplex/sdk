// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The bounds on how far the staging driver may run behind the working tree, in milliseconds. A knowledge base that does not sync git stages nothing, and reads neither. */
@Serializable
public data class ArchivistConfigStaging(
    /** The quiet period after the last change before pending changes are staged. */
    public val flushMs: Long,
    /** The longest a change waits to be staged while others keep arriving, measured from the oldest pending change. */
    public val maxWaitMs: Long,
) {
    /** How Java makes a `ArchivistConfigStaging`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val flushMs: Long,
        private val maxWaitMs: Long,
    ) {
        public fun build(): ArchivistConfigStaging = ArchivistConfigStaging(flushMs = flushMs, maxWaitMs = maxWaitMs)
    }

    public companion object {
        /** A builder of a `ArchivistConfigStaging` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(flushMs: Long, maxWaitMs: Long): Builder = Builder(flushMs, maxWaitMs)
    }
}
