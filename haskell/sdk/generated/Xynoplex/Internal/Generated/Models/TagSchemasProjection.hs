-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.TagSchemasProjection
  ( TagSchemasProjection(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.TagSchema
data TagSchemasProjection = TagSchemasProjection { tagSchemasProjectionTagSchemas :: [TagSchema] } deriving (Eq, Show)
instance FromJSON TagSchemasProjection where
  parseJSON = checked "TagSchemasProjection" $ withObject "TagSchemasProjection" (\fields -> TagSchemasProjection <$> fields .: "tagSchemas")
instance ToJSON TagSchemasProjection where toJSON value = Object (KM.fromList (concat [[("tagSchemas", toJSON (tagSchemasProjectionTagSchemas value))]]))
