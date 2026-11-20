-- Generated from sdk-telemetry/telemetry.json; do not edit.
-- Regenerate: make generate (codegen/lib/telemetry/telemetry.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.TelemetryKeys (attributeBusChannel, attributeBusScope, attributeContentFormat, attributeContentSizeBytes, attributeContentStream, attributeResourceId, attributeThreadId) where

import Data.Text (Text)

attributeBusChannel :: Text
attributeBusChannel = "bus.channel"

attributeBusScope :: Text
attributeBusScope = "bus.scope"

attributeContentFormat :: Text
attributeContentFormat = "content.format"

attributeContentSizeBytes :: Text
attributeContentSizeBytes = "content.size_bytes"

attributeContentStream :: Text
attributeContentStream = "content.stream"

attributeResourceId :: Text
attributeResourceId = "resource.id"

attributeThreadId :: Text
attributeThreadId = "thread.id"
