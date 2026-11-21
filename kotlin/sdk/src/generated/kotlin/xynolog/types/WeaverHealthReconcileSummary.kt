// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What the pass found and did. */
@Serializable
public data class WeaverHealthReconcileSummary(
    /** How many resources it checked. */
    public val resourcesChecked: Long,
    /** How many of them were divergent: the graph held them otherwise than the record. */
    public val divergent: Long,
    /** How many divergent resources it rebuilt. */
    public val healed: Long,
    /** How many it did not heal, because the rebuild stopped at an event it could not apply. */
    public val healFailures: Long,
    /** How many orphaned views it found: resources the catalog lists and the record holds no events for. Each is counted, and not healed. */
    public val orphaned: Long,
) {
    /** How Java makes a `WeaverHealthReconcileSummary`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourcesChecked: Long,
        private val divergent: Long,
        private val healed: Long,
        private val healFailures: Long,
        private val orphaned: Long,
    ) {
        public fun build(): WeaverHealthReconcileSummary = WeaverHealthReconcileSummary(resourcesChecked = resourcesChecked, divergent = divergent, healed = healed, healFailures = healFailures, orphaned = orphaned)
    }

    public companion object {
        /** A builder of a `WeaverHealthReconcileSummary` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resourcesChecked: Long, divergent: Long, healed: Long, healFailures: Long, orphaned: Long): Builder = Builder(resourcesChecked, divergent, healed, healFailures, orphaned)
    }
}
