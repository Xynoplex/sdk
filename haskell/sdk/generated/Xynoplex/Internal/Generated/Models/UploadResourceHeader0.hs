-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.UploadResourceHeader0
  ( UploadResourceHeader0(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
newtype UploadResourceHeader0 = UploadResourceHeader0 { uploadResourceHeader0Value :: Text } deriving (Eq, Show)
instance FromJSON UploadResourceHeader0 where
  parseJSON = checked "UploadResourceHeader0" $ \value -> UploadResourceHeader0 <$> parseJSON value
instance ToJSON UploadResourceHeader0 where toJSON (UploadResourceHeader0 value) = toJSON value
