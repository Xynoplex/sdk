// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** How far the reconcile its first sweep is followed by has got (WEAVER.md § Reconcile): the pass's `summary` when it is done, or its `error` when it failed. */
@Serializable
public data class WeaverHealthReconcile(
    public val phase: WeaverHealthReconcilePhase,
    /** What the pass found and did. */
    public val summary: WeaverHealthReconcileSummary? = null,
    /** Why it failed. */
    public val error: String? = null,
) {
    /** How Java makes a `WeaverHealthReconcile`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val phase: WeaverHealthReconcilePhase,
    ) {
        private var summary: WeaverHealthReconcileSummary? = null
        private var error: String? = null

        public fun summary(summary: WeaverHealthReconcileSummary?): Builder = apply { this.summary = summary }
        public fun error(error: String?): Builder = apply { this.error = error }

        public fun build(): WeaverHealthReconcile = WeaverHealthReconcile(phase = phase, summary = summary, error = error)
    }

    public companion object {
        /** A builder of a `WeaverHealthReconcile` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(phase: WeaverHealthReconcilePhase): Builder = Builder(phase)
    }
}
