-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BusStreamMessage (BusStreamMessage(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.BusEventMessage
import Xynolog.Internal.Generated.Models.BusPingMessage
data BusStreamMessage = BusStreamMessageBranch1 BusEventMessage | BusStreamMessageBranch2 BusPingMessage deriving (Eq, Show)
instance FromJSON BusStreamMessage where parseJSON = checked "BusStreamMessage" $ \value -> (BusStreamMessageBranch1 <$> parseJSON value) <|> (BusStreamMessageBranch2 <$> parseJSON value)
instance ToJSON BusStreamMessage where
  toJSON (BusStreamMessageBranch1 value) = toJSON value
  toJSON (BusStreamMessageBranch2 value) = toJSON value
