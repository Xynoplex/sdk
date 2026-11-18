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
 * A job's parameters as the Dispatcher holds them: the `params` of its `job:create`, and what the Dispatcher adds. It adds `resourceId`, the resource the job is about: a `mark` job's own, and for a `yield` job the one its context focuses on. For a tagging job it adds `schema`, the tag schema its `schemaId` names, so that whoever holds the job needs no registry. Nothing the caller sent is changed or removed.
 */
@Serializable(with = JobParams.Serializer::class)
public data class JobParams(
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * The tag schema a tagging job's `schemaId` names, as the knowledge base registered it when the job was created. On a tagging job, and on no other.
     */
    @SerialName("schema")
    public val schema: TagSchema? = null,
    /** Every property the schema does not name, as it came. */
    public val rest: JsonObject = JsonObject(emptyMap()),
) {
    /** How Java makes a `JobParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        private var schema: TagSchema? = null
        private var rest: JsonObject = JsonObject(emptyMap())

        public fun schema(schema: TagSchema?): Builder {
            this.schema = schema
            return this
        }

        public fun rest(rest: JsonObject): Builder {
            this.rest = rest
            return this
        }

        public fun build(): JobParams = JobParams(resourceId = resourceId, schema = schema, rest = rest)
    }

    public companion object {
        /** A builder of a `JobParams` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }

    @Serializable
    internal data class Known(
        @SerialName("resourceId")
        public val resourceId: ResourceId,
        /**
         * The tag schema a tagging job's `schemaId` names, as the knowledge base registered it when the job was created. On a tagging job, and on no other.
         */
        @SerialName("schema")
        public val schema: TagSchema? = null,
    )

    internal object Serializer : KSerializer<JobParams> {
        private val named: Set<String> = setOf("resourceId", "schema")

        override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.JobParams", Known.serializer().descriptor)

        override fun deserialize(decoder: Decoder): JobParams {
            val json = decoder as? JsonDecoder ?: throw SerializationException("a JobParams is read from JSON alone")
            val all = json.decodeJsonElement().jsonObject
            val known = json.json.decodeFromJsonElement(Known.serializer(), JsonObject(all.filterKeys { it in named }))
            return JobParams(resourceId = known.resourceId, schema = known.schema, rest = JsonObject(all.filterKeys { it !in named }))
        }

        override fun serialize(encoder: Encoder, value: JobParams) {
            val json = encoder as? JsonEncoder ?: throw SerializationException("a JobParams is written as JSON alone")
            val known = json.json.encodeToJsonElement(Known.serializer(), Known(resourceId = value.resourceId, schema = value.schema)).jsonObject
            json.encodeJsonElement(JsonObject(known + value.rest))
        }
    }
}
