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

@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressCompletedItemsItem(
    /**
     * The item, shown verbatim.
     */
    @SerialName("value")
    public val value: String,
    /**
     * Annotations found for it.
     */
    @SerialName("foundCount")
    public val foundCount: Long,
    /**
     * Annotations actually persisted for it — post-dedupe and post-durability-acknowledgement, so it counts what the event log holds, not what the model proposed. Beside foundCount this is the per-unit yield the sizing work is judged by. Present on flows whose units persist as they complete (a linking job); the tagging flow reports the same fact as byCategory on its result, because its annotations are built after the per-category loop.
     */
    @SerialName("persistedCount")
    public val persistedCount: Long? = null,
    /**
     * Present only when pieces of this unit were accepted at the subdivision floor while a count call said more was present. The unit completed, but incompletely — this carries the EVIDENCE (found vs counted, over how many pieces), never a judgment against any expected yield. Absent means complete: genuinely absent, not defaulted.
     */
    @SerialName("underReported")
    public val underReported: JobProgressCompletedItemsItemUnderReported? = null,
) {
    /** How Java makes a `JobProgressCompletedItemsItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val value: String,
        private val foundCount: Long,
    ) {
        private var persistedCount: Long? = null
        private var underReported: JobProgressCompletedItemsItemUnderReported? = null

        public fun persistedCount(persistedCount: Long?): Builder {
            this.persistedCount = persistedCount
            return this
        }

        public fun underReported(underReported: JobProgressCompletedItemsItemUnderReported?): Builder {
            this.underReported = underReported
            return this
        }

        public fun build(): JobProgressCompletedItemsItem = JobProgressCompletedItemsItem(value = value, foundCount = foundCount, persistedCount = persistedCount, underReported = underReported)
    }

    public companion object {
        /** A builder of a `JobProgressCompletedItemsItem` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(value: String, foundCount: Long): Builder = Builder(value, foundCount)
    }
}
