// Generated from protocol/specs/src/sdk-telemetry/telemetry.json; do not edit.
// Regenerate: make generate (codegen/lib/telemetry/kotlin.ml)

package xynolog.telemetry

import io.opentelemetry.api.trace.SpanKind

/** The telemetry a Xynolog SDK's transports export (protocol/specs/src/sdk-telemetry/telemetry.json). A span's name may hold `{channel}`, the bus channel. */
internal object TelemetryTable {
    /**
     * A frame the client sent, in the trace of the work that sent it.
     */
    val BUS_EMIT: SpanRow = SpanRow("bus.emit:{channel}", SpanKind.PRODUCER)

    /**
     * A frame the client received, and the work done for it, in the trace the frame was sent under.
     */
    val BUS_RECV: SpanRow = SpanRow("bus.recv:{channel}", SpanKind.CONSUMER)

    /**
     * An upload.
     */
    val CONTENT_PUT: SpanRow = SpanRow("content.put", SpanKind.CLIENT)

    /**
     * A read of a resource's bytes.
     */
    val CONTENT_GET: SpanRow = SpanRow("content.get", SpanKind.CLIENT)

    /**
     * A read of a resource's description.
     */
    val CONTENT_GET_GRAPH: SpanRow = SpanRow("content.get_graph", SpanKind.CLIENT)

    /**
     * A read of a resource's anchored text.
     */
    val CONTENT_GET_ANCHORED_TEXT: SpanRow = SpanRow("content.get_anchored_text", SpanKind.CLIENT)

    /**
     * A read of a resource's annotations.
     */
    val CONTENT_GET_ANNOTATIONS: SpanRow = SpanRow("content.get_annotations", SpanKind.CLIENT)

    /**
     * Emits the client sent.
     */
    val XYNOLOG_BUS_SENT: MetricRow = MetricRow("xynolog.bus.sent", "Emits the client sent.")
}

/**
 * An attribute key a row of the telemetry table lists.
 */
internal const val ATTR_BUS_CHANNEL: String = "bus.channel"

/**
 * An attribute key a row of the telemetry table lists.
 */
internal const val ATTR_BUS_SCOPE: String = "bus.scope"

/**
 * An attribute key a row of the telemetry table lists.
 */
internal const val ATTR_CONTENT_FORMAT: String = "content.format"

/**
 * An attribute key a row of the telemetry table lists.
 */
internal const val ATTR_CONTENT_SIZE_BYTES: String = "content.size_bytes"

/**
 * An attribute key a row of the telemetry table lists.
 */
internal const val ATTR_CONTENT_STREAM: String = "content.stream"

/**
 * An attribute key a row of the telemetry table lists.
 */
internal const val ATTR_RESOURCE_ID: String = "resource.id"

/**
 * An attribute key a row of the telemetry table lists.
 */
internal const val ATTR_THREAD_ID: String = "thread.id"
