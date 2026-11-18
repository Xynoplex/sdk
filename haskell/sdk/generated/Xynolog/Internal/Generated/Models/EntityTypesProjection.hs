-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.EntityTypesProjection (EntityTypesProjection (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data EntityTypesProjection = EntityTypesProjection
  { entityTypesProjectionEntityTypes :: [Text]
  }
  deriving (Eq, Show)

instance FromJSON EntityTypesProjection where parseJSON = checked "EntityTypesProjection" $ withObject "EntityTypesProjection" (\fields -> EntityTypesProjection <$> (fields .: "entityTypes"))

instance ToJSON EntityTypesProjection where toJSON value = Object (KM.fromList (concat [[("entityTypes", toJSON (entityTypesProjectionEntityTypes value))]]))
