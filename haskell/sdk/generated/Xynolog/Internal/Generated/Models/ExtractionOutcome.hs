-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.ExtractionOutcome
  ( ExtractionOutcome(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.ExtractedText
import Xynolog.Internal.Generated.Models.ExtractionDeclined
data ExtractionOutcome = ExtractionOutcomeBranch1 (ExtractedText) | ExtractionOutcomeBranch2 (ExtractionDeclined) deriving (Eq, Show)
instance FromJSON ExtractionOutcome where
  parseJSON = checked "ExtractionOutcome" $ \value -> (ExtractionOutcomeBranch1 <$> parseJSON value) <|> (ExtractionOutcomeBranch2 <$> parseJSON value)
instance ToJSON ExtractionOutcome where
  toJSON (ExtractionOutcomeBranch1 value) = toJSON value
  toJSON (ExtractionOutcomeBranch2 value) = toJSON value
