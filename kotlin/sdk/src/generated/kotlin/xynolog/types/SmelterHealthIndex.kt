// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What the Smelter holds its index to, and what this start did for that. */
@Serializable
public data class SmelterHealthIndex(
    /** The model and the cut it makes an index by. */
    public val stamp: SmelterHealthIndexStamp,
    /** Whether this start made the index again, as it does where the index stated another stamp, or none. */
    public val madeAnew: Boolean,
) {
    /** How Java makes a `SmelterHealthIndex`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val stamp: SmelterHealthIndexStamp,
        private val madeAnew: Boolean,
    ) {
        public fun build(): SmelterHealthIndex = SmelterHealthIndex(stamp = stamp, madeAnew = madeAnew)
    }

    public companion object {
        /** A builder of a `SmelterHealthIndex` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(stamp: SmelterHealthIndexStamp, madeAnew: Boolean): Builder = Builder(stamp, madeAnew)
    }
}
