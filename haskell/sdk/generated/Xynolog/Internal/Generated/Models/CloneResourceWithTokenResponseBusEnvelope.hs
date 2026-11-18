-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.CloneResourceWithTokenResponseBusEnvelope (CloneResourceWithTokenResponseBusEnvelope (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.CloneResourceWithTokenResponse

data CloneResourceWithTokenResponseBusEnvelope = CloneResourceWithTokenResponseBusEnvelope
  { cloneResourceWithTokenResponseBusEnvelopeResponse :: CloneResourceWithTokenResponse
  }
  deriving (Eq, Show)

instance FromJSON CloneResourceWithTokenResponseBusEnvelope where parseJSON = checked "CloneResourceWithTokenResponseBusEnvelope" $ withObject "CloneResourceWithTokenResponseBusEnvelope" (\fields -> CloneResourceWithTokenResponseBusEnvelope <$> (fields .: "response"))

instance ToJSON CloneResourceWithTokenResponseBusEnvelope where toJSON value = Object (KM.fromList (concat [[("response", toJSON (cloneResourceWithTokenResponseBusEnvelopeResponse value))]]))
