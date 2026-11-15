-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.EmitOnBusHeader0
  ( EmitOnBusHeader0(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
newtype EmitOnBusHeader0 = EmitOnBusHeader0 { emitOnBusHeader0Value :: Text } deriving (Eq, Show)
instance FromJSON EmitOnBusHeader0 where
  parseJSON = checked "EmitOnBusHeader0" $ \value -> EmitOnBusHeader0 <$> parseJSON value
instance ToJSON EmitOnBusHeader0 where toJSON (EmitOnBusHeader0 value) = toJSON value
