-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.ResourceMovedPayload
  ( ResourceMovedPayload(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data ResourceMovedPayload = ResourceMovedPayload { resourceMovedPayloadFromUri :: Text, resourceMovedPayloadToUri :: Text, resourceMovedPayloadAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON ResourceMovedPayload where
  parseJSON = checked "ResourceMovedPayload" $ withObject "ResourceMovedPayload" (\fields -> ResourceMovedPayload <$> fields .: "fromUri" <*> fields .: "toUri" <*> traverse parseJSON (withoutFields ["fromUri", "toUri"] fields))
instance ToJSON ResourceMovedPayload where toJSON value = Object (KM.fromList (concat [[("fromUri", toJSON (resourceMovedPayloadFromUri value))], [("toUri", toJSON (resourceMovedPayloadToUri value))]]) <> fmap toJSON (withoutFields ["fromUri", "toUri"] (resourceMovedPayloadAdditionalProperties value)))
