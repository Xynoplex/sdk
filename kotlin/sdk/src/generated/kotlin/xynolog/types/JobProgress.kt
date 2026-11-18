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
 * Progress report from a running job. The required field is `percentage`; `message` carries the coded phase and the rest are optional job-shape fields. This is the single progress shape for every job type — annotation workers and generation alike. Terminality is signalled on `job:complete` / `job:fail`, not here. A flow that iterates a user-chosen list (entity types for references, categories for tags) reports its position as one `current`/`processed`/`total` triple, the same shape for both, so a client never needs to know which flow it is drawing.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgress(
    /**
     * Completion percentage (0-100)
     */
    @SerialName("percentage")
    public val percentage: Double,
    @SerialName("message")
    public val message: JobProgressMessage? = null,
    /**
     * Annotation this job is attached to, when applicable. Echoed inside JobProgress (in addition to the outer command envelope) so consumers that only see the inner progress object (e.g. what `yield.delegate` returns) can still route visual feedback to a specific annotation.
     */
    @SerialName("annotationId")
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    /**
     * What the run is working on right now. `kind` is a CODE the client renders a localized name for; `value` is KB data (an entity type, a tag category) shown verbatim — the same split as `requestParams`. Absent on flows that iterate nothing, such as generation.
     */
    @SerialName("current")
    public val current: JobProgressCurrent? = null,
    /**
     * Items completed so far, zero-based — the item in `current` is the one after these. Paired with `total`.
     */
    @SerialName("processed")
    public val processed: Long? = null,
    /**
     * Items this run will process in all.
     */
    @SerialName("total")
    public val total: Long? = null,
    /**
     * Entities found so far (a linking job)
     */
    @SerialName("entitiesFound")
    public val entitiesFound: Long? = null,
    /**
     * Cumulative mentions the count-verifier priced across the pieces accepted so far — the denominator for a real progress bar (found of ~expected). Approximate by nature (the count saturates on very large pieces) and monotonically growing within a run. ABSENT when the provider does not verify detection yield, or before any piece has been priced: no claim, never zero.
     */
    @SerialName("entitiesExpected")
    public val entitiesExpected: Long? = null,
    /**
     * Annotations emitted so far (a linking job)
     */
    @SerialName("entitiesEmitted")
    public val entitiesEmitted: Long? = null,
    /**
     * Per-item results for the items already finished, for the UI's completed log. Generic across flows for the same reason `current` is.
     */
    @SerialName("completedItems")
    public val completedItems: kotlin.collections.List<JobProgressCompletedItemsItem>? = null,
    /**
     * Echoed job parameters for display in the progress UI. `label` is a CODE, not a sentence — the client owns the wording, same rule as the progress message. `value` is the user's own input (an entity-type list, their instructions) and is deliberately NOT translated: it is their words, not ours.
     */
    @SerialName("requestParams")
    public val requestParams: kotlin.collections.List<JobProgressRequestParamsItem>? = null,
) : JobStoredProgress {
    /** How Java makes a `JobProgress`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val percentage: Double,
    ) {
        private var message: JobProgressMessage? = null
        private var annotationId: AnnotationId? = null
        private var current: JobProgressCurrent? = null
        private var processed: Long? = null
        private var total: Long? = null
        private var entitiesFound: Long? = null
        private var entitiesExpected: Long? = null
        private var entitiesEmitted: Long? = null
        private var completedItems: kotlin.collections.List<JobProgressCompletedItemsItem>? = null
        private var requestParams: kotlin.collections.List<JobProgressRequestParamsItem>? = null

        public fun message(message: JobProgressMessage?): Builder {
            this.message = message
            return this
        }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder {
            this.annotationId = annotationId
            return this
        }

        public fun current(current: JobProgressCurrent?): Builder {
            this.current = current
            return this
        }

        public fun processed(processed: Long?): Builder {
            this.processed = processed
            return this
        }

        public fun total(total: Long?): Builder {
            this.total = total
            return this
        }

        public fun entitiesFound(entitiesFound: Long?): Builder {
            this.entitiesFound = entitiesFound
            return this
        }

        public fun entitiesExpected(entitiesExpected: Long?): Builder {
            this.entitiesExpected = entitiesExpected
            return this
        }

        public fun entitiesEmitted(entitiesEmitted: Long?): Builder {
            this.entitiesEmitted = entitiesEmitted
            return this
        }

        public fun completedItems(completedItems: kotlin.collections.List<JobProgressCompletedItemsItem>?): Builder {
            this.completedItems = completedItems
            return this
        }

        public fun requestParams(requestParams: kotlin.collections.List<JobProgressRequestParamsItem>?): Builder {
            this.requestParams = requestParams
            return this
        }

        public fun build(): JobProgress = JobProgress(percentage = percentage, message = message, annotationId = annotationId, current = current, processed = processed, total = total, entitiesFound = entitiesFound, entitiesExpected = entitiesExpected, entitiesEmitted = entitiesEmitted, completedItems = completedItems, requestParams = requestParams)
    }

    public companion object {
        /** A builder of a `JobProgress` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(percentage: Double): Builder = Builder(percentage)
    }
}
