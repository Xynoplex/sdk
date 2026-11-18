-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.AnchoredTextEntry (AnchoredTextEntry(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnchoredTextDeclinedEntry
import Xynolog.Internal.Generated.Models.AnchoredTextExtractedEntry
data AnchoredTextEntry = AnchoredTextEntryBranch1 AnchoredTextExtractedEntry | AnchoredTextEntryBranch2 AnchoredTextDeclinedEntry deriving (Eq, Show)
instance FromJSON AnchoredTextEntry where parseJSON = checked "AnchoredTextEntry" $ \value -> (AnchoredTextEntryBranch1 <$> parseJSON value) <|> (AnchoredTextEntryBranch2 <$> parseJSON value)
instance ToJSON AnchoredTextEntry where
  toJSON (AnchoredTextEntryBranch1 value) = toJSON value
  toJSON (AnchoredTextEntryBranch2 value) = toJSON value
