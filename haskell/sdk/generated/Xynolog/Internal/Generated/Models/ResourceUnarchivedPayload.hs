-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.ResourceUnarchivedPayload (ResourceUnarchivedPayload (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject)
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data ResourceUnarchivedPayload = ResourceUnarchivedPayload
  { resourceUnarchivedPayloadAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON ResourceUnarchivedPayload where parseJSON = checked "ResourceUnarchivedPayload" $ withObject "ResourceUnarchivedPayload" (\fields -> ResourceUnarchivedPayload <$> traverse parseJSON (withoutFields [] fields))

instance ToJSON ResourceUnarchivedPayload where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (resourceUnarchivedPayloadAdditionalProperties value)))
