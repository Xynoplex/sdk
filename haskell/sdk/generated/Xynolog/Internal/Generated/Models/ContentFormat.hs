-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.ContentFormat (ContentFormat(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..))
import Data.Text (Text)
import Xynolog.Internal.Codec
newtype ContentFormat = ContentFormat { contentFormatValue :: Text } deriving (Eq, Show)
instance FromJSON ContentFormat where parseJSON = checked "ContentFormat" $ \value -> ContentFormat <$> parseJSON value
instance ToJSON ContentFormat where toJSON (ContentFormat value) = toJSON value
