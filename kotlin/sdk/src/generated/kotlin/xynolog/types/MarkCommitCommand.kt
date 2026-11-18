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
 * Bus command to persist a detection unit's annotations as one acknowledged batch. It is answered only after every annotation is in the event log, so a worker can gate unit completion on durability rather than on emission. The batch is the unit: a partial commit is reported as a failure, and the worker retries the whole unit, which is safe because annotation ids are deterministic: content-addressed, so re-emitting one is a no-op.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkCommitCommand(
    /**
     * Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this.
     */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    /**
     * The emitter's capabilities (the token's `roles`), injected by the /bus/emit gateway. Clients do not set this. An emitter carrying the worker role must cite the job this batch fulfils in `jobId`; the Stower refuses the batch otherwise.
     */
    @SerialName("_roles")
    public val roles: kotlin.collections.List<String>? = null,
    /**
     * The job this batch fulfils. Required when the emitter carries the worker role; absent for self-initiated work (a person, or an agent acting on its own). The knowledge base derives who requested these annotations from the cited job's own events — the emitter never says who the work was for.
     */
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId? = null,
    /**
     * Resource every annotation in this batch targets.
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * The unit's annotations, already built with deterministic ids. Re-committing an identical batch is a no-op rather than a duplicate.
     */
    @SerialName("annotations")
    public val annotations: kotlin.collections.List<Annotation>,
) {
    /** How Java makes a `MarkCommitCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val annotations: kotlin.collections.List<Annotation>,
    ) {
        private var userId: UserId? = null
        private var roles: kotlin.collections.List<String>? = null
        private var jobId: JobId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder {
            this.userId = userId
            return this
        }

        public fun roles(roles: kotlin.collections.List<String>?): Builder {
            this.roles = roles
            return this
        }

        @JvmExposeBoxed
        public fun jobId(jobId: JobId?): Builder {
            this.jobId = jobId
            return this
        }

        public fun build(): MarkCommitCommand = MarkCommitCommand(userId = userId, roles = roles, jobId = jobId, resourceId = resourceId, annotations = annotations)
    }

    public companion object {
        /** A builder of a `MarkCommitCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, annotations: kotlin.collections.List<Annotation>): Builder = Builder(resourceId, annotations)
    }
}
