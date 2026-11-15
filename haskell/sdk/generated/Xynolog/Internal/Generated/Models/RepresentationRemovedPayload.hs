-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.RepresentationRemovedPayload
  ( RepresentationRemovedPayload(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data RepresentationRemovedPayload = RepresentationRemovedPayload { representationRemovedPayloadChecksum :: Text, representationRemovedPayloadAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON RepresentationRemovedPayload where
  parseJSON = checked "RepresentationRemovedPayload" $ withObject "RepresentationRemovedPayload" (\fields -> RepresentationRemovedPayload <$> fields .: "checksum" <*> traverse parseJSON (withoutFields ["checksum"] fields))
instance ToJSON RepresentationRemovedPayload where toJSON value = Object (KM.fromList (concat [[("checksum", toJSON (representationRemovedPayloadChecksum value))]]) <> fmap toJSON (withoutFields ["checksum"] (representationRemovedPayloadAdditionalProperties value)))
