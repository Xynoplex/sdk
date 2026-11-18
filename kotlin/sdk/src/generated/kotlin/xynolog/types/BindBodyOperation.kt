// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** One edit to a linking annotation's body list: add or remove a body item, or replace an existing one. */
@Serializable
@JsonIgnoreUnknownKeys
public data class BindBodyOperation(
    /** The type of body operation */
    public val op: BindBodyOperationOp,
    public val item: AnnotationBody? = null,
    public val oldItem: AnnotationBody? = null,
    public val newItem: AnnotationBody? = null,
) {
    /** How Java makes a `BindBodyOperation`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val op: BindBodyOperationOp,
    ) {
        private var item: AnnotationBody? = null
        private var oldItem: AnnotationBody? = null
        private var newItem: AnnotationBody? = null

        public fun item(item: AnnotationBody?): Builder = apply { this.item = item }
        public fun oldItem(oldItem: AnnotationBody?): Builder = apply { this.oldItem = oldItem }
        public fun newItem(newItem: AnnotationBody?): Builder = apply { this.newItem = newItem }

        public fun build(): BindBodyOperation = BindBodyOperation(op = op, item = item, oldItem = oldItem, newItem = newItem)
    }

    public companion object {
        /** A builder of a `BindBodyOperation` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(op: BindBodyOperationOp): Builder = Builder(op)
    }
}
