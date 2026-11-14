-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.GetResourceByTokenResponseBusEnvelope
  ( GetResourceByTokenResponseBusEnvelope(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.GetResourceByTokenResponse
data GetResourceByTokenResponseBusEnvelope = GetResourceByTokenResponseBusEnvelope { getResourceByTokenResponseBusEnvelopeResponse :: GetResourceByTokenResponse } deriving (Eq, Show)
instance FromJSON GetResourceByTokenResponseBusEnvelope where
  parseJSON = checked "GetResourceByTokenResponseBusEnvelope" $ withObject "GetResourceByTokenResponseBusEnvelope" (\fields -> GetResourceByTokenResponseBusEnvelope <$> fields .: "response")
instance ToJSON GetResourceByTokenResponseBusEnvelope where toJSON value = Object (KM.fromList (concat [[("response", toJSON (getResourceByTokenResponseBusEnvelopeResponse value))]]))
