-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.AnchoredTextEntry
  ( AnchoredTextEntry(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.AnchoredTextDeclinedEntry
import Xynolog.Internal.Generated.Models.AnchoredTextExtractedEntry
data AnchoredTextEntry = AnchoredTextEntryBranch1 (AnchoredTextExtractedEntry) | AnchoredTextEntryBranch2 (AnchoredTextDeclinedEntry) deriving (Eq, Show)
instance FromJSON AnchoredTextEntry where
  parseJSON = checked "AnchoredTextEntry" $ \value -> (AnchoredTextEntryBranch1 <$> parseJSON value) <|> (AnchoredTextEntryBranch2 <$> parseJSON value)
instance ToJSON AnchoredTextEntry where
  toJSON (AnchoredTextEntryBranch1 value) = toJSON value
  toJSON (AnchoredTextEntryBranch2 value) = toJSON value
