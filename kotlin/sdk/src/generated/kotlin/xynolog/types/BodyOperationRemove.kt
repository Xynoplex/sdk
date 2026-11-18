// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class BodyOperationRemove(
    @EncodeDefault
    public val op: BodyOperationRemoveOp = BodyOperationRemoveOp.Remove,
    public val item: AnnotationBody,
) : BodyOperation {
    /** How Java makes a `BodyOperationRemove`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val item: AnnotationBody,
    ) {
        public fun build(): BodyOperationRemove = BodyOperationRemove(item = item)
    }

    public companion object {
        /** A builder of a `BodyOperationRemove` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(item: AnnotationBody): Builder = Builder(item)
    }
}
