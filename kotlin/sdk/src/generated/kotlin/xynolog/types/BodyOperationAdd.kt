// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class BodyOperationAdd(
    @EncodeDefault
    public val op: BodyOperationAddOp = BodyOperationAddOp.Add,
    public val item: BodyOperationAddItem,
) : AnnotationBodyUpdatedPayloadOperationsItem,
    MarkUpdateBodyCommandOperationsItem,
    UpdateAnnotationBodyRequestOperationsItem {
    /** How Java makes a `BodyOperationAdd`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val item: BodyOperationAddItem,
    ) {
        public fun build(): BodyOperationAdd = BodyOperationAdd(item = item)
    }

    public companion object {
        /** A builder of a `BodyOperationAdd` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(item: BodyOperationAddItem): Builder = Builder(item)
    }
}
