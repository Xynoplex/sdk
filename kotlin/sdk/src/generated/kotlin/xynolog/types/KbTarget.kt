// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Where to connect to a knowledge base: an endpoint, and the labels a client keeps of it. It carries no identity: which knowledge base answers at an address is known only once it has been reached with a token and asked, so a target is what every caller can build before then, and a session's whole input. A client keeps it locally; it is never sent. */
@Serializable
@JsonIgnoreUnknownKeys
public data class KbTarget(
    /** The key the client stores a session's credentials under. Two sessions that share one storage have two ids, or each overwrites the other's tokens. Whoever builds the target chooses it; none is made up. */
    public val id: String,
    /** What a person reads the knowledge base as. Once the knowledge base has described itself, its own name. */
    public val label: String,
    public val endpoint: KbEndpoint,
) {
    /** How Java makes a `KbTarget`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: String,
        private val label: String,
        private val endpoint: KbEndpoint,
    ) {
        public fun build(): KbTarget = KbTarget(id = id, label = label, endpoint = endpoint)
    }

    public companion object {
        /** A builder of a `KbTarget` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(id: String, label: String, endpoint: KbEndpoint): Builder = Builder(id, label, endpoint)
    }
}
