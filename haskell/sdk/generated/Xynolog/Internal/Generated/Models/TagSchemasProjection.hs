-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.TagSchemasProjection (TagSchemasProjection(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.TagSchema
data TagSchemasProjection = TagSchemasProjection
  { tagSchemasProjectionTagSchemas :: [TagSchema]
  } deriving (Eq, Show)
instance FromJSON TagSchemasProjection where parseJSON = checked "TagSchemasProjection" $ withObject "TagSchemasProjection" (\fields -> TagSchemasProjection <$> (fields .: "tagSchemas"))
instance ToJSON TagSchemasProjection where toJSON value = Object (KM.fromList (concat [[("tagSchemas", toJSON (tagSchemasProjectionTagSchemas value))]]))
