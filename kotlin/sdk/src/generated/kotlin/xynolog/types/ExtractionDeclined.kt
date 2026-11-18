// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** A named decline: extraction ran and yielded nothing, by class. A first-class, cacheable outcome — 'we ran and there was nothing' costs a full recognition pass to discover. */
@Serializable
@JsonIgnoreUnknownKeys
public data class ExtractionDeclined(
    /** Discriminant — both ExtractionOutcome members carry `kind`, single-valued: the category here, the detail in `declined`. */
    @EncodeDefault
    public val kind: ExtractionDeclinedKind = ExtractionDeclinedKind.Declined,
    /** Why extraction yielded nothing, by class. */
    public val declined: ExtractionDeclinedReason,
) : AnchoredTextAnswer,
    ExtractionOutcome {
    /** How Java makes a `ExtractionDeclined`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val declined: ExtractionDeclinedReason,
    ) {
        public fun build(): ExtractionDeclined = ExtractionDeclined(declined = declined)
    }

    public companion object {
        /** A builder of a `ExtractionDeclined` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(declined: ExtractionDeclinedReason): Builder = Builder(declined)
    }
}
