package xynolog.identifiers

/** A string that is not an id of the kind it was to be. */
public class InvalidIdentifier(
    /** The kind it was to be. */
    public val kind: String,
    /** The rule of that kind, as the spec writes it. */
    public val pattern: String,
    /** What was refused. */
    public val value: String,
) : IllegalArgumentException("\"$value\" is not a $kind: it does not match $pattern")

/** Whether a code point is whitespace as the spec's patterns read `\s`: ECMAScript's WhiteSpace and LineTerminator. */
internal fun isWhitespace(c: Int): Boolean =
    c == 0x09 || c == 0x0A || c == 0x0B || c == 0x0C || c == 0x0D || c == 0xFEFF || c == 0x2028 || c == 0x2029 ||
        Character.getType(c) == Character.SPACE_SEPARATOR.toInt()
