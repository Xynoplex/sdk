-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.ExtractionOutcome (ExtractionOutcome(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ExtractedText
import Xynolog.Internal.Generated.Models.ExtractionDeclined
data ExtractionOutcome = ExtractionOutcomeBranch1 ExtractedText | ExtractionOutcomeBranch2 ExtractionDeclined deriving (Eq, Show)
instance FromJSON ExtractionOutcome where parseJSON = checked "ExtractionOutcome" $ \value -> (ExtractionOutcomeBranch1 <$> parseJSON value) <|> (ExtractionOutcomeBranch2 <$> parseJSON value)
instance ToJSON ExtractionOutcome where
  toJSON (ExtractionOutcomeBranch1 value) = toJSON value
  toJSON (ExtractionOutcomeBranch2 value) = toJSON value
