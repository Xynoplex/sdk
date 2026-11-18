// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a `mark` job reports when it has done its work, whatever its motivation. */
@Serializable
public data class MarkJobDone(
    /** What the model proposed, before anything was checked against the text. */
    public val found: Long,
    /** What the log holds: the annotations committed, after the ones that could not be anchored were dropped and repeats were collapsed. */
    public val persisted: Long,
    /** How many of the proposed could not be anchored in the text. Absent means none. */
    public val errors: Long? = null,
    /** The annotations persisted per category. A tagging job's; absent from every other. */
    public val byCategory: kotlin.collections.Map<String, Long>? = null,
    /** Total floor-accepted under-reported pieces across the job's units. Absent means none — the per-unit evidence rides the terminal progress frame's completedItems; this keeps the result self-describing without the progress stream. */
    public val underReportedPieces: Long? = null,
    /** Pieces whose yield was to be checked against a count and was not: the count failed, was cut off, or answered no count. What they found was kept unchecked. Absent means none: every piece that was to be checked was. A job whose provider checks no yield has none. */
    public val uncheckedPieces: Long? = null,
) : JobResult,
    MarkJobResult {
    /** How Java makes a `MarkJobDone`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val found: Long,
        private val persisted: Long,
    ) {
        private var errors: Long? = null
        private var byCategory: kotlin.collections.Map<String, Long>? = null
        private var underReportedPieces: Long? = null
        private var uncheckedPieces: Long? = null

        public fun errors(errors: Long?): Builder = apply { this.errors = errors }
        public fun byCategory(byCategory: kotlin.collections.Map<String, Long>?): Builder = apply { this.byCategory = byCategory }
        public fun underReportedPieces(underReportedPieces: Long?): Builder = apply { this.underReportedPieces = underReportedPieces }
        public fun uncheckedPieces(uncheckedPieces: Long?): Builder = apply { this.uncheckedPieces = uncheckedPieces }

        public fun build(): MarkJobDone = MarkJobDone(found = found, persisted = persisted, errors = errors, byCategory = byCategory, underReportedPieces = underReportedPieces, uncheckedPieces = uncheckedPieces)
    }

    public companion object {
        /** A builder of a `MarkJobDone` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(found: Long, persisted: Long): Builder = Builder(found, persisted)
    }
}
