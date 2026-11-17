-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.EmitOnBusHeader0 (EmitOnBusHeader0(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..))
import Data.Text (Text)
import Xynolog.Internal.Codec
newtype EmitOnBusHeader0 = EmitOnBusHeader0 { emitOnBusHeader0Value :: Text } deriving (Eq, Show)
instance FromJSON EmitOnBusHeader0 where parseJSON = checked "EmitOnBusHeader0" $ \value -> EmitOnBusHeader0 <$> parseJSON value
instance ToJSON EmitOnBusHeader0 where toJSON (EmitOnBusHeader0 value) = toJSON value
