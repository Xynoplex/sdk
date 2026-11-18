-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.EphemeralEventId (EphemeralEventId (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..))
import Data.Text (Text)
import Xynolog.Internal.Codec

newtype EphemeralEventId = EphemeralEventId {ephemeralEventIdValue :: Text} deriving (Eq, Show)

instance FromJSON EphemeralEventId where parseJSON = checked "EphemeralEventId" $ \value -> EphemeralEventId <$> parseJSON value

instance ToJSON EphemeralEventId where toJSON (EphemeralEventId value) = toJSON value
