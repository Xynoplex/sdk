-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.EphemeralEventId
  ( EphemeralEventId(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
newtype EphemeralEventId = EphemeralEventId { ephemeralEventIdValue :: Text } deriving (Eq, Show)
instance FromJSON EphemeralEventId where
  parseJSON = checked "EphemeralEventId" $ \value -> EphemeralEventId <$> parseJSON value
instance ToJSON EphemeralEventId where toJSON (EphemeralEventId value) = toJSON value
