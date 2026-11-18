// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

@Serializable
@JsonIgnoreUnknownKeys
public data class SpecificResource(
    @EncodeDefault
    public val type: SpecificResourceType = SpecificResourceType.SpecificResource,
    /** The id of the resource this body leads to */
    @get:JvmExposeBoxed
    public val source: ResourceId,
    /** Why this body is included */
    public val purpose: BodyPurpose? = null,
) : AnnotationBody,
    BodyOperationAddItem,
    BodyOperationRemoveItem,
    BodyOperationReplaceNewItem,
    BodyOperationReplaceOldItem {
    /** How Java makes a `SpecificResource`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val source: ResourceId,
    ) {
        private var purpose: BodyPurpose? = null

        public fun purpose(purpose: BodyPurpose?): Builder = apply { this.purpose = purpose }

        public fun build(): SpecificResource = SpecificResource(source = source, purpose = purpose)
    }

    public companion object {
        /** A builder of a `SpecificResource` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(source: ResourceId): Builder = Builder(source)
    }
}
