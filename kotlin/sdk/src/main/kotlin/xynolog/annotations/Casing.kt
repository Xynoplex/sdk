package xynolog.annotations

/*
 * Whether a code point is cased, and whether it is case-ignorable, as Unicode's
 * Cased and Case_Ignorable properties have it, which the JDK gives neither of.
 * The ranges are UnicodeCase.kt's, which codegen/lib/unicode_case writes from
 * Unicode's DerivedCoreProperties.txt.
 */

/** Whether a code point is cased, as Unicode's Cased property has it. */
internal fun cased(point: Int): Boolean = within(point, CASED_FIRSTS, CASED_LASTS)

/** Whether a code point is case-ignorable, as Unicode's Case_Ignorable property has it. */
internal fun caseIgnorable(point: Int): Boolean = within(point, CASE_IGNORABLE_FIRSTS, CASE_IGNORABLE_LASTS)

private fun within(point: Int, firsts: IntArray, lasts: IntArray): Boolean {
    val at = lasts.binarySearch(point)
    if (at >= 0) return true
    val next = -at - 1
    return next < firsts.size && firsts[next] <= point
}
