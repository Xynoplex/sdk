-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.UserId
  ( UserId, userIdValue, mkUserId
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
newtype UserId = UserId (Text) deriving (Eq, Ord, Show)
instance FromJSON UserId where
  parseJSON = checked "UserId" $ \value -> UserId <$> parseJSON value
instance ToJSON UserId where toJSON (UserId value) = toJSON value
userIdValue :: UserId -> Text
userIdValue (UserId value) = value
mkUserId :: Text -> Either String UserId
mkUserId value = parseEither parseJSON (toJSON value)
