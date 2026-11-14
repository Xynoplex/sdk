-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.TraceCarrier
  ( TraceCarrier(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data TraceCarrier = TraceCarrier { traceCarrierTraceparent :: Text, traceCarrierTracestate :: Maybe (Text) } deriving (Eq, Show)
instance FromJSON TraceCarrier where
  parseJSON = checked "TraceCarrier" $ withObject "TraceCarrier" (\fields -> TraceCarrier <$> fields .: "traceparent" <*> optional fields "tracestate")
instance ToJSON TraceCarrier where toJSON value = Object (KM.fromList (concat [[("traceparent", toJSON (traceCarrierTraceparent value))], optionalPair "tracestate" (traceCarrierTracestate value)]))
