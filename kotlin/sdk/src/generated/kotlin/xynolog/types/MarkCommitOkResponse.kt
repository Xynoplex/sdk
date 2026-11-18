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
 * What the commit persisted.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkCommitOkResponse(
    /**
     * Annotations the command named that are durable in the event log. Equals the batch size on success, on a first commit and on a retry alike — the commit appends only what the resource does not already hold, so a wholly-redundant retry has still succeeded and says so. Not an append tally: a caller must never have to read a 0 as 'all good'.
     */
    @SerialName("persisted")
    public val persisted: Long,
    /**
     * Ids the batch covers, whether appended now or already present.
     */
    @SerialName("annotationIds")
    public val annotationIds: kotlin.collections.List<AnnotationId>,
) {
    /** How Java makes a `MarkCommitOkResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val persisted: Long,
        private val annotationIds: kotlin.collections.List<AnnotationId>,
    ) {
        public fun build(): MarkCommitOkResponse = MarkCommitOkResponse(persisted = persisted, annotationIds = annotationIds)
    }

    public companion object {
        /** A builder of a `MarkCommitOkResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(persisted: Long, annotationIds: kotlin.collections.List<AnnotationId>): Builder = Builder(persisted, annotationIds)
    }
}
