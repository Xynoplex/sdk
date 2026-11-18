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
 * Present only when pieces of this unit were accepted at the subdivision floor while a count call said more was present. The unit completed, but incompletely — this carries the EVIDENCE (found vs counted, over how many pieces), never a judgment against any expected yield. Absent means complete: genuinely absent, not defaulted.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressCompletedItemsItemUnderReported(
    /**
     * Floor-accepted pieces in this unit.
     */
    @SerialName("pieces")
    public val pieces: Long,
    /**
     * Annotations extraction did find on those pieces — every span write-time-verified.
     */
    @SerialName("found")
    public val found: Long,
    /**
     * Mentions the count calls reported across those pieces (approximate by nature).
     */
    @SerialName("counted")
    public val counted: Long,
) {
    /** How Java makes a `JobProgressCompletedItemsItemUnderReported`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val pieces: Long,
        private val found: Long,
        private val counted: Long,
    ) {
        public fun build(): JobProgressCompletedItemsItemUnderReported = JobProgressCompletedItemsItemUnderReported(pieces = pieces, found = found, counted = counted)
    }

    public companion object {
        /** A builder of a `JobProgressCompletedItemsItemUnderReported` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(pieces: Long, found: Long, counted: Long): Builder = Builder(pieces, found, counted)
    }
}
