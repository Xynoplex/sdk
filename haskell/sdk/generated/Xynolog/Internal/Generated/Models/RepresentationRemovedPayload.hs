-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.RepresentationRemovedPayload (RepresentationRemovedPayload (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data RepresentationRemovedPayload = RepresentationRemovedPayload
  { representationRemovedPayloadChecksum :: Text,
    representationRemovedPayloadAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON RepresentationRemovedPayload where parseJSON = checked "RepresentationRemovedPayload" $ withObject "RepresentationRemovedPayload" (\fields -> RepresentationRemovedPayload <$> (fields .: "checksum") <*> traverse parseJSON (withoutFields ["checksum"] fields))

instance ToJSON RepresentationRemovedPayload where toJSON value = Object (KM.fromList (concat [[("checksum", toJSON (representationRemovedPayloadChecksum value))]]) <> fmap toJSON (withoutFields ["checksum"] (representationRemovedPayloadAdditionalProperties value)))
