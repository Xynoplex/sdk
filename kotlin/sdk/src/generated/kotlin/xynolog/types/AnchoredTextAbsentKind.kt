// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/**
 * Discriminant, sharing the `kind` field with the ExtractedText/ExtractionDeclined members so the whole answer is one flat union.
 *
 * `not-yet` — the resource's media type has text that is derived by reading its content, and the store holds no entry for this content: the Smelter has not read it yet, or the entry was lost (a loss the Smelter's reconcile pass re-derives). RETRY.
 *
 * `no-map` — the resource's media type has no derived text, so no entry exists and none will until the type is given a reader. Decided by the media type alone, and answered at once. TERMINAL.
 *
 * `unknown` — no content identity to look up: the resource is not in the view store, or its primary representation carries no checksum. TERMINAL.
 */
@Serializable
public enum class AnchoredTextAbsentKind(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("not-yet")
    NotYet("not-yet"),

    @SerialName("no-map")
    NoMap("no-map"),

    @SerialName("unknown")
    Unknown("unknown"),
}
