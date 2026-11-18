// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** Raw annotation creation intent — bus handler assembles the W3C annotation */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkCreateRequest(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    public val request: CreateAnnotationRequest,
) {
    /** How Java makes a `MarkCreateRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val request: CreateAnnotationRequest,
    ) {
        public fun build(): MarkCreateRequest = MarkCreateRequest(resourceId = resourceId, request = request)
    }

    public companion object {
        /** A builder of a `MarkCreateRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, request: CreateAnnotationRequest): Builder = Builder(resourceId, request)
    }
}
