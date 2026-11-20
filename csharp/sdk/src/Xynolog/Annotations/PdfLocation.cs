using Xynolog.Types;

namespace Xynolog.Annotations;

internal static class PdfLocation
{
    internal static string Fragment(PdfCoordinate rectangle) =>
        FormattableString.Invariant($"page={rectangle.Page}&viewrect={rectangle.X},{rectangle.Y},{rectangle.Width},{rectangle.Height}");

    internal static (IReadOnlyList<PdfTextItem> Items, IReadOnlyList<PdfCoordinate> Rectangles) Locate(AnchoredText anchored, long start, long end)
    {
        if (start == end) return ([], []);
        var items = anchored.Items.Where(item => item.Start < end && item.End > start).ToArray();
        var rectangles = new List<PdfCoordinate>();
        foreach (var page in items.GroupBy(item => item.Page))
        {
            var line = new List<PdfTextItem>();
            foreach (var item in page.OrderByDescending(item => item.Y).ThenBy(item => item.X))
            {
                if (line.Count > 0 && Math.Abs(item.Y - line[0].Y) > 2)
                {
                    rectangles.Add(RectangleOf(line, start, end));
                    line.Clear();
                }
                line.Add(item);
            }
            rectangles.Add(RectangleOf(line, start, end));
        }
        return (items, rectangles);
    }

    private static PdfCoordinate RectangleOf(List<PdfTextItem> line, long start, long end)
    {
        var left = line.Min(item => item.Start < start ? Clip(item, start) : item.X);
        var right = line.Max(item => item.End > end ? Clip(item, end) : item.X + item.Width);
        var bottom = line.Min(item => item.Y);
        var top = line.Max(item => item.Y + item.Height);
        return new PdfCoordinate { Page = line[0].Page, X = left, Y = bottom, Width = right - left, Height = top - bottom };
    }

    private static double Clip(PdfTextItem item, long position) =>
        item.X + item.Width * ((double)(position - item.Start) / (item.End - item.Start));
}
