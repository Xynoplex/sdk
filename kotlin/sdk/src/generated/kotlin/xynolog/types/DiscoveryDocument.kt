// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * The launcher's KB discovery document — the schema authority for <stateDir>/discovery/kbs.json, which the Xynolog CLI (xynolog/cli) regenerates on every stack mutation and the Browser container mounts read-only at /discovery. NOT an API endpoint: a static document fetched same-origin by browsers (via the Browser's static server). An empty kbs list is meaningful ("the launcher manages nothing right now") and distinct from an absent file.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class DiscoveryDocument(
    /**
     * Document schema version. Consumers MUST check it and ignore documents they do not understand.
     */
    @SerialName("version")
    public val version: Long,
    /**
     * Every KB the launcher currently manages, local and forwarded
     */
    @SerialName("kbs")
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
