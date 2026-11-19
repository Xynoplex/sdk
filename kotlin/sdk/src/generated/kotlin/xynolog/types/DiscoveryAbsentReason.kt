// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

/** Why a client that read a launcher's discovery document found no launcher. */
public enum class DiscoveryAbsentReason(
    /** The reason as every SDK spells it. */
    public val value: String,
) {
    /** There is no document where it was looked for: no file, an HTTP status that is not success, or a page that is not JSON. */
    NotFound("not-found"),

    /** There is a document, and it is not JSON. */
    NotJson("not-json"),

    /** It is JSON, and not a discovery document: one entry that is not what the schema says makes the whole document invalid, since a partial reading would hide a running knowledge base without a trace. */
    Invalid("invalid"),

    /** It is a discovery document of a version this client does not speak, and is not read in part. */
    UnsupportedVersion("unsupported-version"),

    /** It could not be read at all: the file could not be opened or decoded, or the request got no answer by its deadline. */
    Unreadable("unreadable"),
}
