// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Void success reply emitted on the bind:body-updated channel after bind:update-body has been applied, matched to the originating command by correlationId. */
@Serializable
@JsonIgnoreUnknownKeys
public data object BindBodyUpdated
