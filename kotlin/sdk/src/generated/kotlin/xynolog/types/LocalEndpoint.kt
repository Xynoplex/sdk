// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** A knowledge base the host process has loaded and reaches through a transport with no wire. */
@Serializable
@JsonIgnoreUnknownKeys
public data class LocalEndpoint(
    /** Discriminant: the endpoint is in the host process. */
    @EncodeDefault
    public val kind: LocalEndpointKind = LocalEndpointKind.Local,
    /** Which loaded knowledge base, named by an id that means something to the host process alone. */
    public val kbId: String,
) : KbEndpoint {
    /** How Java makes a `LocalEndpoint`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kbId: String,
    ) {
        public fun build(): LocalEndpoint = LocalEndpoint(kbId = kbId)
    }

    public companion object {
        /** A builder of a `LocalEndpoint` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kbId: String): Builder = Builder(kbId)
    }
}
