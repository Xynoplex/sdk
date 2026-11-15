-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.HealthResponse
  ( HealthResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data HealthResponse = HealthResponse { healthResponseMessage :: Text, healthResponseStatus :: Text, healthResponseTimestamp :: Text, healthResponseVersion :: Text, healthResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON HealthResponse where
  parseJSON = checked "HealthResponse" $ withObject "HealthResponse" (\fields -> HealthResponse <$> fields .: "message" <*> fields .: "status" <*> fields .: "timestamp" <*> fields .: "version" <*> traverse parseJSON (withoutFields ["message", "status", "timestamp", "version"] fields))
instance ToJSON HealthResponse where toJSON value = Object (KM.fromList (concat [[("message", toJSON (healthResponseMessage value))], [("status", toJSON (healthResponseStatus value))], [("timestamp", toJSON (healthResponseTimestamp value))], [("version", toJSON (healthResponseVersion value))]]) <> fmap toJSON (withoutFields ["message", "status", "timestamp", "version"] (healthResponseAdditionalProperties value)))
