namespace Xynolog.Annotations;

/// <summary>Whether a code point is cased, and whether it is case-ignorable, as Unicode's Cased and Case_Ignorable
/// properties have it: .NET gives neither. The ranges are generated from Unicode's data (Generated/UnicodeCase.g.cs,
/// codegen/lib/unicode_case).</summary>
internal static partial class UnicodeCase
{
    internal static bool Cased(int point) => Within(point, CasedFirsts, CasedLasts);

    internal static bool CaseIgnorable(int point) => Within(point, CaseIgnorableFirsts, CaseIgnorableLasts);

    private static bool Within(int point, ReadOnlySpan<int> firsts, ReadOnlySpan<int> lasts)
    {
        var at = lasts.BinarySearch(point);
        if (at >= 0)
        {
            return true;
        }
        at = ~at;
        return at < firsts.Length && firsts[at] <= point;
    }
}
