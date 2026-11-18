// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The engine for `mark` jobs of each motivation. */
@Serializable
public data class ArchivistEnginesJobsMark(
    public val highlighting: Engine? = null,
    public val commenting: Engine? = null,
    public val assessing: Engine? = null,
    public val linking: Engine? = null,
    public val tagging: Engine? = null,
) {
    /** How Java makes a `ArchivistEnginesJobsMark`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var highlighting: Engine? = null
        private var commenting: Engine? = null
        private var assessing: Engine? = null
        private var linking: Engine? = null
        private var tagging: Engine? = null

        public fun highlighting(highlighting: Engine?): Builder = apply { this.highlighting = highlighting }
        public fun commenting(commenting: Engine?): Builder = apply { this.commenting = commenting }
        public fun assessing(assessing: Engine?): Builder = apply { this.assessing = assessing }
        public fun linking(linking: Engine?): Builder = apply { this.linking = linking }
        public fun tagging(tagging: Engine?): Builder = apply { this.tagging = tagging }

        public fun build(): ArchivistEnginesJobsMark = ArchivistEnginesJobsMark(highlighting = highlighting, commenting = commenting, assessing = assessing, linking = linking, tagging = tagging)
    }

    public companion object {
        /** A builder of a `ArchivistEnginesJobsMark` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
