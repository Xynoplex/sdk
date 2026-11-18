-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.ContextualSummaryResponseBusEnvelope (ContextualSummaryResponseBusEnvelope (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ContextualSummaryResponse

data ContextualSummaryResponseBusEnvelope = ContextualSummaryResponseBusEnvelope
  { contextualSummaryResponseBusEnvelopeResponse :: ContextualSummaryResponse
  }
  deriving (Eq, Show)

instance FromJSON ContextualSummaryResponseBusEnvelope where parseJSON = checked "ContextualSummaryResponseBusEnvelope" $ withObject "ContextualSummaryResponseBusEnvelope" (\fields -> ContextualSummaryResponseBusEnvelope <$> (fields .: "response"))

instance ToJSON ContextualSummaryResponseBusEnvelope where toJSON value = Object (KM.fromList (concat [[("response", toJSON (contextualSummaryResponseBusEnvelopeResponse value))]]))
