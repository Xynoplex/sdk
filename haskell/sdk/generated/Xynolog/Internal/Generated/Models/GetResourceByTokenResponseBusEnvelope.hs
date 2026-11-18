-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.GetResourceByTokenResponseBusEnvelope (GetResourceByTokenResponseBusEnvelope (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.GetResourceByTokenResponse

data GetResourceByTokenResponseBusEnvelope = GetResourceByTokenResponseBusEnvelope
  { getResourceByTokenResponseBusEnvelopeResponse :: GetResourceByTokenResponse
  }
  deriving (Eq, Show)

instance FromJSON GetResourceByTokenResponseBusEnvelope where parseJSON = checked "GetResourceByTokenResponseBusEnvelope" $ withObject "GetResourceByTokenResponseBusEnvelope" (\fields -> GetResourceByTokenResponseBusEnvelope <$> (fields .: "response"))

instance ToJSON GetResourceByTokenResponseBusEnvelope where toJSON value = Object (KM.fromList (concat [[("response", toJSON (getResourceByTokenResponseBusEnvelopeResponse value))]]))
