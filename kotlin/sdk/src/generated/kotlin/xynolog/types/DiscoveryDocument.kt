// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** The launcher's KB discovery document — the schema authority for <stateDir>/discovery/kbs.json, which the Xynolog CLI (xynolog/cli) regenerates on every stack mutation and the Browser container mounts read-only at /discovery. NOT an API endpoint: a static document fetched same-origin by browsers (via the Browser's static server). An empty kbs list is meaningful ("the launcher manages nothing right now") and distinct from an absent file. */
@Serializable
@JsonIgnoreUnknownKeys
public data class DiscoveryDocument(
    /** Document schema version. Consumers MUST check it and ignore documents they do not understand. */
    public val version: Long,
    /** Every KB the launcher currently manages, local and forwarded */
    public val kbs: kotlin.collections.List<DiscoveredKB>,
) {
    /** How Java makes a `DiscoveryDocument`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val version: Long,
        private val kbs: kotlin.collections.List<DiscoveredKB>,
    ) {
        public fun build(): DiscoveryDocument = DiscoveryDocument(version = version, kbs = kbs)
    }

    public companion object {
        /** A builder of a `DiscoveryDocument` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(version: Long, kbs: kotlin.collections.List<DiscoveredKB>): Builder = Builder(version, kbs)
    }
}
