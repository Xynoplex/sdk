// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** The id of the resource an upload created. The Archivist answers it (200) once it has stored the bytes and recorded the resource, and the gateway forwards it (202), so the id is the one the record minted and its creation event is persisted. What remains asynchronous is downstream projection: graph, views and vectors settle afterwards. */
@Serializable
@JsonIgnoreUnknownKeys
public data class CreateResourceResponse(
    /** The id of the newly created resource, as the record minted it. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `CreateResourceResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        public fun build(): CreateResourceResponse = CreateResourceResponse(resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `CreateResourceResponse` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
