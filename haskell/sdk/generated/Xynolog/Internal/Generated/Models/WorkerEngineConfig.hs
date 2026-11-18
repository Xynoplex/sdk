-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.WorkerEngineConfig (WorkerEngineConfig (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Engine
import Xynolog.Internal.Generated.Models.JobFilter

data WorkerEngineConfig = WorkerEngineConfig
  { workerEngineConfigApiKeyEnv :: Maybe Text,
    workerEngineConfigBaseUrl :: Text,
    workerEngineConfigEngine :: Engine,
    workerEngineConfigJobs :: [JobFilter]
  }
  deriving (Eq, Show)

instance FromJSON WorkerEngineConfig where parseJSON = checked "WorkerEngineConfig" $ withObject "WorkerEngineConfig" (\fields -> WorkerEngineConfig <$> optional fields "apiKeyEnv" <*> (fields .: "baseUrl") <*> (fields .: "engine") <*> (fields .: "jobs"))

instance ToJSON WorkerEngineConfig where toJSON value = Object (KM.fromList (concat [optionalPair "apiKeyEnv" (workerEngineConfigApiKeyEnv value), [("baseUrl", toJSON (workerEngineConfigBaseUrl value))], [("engine", toJSON (workerEngineConfigEngine value))], [("jobs", toJSON (workerEngineConfigJobs value))]]))
