-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.JobRecord (JobRecord (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Job

data JobRecord = JobRecord
  { jobRecordJob :: Job,
    jobRecordLastProgressAt :: Text
  }
  deriving (Eq, Show)

instance FromJSON JobRecord where parseJSON = checked "JobRecord" $ withObject "JobRecord" (\fields -> JobRecord <$> (fields .: "job") <*> (fields .: "lastProgressAt"))

instance ToJSON JobRecord where toJSON value = Object (KM.fromList (concat [[("job", toJSON (jobRecordJob value))], [("lastProgressAt", toJSON (jobRecordLastProgressAt value))]]))
