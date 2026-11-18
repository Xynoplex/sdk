// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a principal last said it is called, and when: the profile a `principal:profiled` event gives. */
@Serializable
public data class Profile(
    /** The name the principal last gave. */
    public val name: String,
    /** The timestamp of the event that gave it. */
    public val since: String,
) {
    /** How Java makes a `Profile`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val since: String,
    ) {
        public fun build(): Profile = Profile(name = name, since = since)
    }

    public companion object {
        /** A builder of a `Profile` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, since: String): Builder = Builder(name, since)
    }
}
