// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class BodyOperationReplace(
    @EncodeDefault
    public val op: BodyOperationReplaceOp = BodyOperationReplaceOp.Replace,
    public val oldItem: AnnotationBody,
    public val newItem: AnnotationBody,
) : BodyOperation {
    /** How Java makes a `BodyOperationReplace`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val oldItem: AnnotationBody,
        private val newItem: AnnotationBody,
    ) {
        public fun build(): BodyOperationReplace = BodyOperationReplace(oldItem = oldItem, newItem = newItem)
    }

    public companion object {
        /** A builder of a `BodyOperationReplace` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(oldItem: AnnotationBody, newItem: AnnotationBody): Builder = Builder(oldItem, newItem)
    }
}
