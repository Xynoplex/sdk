-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.TagSchemaAddedPayload
  ( TagSchemaAddedPayload(..)
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
data TagSchemaAddedPayload = TagSchemaAddedPayload { tagSchemaAddedPayloadSchema :: TagSchema, tagSchemaAddedPayloadAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON TagSchemaAddedPayload where
  parseJSON = checked "TagSchemaAddedPayload" $ withObject "TagSchemaAddedPayload" (\fields -> TagSchemaAddedPayload <$> fields .: "schema" <*> traverse parseJSON (withoutFields ["schema"] fields))
instance ToJSON TagSchemaAddedPayload where toJSON value = Object (KM.fromList (concat [[("schema", toJSON (tagSchemaAddedPayloadSchema value))]]) <> fmap toJSON (withoutFields ["schema"] (tagSchemaAddedPayloadAdditionalProperties value)))
