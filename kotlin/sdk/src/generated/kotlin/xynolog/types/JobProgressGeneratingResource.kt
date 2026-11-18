// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** The model is generating the resource. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressGeneratingResource(
    @EncodeDefault
    public val code: JobProgressGeneratingResourceCode = JobProgressGeneratingResourceCode.GeneratingResource,
) : JobProgressMessage {
    /** How Java makes a `JobProgressGeneratingResource`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): JobProgressGeneratingResource = JobProgressGeneratingResource()
    }

    public companion object {
        /** A builder of a `JobProgressGeneratingResource` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
