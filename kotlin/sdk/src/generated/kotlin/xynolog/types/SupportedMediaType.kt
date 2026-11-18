// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * Base MIME types (no parameters) admitted by Xynolog. Membership is the create/yield gate — every member is storable, nameable, and uploadable. What more the system can do with a type (render, annotate, extract text, author) is curated per type in @xynolog/core's media-type registry, which is keyed by this enum.
 */
@Serializable
public enum class SupportedMediaType(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("text/plain")
    TextPlain("text/plain"),

    @SerialName("text/markdown")
    TextMarkdown("text/markdown"),

    @SerialName("text/html")
    TextHtml("text/html"),

    @SerialName("text/css")
    TextCss("text/css"),

    @SerialName("text/csv")
    TextCsv("text/csv"),

    @SerialName("text/xml")
    TextXml("text/xml"),

    @SerialName("application/json")
    ApplicationJson("application/json"),

    @SerialName("application/xml")
    ApplicationXml("application/xml"),

    @SerialName("application/yaml")
    ApplicationYaml("application/yaml"),

    @SerialName("application/x-yaml")
    ApplicationXYaml("application/x-yaml"),

    @SerialName("application/pdf")
    ApplicationPdf("application/pdf"),

    @SerialName("application/msword")
    ApplicationMsword("application/msword"),

    @SerialName("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    ApplicationVndOpenxmlformatsOfficedocumentWordprocessingmlDocument("application/vnd.openxmlformats-officedocument.wordprocessingml.document"),

    @SerialName("application/vnd.ms-excel")
    ApplicationVndMsExcel("application/vnd.ms-excel"),

    @SerialName("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
    ApplicationVndOpenxmlformatsOfficedocumentSpreadsheetmlSheet("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"),

    @SerialName("application/vnd.ms-powerpoint")
    ApplicationVndMsPowerpoint("application/vnd.ms-powerpoint"),

    @SerialName("application/vnd.openxmlformats-officedocument.presentationml.presentation")
    ApplicationVndOpenxmlformatsOfficedocumentPresentationmlPresentation("application/vnd.openxmlformats-officedocument.presentationml.presentation"),

    @SerialName("application/zip")
    ApplicationZip("application/zip"),

    @SerialName("application/gzip")
    ApplicationGzip("application/gzip"),

    @SerialName("application/x-tar")
    ApplicationXTar("application/x-tar"),

    @SerialName("application/x-7z-compressed")
    ApplicationX7zCompressed("application/x-7z-compressed"),

    @SerialName("application/octet-stream")
    ApplicationOctetStream("application/octet-stream"),

    @SerialName("application/wasm")
    ApplicationWasm("application/wasm"),

    @SerialName("image/png")
    ImagePng("image/png"),

    @SerialName("image/jpeg")
    ImageJpeg("image/jpeg"),

    @SerialName("image/gif")
    ImageGif("image/gif"),

    @SerialName("image/webp")
    ImageWebp("image/webp"),

    @SerialName("image/svg+xml")
    ImageSvgPlusXml("image/svg+xml"),

    @SerialName("image/bmp")
    ImageBmp("image/bmp"),

    @SerialName("image/tiff")
    ImageTiff("image/tiff"),

    @SerialName("image/x-icon")
    ImageXIcon("image/x-icon"),

    @SerialName("video/mp4")
    VideoMp4("video/mp4"),

    @SerialName("video/mpeg")
    VideoMpeg("video/mpeg"),

    @SerialName("video/webm")
    VideoWebm("video/webm"),

    @SerialName("video/ogg")
    VideoOgg("video/ogg"),

    @SerialName("video/quicktime")
    VideoQuicktime("video/quicktime"),

    @SerialName("video/x-msvideo")
    VideoXMsvideo("video/x-msvideo"),

    @SerialName("audio/mpeg")
    AudioMpeg("audio/mpeg"),

    @SerialName("audio/wav")
    AudioWav("audio/wav"),

    @SerialName("audio/ogg")
    AudioOgg("audio/ogg"),

    @SerialName("audio/webm")
    AudioWebm("audio/webm"),

    @SerialName("audio/aac")
    AudioAac("audio/aac"),

    @SerialName("audio/flac")
    AudioFlac("audio/flac"),

    @SerialName("text/javascript")
    TextJavascript("text/javascript"),

    @SerialName("application/javascript")
    ApplicationJavascript("application/javascript"),

    @SerialName("text/x-typescript")
    TextXTypescript("text/x-typescript"),

    @SerialName("application/typescript")
    ApplicationTypescript("application/typescript"),

    @SerialName("text/x-python")
    TextXPython("text/x-python"),

    @SerialName("text/x-java")
    TextXJava("text/x-java"),

    @SerialName("text/x-c")
    TextXC("text/x-c"),

    @SerialName("text/x-c++")
    TextXCPlusPlus("text/x-c++"),

    @SerialName("text/x-csharp")
    TextXCsharp("text/x-csharp"),

    @SerialName("text/x-go")
    TextXGo("text/x-go"),

    @SerialName("text/x-rust")
    TextXRust("text/x-rust"),

    @SerialName("text/x-ruby")
    TextXRuby("text/x-ruby"),

    @SerialName("text/x-php")
    TextXPhp("text/x-php"),

    @SerialName("text/x-swift")
    TextXSwift("text/x-swift"),

    @SerialName("text/x-kotlin")
    TextXKotlin("text/x-kotlin"),

    @SerialName("text/x-shell")
    TextXShell("text/x-shell"),

    @SerialName("font/woff")
    FontWoff("font/woff"),

    @SerialName("font/woff2")
    FontWoff2("font/woff2"),

    @SerialName("font/ttf")
    FontTtf("font/ttf"),

    @SerialName("font/otf")
    FontOtf("font/otf"),
}
