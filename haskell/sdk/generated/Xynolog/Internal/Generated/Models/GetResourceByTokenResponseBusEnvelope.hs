-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.GetResourceByTokenResponseBusEnvelope
  ( GetResourceByTokenResponseBusEnvelope(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.GetResourceByTokenResponse
data GetResourceByTokenResponseBusEnvelope = GetResourceByTokenResponseBusEnvelope { getResourceByTokenResponseBusEnvelopeResponse :: GetResourceByTokenResponse } deriving (Eq, Show)
instance FromJSON GetResourceByTokenResponseBusEnvelope where
  parseJSON = checked "GetResourceByTokenResponseBusEnvelope" $ withObject "GetResourceByTokenResponseBusEnvelope" (\fields -> GetResourceByTokenResponseBusEnvelope <$> fields .: "response")
instance ToJSON GetResourceByTokenResponseBusEnvelope where toJSON value = Object (KM.fromList (concat [[("response", toJSON (getResourceByTokenResponseBusEnvelopeResponse value))]]))
