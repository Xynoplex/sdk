-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.JobPollOptions (JobPollOptions (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject)
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data JobPollOptions = JobPollOptions
  { jobPollOptionsEveryMs :: Maybe Integer,
    jobPollOptionsWithinMs :: Maybe Integer
  }
  deriving (Eq, Show)

instance FromJSON JobPollOptions where parseJSON = checked "JobPollOptions" $ withObject "JobPollOptions" (\fields -> JobPollOptions <$> optional fields "everyMs" <*> optional fields "withinMs")

instance ToJSON JobPollOptions where toJSON value = Object (KM.fromList (concat [optionalPair "everyMs" (jobPollOptionsEveryMs value), optionalPair "withinMs" (jobPollOptionsWithinMs value)]))
