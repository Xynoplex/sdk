-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.EventMetadata (EventMetadata (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data EventMetadata = EventMetadata
  { eventMetadataSequenceNumber :: Integer,
    eventMetadataAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON EventMetadata where parseJSON = checked "EventMetadata" $ withObject "EventMetadata" (\fields -> EventMetadata <$> (fields .: "sequenceNumber") <*> traverse parseJSON (withoutFields ["sequenceNumber"] fields))

instance ToJSON EventMetadata where toJSON value = Object (KM.fromList (concat [[("sequenceNumber", toJSON (eventMetadataSequenceNumber value))]]) <> fmap toJSON (withoutFields ["sequenceNumber"] (eventMetadataAdditionalProperties value)))
