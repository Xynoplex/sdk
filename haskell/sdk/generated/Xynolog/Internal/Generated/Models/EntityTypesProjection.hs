-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.EntityTypesProjection
  ( EntityTypesProjection(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data EntityTypesProjection = EntityTypesProjection { entityTypesProjectionEntityTypes :: [Text] } deriving (Eq, Show)
instance FromJSON EntityTypesProjection where
  parseJSON = checked "EntityTypesProjection" $ withObject "EntityTypesProjection" (\fields -> EntityTypesProjection <$> fields .: "entityTypes")
instance ToJSON EntityTypesProjection where toJSON value = Object (KM.fromList (concat [[("entityTypes", toJSON (entityTypesProjectionEntityTypes value))]]))
