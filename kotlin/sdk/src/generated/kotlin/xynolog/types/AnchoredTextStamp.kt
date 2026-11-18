// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** The stamp an anchored-text store's entries are taken under: which PDF reader and which OCR engine derived them. Its writer states it before it writes or lists an entry; an entry stored under another stamp is answered to no reader. */
@Serializable
public data class AnchoredTextStamp(
    /** The stamp: no white space, since it is held in a file of one line. */
    public val stamp: String,
) {
    /** How Java makes a `AnchoredTextStamp`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val stamp: String,
    ) {
        public fun build(): AnchoredTextStamp = AnchoredTextStamp(stamp = stamp)
    }

    public companion object {
        /** A builder of a `AnchoredTextStamp` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(stamp: String): Builder = Builder(stamp)
    }
}
