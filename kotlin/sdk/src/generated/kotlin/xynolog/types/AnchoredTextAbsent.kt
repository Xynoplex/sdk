// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/**
 * There is no coordinate map to serve, and WHY — the distinction a bare null could not carry.
 *
 * One member covers all three absences because none carries a payload; `kind` alone is the fact. Retryability is legible from the name, deliberately: a caller must not need a lookup table to decide whether to come back.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class AnchoredTextAbsent(
    /**
     * Discriminant, sharing the `kind` field with the ExtractedText/ExtractionDeclined members so the whole answer is one flat union.
     *
     * `not-yet` — the resource's media type has text that is derived by reading its content, and the store holds no entry for this content: the Smelter has not read it yet, or the entry was lost (a loss the Smelter's reconcile pass re-derives). RETRY.
     *
     * `no-map` — the resource's media type has no derived text, so no entry exists and none will until the type is given a reader. Decided by the media type alone, and answered at once. TERMINAL.
     *
     * `unknown` — no content identity to look up: the resource is not in the view store, or its primary representation carries no checksum. TERMINAL.
     */
    public val kind: AnchoredTextAbsentKind,
) : AnchoredTextAnswer {
    /** How Java makes a `AnchoredTextAbsent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kind: AnchoredTextAbsentKind,
    ) {
        public fun build(): AnchoredTextAbsent = AnchoredTextAbsent(kind = kind)
    }

    public companion object {
        /** A builder of a `AnchoredTextAbsent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kind: AnchoredTextAbsentKind): Builder = Builder(kind)
    }
}
