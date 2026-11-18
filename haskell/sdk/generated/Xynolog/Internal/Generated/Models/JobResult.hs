-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.JobResult (JobResult (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobDeclined
import Xynolog.Internal.Generated.Models.MarkJobDone
import Xynolog.Internal.Generated.Models.YieldJobDone

data JobResult = JobResultBranch1 MarkJobDone | JobResultBranch2 YieldJobDone | JobResultBranch3 JobDeclined deriving (Eq, Show)

instance FromJSON JobResult where parseJSON = checked "JobResult" $ \value -> (JobResultBranch1 <$> parseJSON value) <|> (JobResultBranch2 <$> parseJSON value) <|> (JobResultBranch3 <$> parseJSON value)

instance ToJSON JobResult where
  toJSON (JobResultBranch1 value) = toJSON value
  toJSON (JobResultBranch2 value) = toJSON value
  toJSON (JobResultBranch3 value) = toJSON value
