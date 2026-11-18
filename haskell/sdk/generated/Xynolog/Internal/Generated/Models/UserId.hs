-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.UserId (UserId, userIdValue, mkUserId) where

import Data.Aeson (FromJSON (..), ToJSON (..))
import Data.Aeson.Types (parseEither)
import Data.Text (Text)
import Xynolog.Internal.Codec

newtype UserId = UserId Text deriving (Eq, Ord, Show)

instance FromJSON UserId where parseJSON = checked "UserId" $ \value -> UserId <$> parseJSON value

instance ToJSON UserId where toJSON (UserId value) = toJSON value

userIdValue :: UserId -> Text
userIdValue (UserId value) = value

mkUserId :: Text -> Either String UserId
mkUserId value = parseEither parseJSON (toJSON value)
