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
 * One of the knowledge base's engines: a provider and a model its Inference document names, and the jobs the document has it used for. An engine is not a principal: whichever worker claims a job does it, under its own account, and names on each write the engine it used, if any. Carries no inference limits: the services that hold the inference credentials report those (InferenceLimitsResult).
 */
@Serializable
public data class EngineEntry(
    @SerialName("engine")
    public val engine: Engine,
    /**
     * The jobs the knowledge base's Inference document has this engine used for, as a claim names them. Absent for an engine only Librarian actors ask.
     */
    @SerialName("jobs")
    public val jobs: kotlin.collections.List<JobFilter>? = null,
) {
    /** How Java makes a `EngineEntry`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val engine: Engine,
    ) {
        private var jobs: kotlin.collections.List<JobFilter>? = null

        public fun jobs(jobs: kotlin.collections.List<JobFilter>?): Builder {
            this.jobs = jobs
            return this
        }

        public fun build(): EngineEntry = EngineEntry(engine = engine, jobs = jobs)
    }

    public companion object {
        /** A builder of a `EngineEntry` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(engine: Engine): Builder = Builder(engine)
    }
}
