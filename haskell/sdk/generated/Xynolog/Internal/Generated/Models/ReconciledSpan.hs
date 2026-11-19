-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.ReconciledSpan (ReconciledSpan (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ReconciledSpanContextRecovered
import Xynolog.Internal.Generated.Models.ReconciledSpanFirstOfMany
import Xynolog.Internal.Generated.Models.ReconciledSpanFuzzyMatch
import Xynolog.Internal.Generated.Models.ReconciledSpanUniqueMatch

data ReconciledSpan = ReconciledSpanBranch1 ReconciledSpanUniqueMatch | ReconciledSpanBranch2 ReconciledSpanContextRecovered | ReconciledSpanBranch3 ReconciledSpanFirstOfMany | ReconciledSpanBranch4 ReconciledSpanFuzzyMatch deriving (Eq, Show)

instance FromJSON ReconciledSpan where parseJSON = checked "ReconciledSpan" $ \value -> (ReconciledSpanBranch1 <$> parseJSON value) <|> (ReconciledSpanBranch2 <$> parseJSON value) <|> (ReconciledSpanBranch3 <$> parseJSON value) <|> (ReconciledSpanBranch4 <$> parseJSON value)

instance ToJSON ReconciledSpan where
  toJSON (ReconciledSpanBranch1 value) = toJSON value
  toJSON (ReconciledSpanBranch2 value) = toJSON value
  toJSON (ReconciledSpanBranch3 value) = toJSON value
  toJSON (ReconciledSpanBranch4 value) = toJSON value
