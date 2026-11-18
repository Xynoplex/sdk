// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** A knowledge base's committed identity (`project.name` and `site.domain` in its .xynolog/config.yaml), as a service's document names the knowledge base it serves. Its telemetry names it by its DID (`xynolog.kb`, specs/src/service-telemetry/telemetry.json). */
@Serializable
public data class KbIdentity(
    /** Its name. The gateway publishes it as its resource metadata's `resource_name`. */
    public val name: String,
    /** Its did:web domain: its permanent identity, the source of the audience its tokens must carry, and the authority its people and agents are named under. */
    public val domain: String,
) {
    /** How Java makes a `KbIdentity`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val domain: String,
    ) {
        public fun build(): KbIdentity = KbIdentity(name = name, domain = domain)
    }

    public companion object {
        /** A builder of a `KbIdentity` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, domain: String): Builder = Builder(name, domain)
    }
}
