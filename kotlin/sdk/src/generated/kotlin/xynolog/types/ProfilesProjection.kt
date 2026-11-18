// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What the principals of a knowledge base are called: the file `projections/__system__/profiles.json` under the state directory, the sum of the `principal:profiled` events. The Archivist writes it; the Archivist and the Librarian read it to name the principals a reply mentions. Written as JSON indented by two spaces. */
@Serializable
public data class ProfilesProjection(
    /** Each principal's current profile, keyed by its DID. */
    public val profiles: kotlin.collections.Map<String, Profile>,
) {
    /** How Java makes a `ProfilesProjection`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val profiles: kotlin.collections.Map<String, Profile>,
    ) {
        public fun build(): ProfilesProjection = ProfilesProjection(profiles = profiles)
    }

    public companion object {
        /** A builder of a `ProfilesProjection` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(profiles: kotlin.collections.Map<String, Profile>): Builder = Builder(profiles)
    }
}
