// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The discovered limits of one engine. */
@Serializable
public data class EngineLimits(
    public val engine: Engine,
    public val limits: InferenceLimits,
) {
    /** How Java makes a `EngineLimits`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val engine: Engine,
        private val limits: InferenceLimits,
    ) {
        public fun build(): EngineLimits = EngineLimits(engine = engine, limits = limits)
    }

    public companion object {
        /** A builder of a `EngineLimits` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(engine: Engine, limits: InferenceLimits): Builder = Builder(engine, limits)
    }
}
