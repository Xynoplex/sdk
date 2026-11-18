// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The engine each job is done with when software does it, keyed as a job description is: by `jobType`, and for `mark` by motivation. */
@Serializable
public data class ArchivistEnginesJobs(
    /** The engine for `mark` jobs of each motivation. */
    public val mark: ArchivistEnginesJobsMark? = null,
    public val yield: Engine? = null,
) {
    /** How Java makes a `ArchivistEnginesJobs`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var mark: ArchivistEnginesJobsMark? = null
        private var yield: Engine? = null

        public fun mark(mark: ArchivistEnginesJobsMark?): Builder = apply { this.mark = mark }
        public fun yield(yield: Engine?): Builder = apply { this.yield = yield }

        public fun build(): ArchivistEnginesJobs = ArchivistEnginesJobs(mark = mark, yield = yield)
    }

    public companion object {
        /** A builder of a `ArchivistEnginesJobs` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
