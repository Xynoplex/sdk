-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.JobClaimedResult (JobClaimedResult (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobRunning

data JobClaimedResult = JobClaimedResult
  { jobClaimedResultResponse :: JobRunning
  }
  deriving (Eq, Show)

instance FromJSON JobClaimedResult where parseJSON = checked "JobClaimedResult" $ withObject "JobClaimedResult" (\fields -> JobClaimedResult <$> (fields .: "response"))

instance ToJSON JobClaimedResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (jobClaimedResultResponse value))]]))
