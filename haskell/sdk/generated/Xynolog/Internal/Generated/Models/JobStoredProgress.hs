-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.JobStoredProgress (JobStoredProgress (..), JobStoredProgressBranch2Value (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject)
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobProgress

data JobStoredProgress = JobStoredProgressBranch1 JobProgress | JobStoredProgressBranch2 JobStoredProgressBranch2Value deriving (Eq, Show)

instance FromJSON JobStoredProgress where parseJSON = checked "JobStoredProgress" $ \value -> (JobStoredProgressBranch1 <$> parseJSON value) <|> (JobStoredProgressBranch2 <$> parseJSON value)

instance ToJSON JobStoredProgress where
  toJSON (JobStoredProgressBranch1 value) = toJSON value
  toJSON (JobStoredProgressBranch2 value) = toJSON value

data JobStoredProgressBranch2Value = JobStoredProgressBranch2Value
  { jobStoredProgressBranch2ValueAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON JobStoredProgressBranch2Value where parseJSON = checked "JobStoredProgressBranch2Value" $ withObject "JobStoredProgressBranch2Value" (\fields -> JobStoredProgressBranch2Value <$> traverse parseJSON (withoutFields [] fields))

instance ToJSON JobStoredProgressBranch2Value where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (jobStoredProgressBranch2ValueAdditionalProperties value)))
