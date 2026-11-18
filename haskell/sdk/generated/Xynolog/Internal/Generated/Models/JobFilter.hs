-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobFilter (JobFilter(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.MarkJobFilter
import Xynolog.Internal.Generated.Models.YieldJobFilter
data JobFilter = JobFilterBranch1 MarkJobFilter | JobFilterBranch2 YieldJobFilter deriving (Eq, Show)
instance FromJSON JobFilter where parseJSON = checked "JobFilter" $ \value -> (JobFilterBranch1 <$> parseJSON value) <|> (JobFilterBranch2 <$> parseJSON value)
instance ToJSON JobFilter where
  toJSON (JobFilterBranch1 value) = toJSON value
  toJSON (JobFilterBranch2 value) = toJSON value
