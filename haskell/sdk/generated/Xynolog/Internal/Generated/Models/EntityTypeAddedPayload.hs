-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.EntityTypeAddedPayload (EntityTypeAddedPayload (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data EntityTypeAddedPayload = EntityTypeAddedPayload
  { entityTypeAddedPayloadEntityType :: Text,
    entityTypeAddedPayloadAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON EntityTypeAddedPayload where parseJSON = checked "EntityTypeAddedPayload" $ withObject "EntityTypeAddedPayload" (\fields -> EntityTypeAddedPayload <$> (fields .: "entityType") <*> traverse parseJSON (withoutFields ["entityType"] fields))

instance ToJSON EntityTypeAddedPayload where toJSON value = Object (KM.fromList (concat [[("entityType", toJSON (entityTypeAddedPayloadEntityType value))]]) <> fmap toJSON (withoutFields ["entityType"] (entityTypeAddedPayloadAdditionalProperties value)))
