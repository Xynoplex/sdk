-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.ResourceUnarchivedPayload
  ( ResourceUnarchivedPayload(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data ResourceUnarchivedPayload = ResourceUnarchivedPayload { resourceUnarchivedPayloadAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON ResourceUnarchivedPayload where
  parseJSON = checked "ResourceUnarchivedPayload" $ withObject "ResourceUnarchivedPayload" (\fields -> ResourceUnarchivedPayload <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON ResourceUnarchivedPayload where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (resourceUnarchivedPayloadAdditionalProperties value)))
