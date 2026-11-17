// Code generated from protocol/specs/src/sdk-telemetry/telemetry.json — DO NOT EDIT.
//
// Regenerate: make generate (codegen/lib/telemetry/telemetry.ml)
// The Python table is generated from the same table.

package xynolog

import (
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/trace"
)

// telemetryChannel stands for the bus channel in a span's name.
const telemetryChannel = "{channel}"

// A frame the client sent, in the trace of the work that sent it.
var spanBusEmit = telemetrySpan{name: "bus.emit:{channel}", kind: trace.SpanKindProducer}

// A frame the client received, and the work done for it, in the trace the
// frame was sent under.
var spanBusRecv = telemetrySpan{name: "bus.recv:{channel}", kind: trace.SpanKindConsumer}

// An upload.
var spanContentPut = telemetrySpan{name: "content.put", kind: trace.SpanKindClient}

// A read of a resource's bytes.
var spanContentGet = telemetrySpan{name: "content.get", kind: trace.SpanKindClient}

// A read of a resource's description.
var spanContentGetGraph = telemetrySpan{name: "content.get_graph", kind: trace.SpanKindClient}

// A read of a resource's anchored text.
var spanContentGetAnchoredText = telemetrySpan{name: "content.get_anchored_text", kind: trace.SpanKindClient}

// A read of a resource's annotations.
var spanContentGetAnnotations = telemetrySpan{name: "content.get_annotations", kind: trace.SpanKindClient}

// Emits the client sent. A counter.
var metricXynologBusSent = telemetryMetric{name: "xynolog.bus.sent", meaning: "Emits the client sent."}

// The attributes the rows carry.

const keyBusChannel attribute.Key = "bus.channel"
const keyBusScope attribute.Key = "bus.scope"
const keyContentFormat attribute.Key = "content.format"
const keyContentSizeBytes attribute.Key = "content.size_bytes"
const keyContentStream attribute.Key = "content.stream"
const keyResourceID attribute.Key = "resource.id"
const keyThreadID attribute.Key = "thread.id"
