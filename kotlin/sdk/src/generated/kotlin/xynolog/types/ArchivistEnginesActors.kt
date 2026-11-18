// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** The engine each Librarian actor that calls a model asks. */
@Serializable
public data class ArchivistEnginesActors(
    public val gatherer: Engine? = null,
    public val matcher: Engine? = null,
) {
    /** How Java makes a `ArchivistEnginesActors`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var gatherer: Engine? = null
        private var matcher: Engine? = null

        public fun gatherer(gatherer: Engine?): Builder = apply { this.gatherer = gatherer }
        public fun matcher(matcher: Engine?): Builder = apply { this.matcher = matcher }

        public fun build(): ArchivistEnginesActors = ArchivistEnginesActors(gatherer = gatherer, matcher = matcher)
    }

    public companion object {
        /** A builder of a `ArchivistEnginesActors` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
