-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.UploadResourceHeader0 (UploadResourceHeader0(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..))
import Data.Text (Text)
import Xynolog.Internal.Codec
newtype UploadResourceHeader0 = UploadResourceHeader0 { uploadResourceHeader0Value :: Text } deriving (Eq, Show)
instance FromJSON UploadResourceHeader0 where parseJSON = checked "UploadResourceHeader0" $ \value -> UploadResourceHeader0 <$> parseJSON value
instance ToJSON UploadResourceHeader0 where toJSON (UploadResourceHeader0 value) = toJSON value
