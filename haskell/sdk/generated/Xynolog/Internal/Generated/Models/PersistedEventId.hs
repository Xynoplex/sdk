-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.PersistedEventId (PersistedEventId (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..))
import Data.Text (Text)
import Xynolog.Internal.Codec

newtype PersistedEventId = PersistedEventId {persistedEventIdValue :: Text} deriving (Eq, Show)

instance FromJSON PersistedEventId where parseJSON = checked "PersistedEventId" $ \value -> PersistedEventId <$> parseJSON value

instance ToJSON PersistedEventId where toJSON (PersistedEventId value) = toJSON value
