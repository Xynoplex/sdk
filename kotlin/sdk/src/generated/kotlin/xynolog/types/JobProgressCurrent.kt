// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** What the run is working on right now. `kind` is a CODE the client renders a localized name for; `value` is KB data (an entity type, a tag category) shown verbatim — the same split as `requestParams`. Absent on flows that iterate nothing, such as generation. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressCurrent(
    /** What sort of thing `value` is. Adding a variant means adding client copy for it in every locale. */
    public val kind: JobProgressCurrentKind,
    /** The item itself, shown verbatim and never translated. */
    public val value: String,
) {
    /** How Java makes a `JobProgressCurrent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kind: JobProgressCurrentKind,
        private val value: String,
    ) {
        public fun build(): JobProgressCurrent = JobProgressCurrent(kind = kind, value = value)
    }

    public companion object {
        /** A builder of a `JobProgressCurrent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kind: JobProgressCurrentKind, value: String): Builder = Builder(kind, value)
    }
}
