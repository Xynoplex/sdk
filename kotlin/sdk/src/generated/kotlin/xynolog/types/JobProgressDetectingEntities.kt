// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Entity detection, one entity type at a time. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressDetectingEntities(
    @EncodeDefault
    public val code: JobProgressDetectingEntitiesCode = JobProgressDetectingEntitiesCode.DetectingEntities,
    /** Entity type currently being detected */
    public val entityType: String,
) : JobProgressMessage {
    /** How Java makes a `JobProgressDetectingEntities`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val entityType: String,
    ) {
        public fun build(): JobProgressDetectingEntities = JobProgressDetectingEntities(entityType = entityType)
    }

    public companion object {
        /** A builder of a `JobProgressDetectingEntities` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(entityType: String): Builder = Builder(entityType)
    }
}
