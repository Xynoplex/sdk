-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.EntityTagChangedPayload
  ( EntityTagChangedPayload(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data EntityTagChangedPayload = EntityTagChangedPayload { entityTagChangedPayloadEntityType :: Text, entityTagChangedPayloadAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON EntityTagChangedPayload where
  parseJSON = checked "EntityTagChangedPayload" $ withObject "EntityTagChangedPayload" (\fields -> EntityTagChangedPayload <$> fields .: "entityType" <*> traverse parseJSON (withoutFields ["entityType"] fields))
instance ToJSON EntityTagChangedPayload where toJSON value = Object (KM.fromList (concat [[("entityType", toJSON (entityTagChangedPayloadEntityType value))]]) <> fmap toJSON (withoutFields ["entityType"] (entityTagChangedPayloadAdditionalProperties value)))
