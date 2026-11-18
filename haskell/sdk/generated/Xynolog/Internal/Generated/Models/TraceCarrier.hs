-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.TraceCarrier (TraceCarrier(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data TraceCarrier = TraceCarrier
  { traceCarrierTraceparent :: Text
  , traceCarrierTracestate :: Maybe Text
  } deriving (Eq, Show)
instance FromJSON TraceCarrier where parseJSON = checked "TraceCarrier" $ withObject "TraceCarrier" (\fields -> TraceCarrier <$> (fields .: "traceparent") <*> optional fields "tracestate")
instance ToJSON TraceCarrier where toJSON value = Object (KM.fromList (concat [[("traceparent", toJSON (traceCarrierTraceparent value))], optionalPair "tracestate" (traceCarrierTracestate value)]))
