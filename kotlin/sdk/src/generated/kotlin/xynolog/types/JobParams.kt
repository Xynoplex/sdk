// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.KeepGeneratedSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.Transient
import kotlinx.serialization.json.JsonObject
import xynolog.identifiers.ResourceId

/** A job's parameters as the Dispatcher holds them: the `params` of its `job:create`, and what the Dispatcher adds. It adds `resourceId`, the resource the job is about: a `mark` job's own, and for a `yield` job the one its context focuses on. For a tagging job it adds `schema`, the tag schema its `schemaId` names, so that whoever holds the job needs no registry. Nothing the caller sent is changed or removed. */
@Serializable(with = JobParams.Serializer::class)
@KeepGeneratedSerializer
public data class JobParams(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** The tag schema a tagging job's `schemaId` names, as the knowledge base registered it when the job was created. On a tagging job, and on no other. */
    public val schema: TagSchema? = null,
    /** Every property the schema does not name, as it came. */
    @Transient
    public val rest: JsonObject = JsonObject(emptyMap()),
) {
    /** How Java makes a `JobParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        private var schema: TagSchema? = null
        private var rest: JsonObject = JsonObject(emptyMap())

        public fun schema(schema: TagSchema?): Builder = apply { this.schema = schema }
        public fun rest(rest: JsonObject): Builder = apply { this.rest = rest }

        public fun build(): JobParams = JobParams(resourceId = resourceId, schema = schema, rest = rest)
    }

    public companion object {
        /** A builder of a `JobParams` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }

    internal object Serializer : OpenObjectSerializer<JobParams>(
        JobParams.generatedSerializer(),
        JobParams::rest,
        { named, rest -> named.copy(rest = rest) },
    )
}
