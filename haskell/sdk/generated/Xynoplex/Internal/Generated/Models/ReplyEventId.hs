-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.ReplyEventId
  ( ReplyEventId(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
newtype ReplyEventId = ReplyEventId { replyEventIdValue :: Text } deriving (Eq, Show)
instance FromJSON ReplyEventId where
  parseJSON = checked "ReplyEventId" $ \value -> ReplyEventId <$> parseJSON value
instance ToJSON ReplyEventId where toJSON (ReplyEventId value) = toJSON value
