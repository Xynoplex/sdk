-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.ReplyEventId (ReplyEventId (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..))
import Data.Text (Text)
import Xynolog.Internal.Codec

newtype ReplyEventId = ReplyEventId {replyEventIdValue :: Text} deriving (Eq, Show)

instance FromJSON ReplyEventId where parseJSON = checked "ReplyEventId" $ \value -> ReplyEventId <$> parseJSON value

instance ToJSON ReplyEventId where toJSON (ReplyEventId value) = toJSON value
