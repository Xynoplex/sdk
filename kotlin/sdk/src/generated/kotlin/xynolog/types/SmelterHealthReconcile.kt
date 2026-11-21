// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** How far the latest reconcile has got: the pass's `summary` when it is done, or its `error` when it failed. */
@Serializable
public data class SmelterHealthReconcile(
    public val phase: SmelterHealthReconcilePhase,
    /** What the pass came to. */
    public val summary: SmelterReconcileSummary? = null,
    /** Why it failed. */
    public val error: String? = null,
) {
    /** How Java makes a `SmelterHealthReconcile`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val phase: SmelterHealthReconcilePhase,
    ) {
        private var summary: SmelterReconcileSummary? = null
        private var error: String? = null

        public fun summary(summary: SmelterReconcileSummary?): Builder = apply { this.summary = summary }
        public fun error(error: String?): Builder = apply { this.error = error }

        public fun build(): SmelterHealthReconcile = SmelterHealthReconcile(phase = phase, summary = summary, error = error)
    }

    public companion object {
        /** A builder of a `SmelterHealthReconcile` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(phase: SmelterHealthReconcilePhase): Builder = Builder(phase)
    }
}
