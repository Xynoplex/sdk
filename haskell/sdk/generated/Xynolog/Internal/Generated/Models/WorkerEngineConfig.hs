-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.WorkerEngineConfig
  ( WorkerEngineConfig(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.Engine
import Xynolog.Internal.Generated.Models.JobFilter
data WorkerEngineConfig = WorkerEngineConfig { workerEngineConfigApiKeyEnv :: Maybe (Text), workerEngineConfigBaseUrl :: Text, workerEngineConfigEngine :: Engine, workerEngineConfigJobs :: [JobFilter] } deriving (Eq, Show)
instance FromJSON WorkerEngineConfig where
  parseJSON = checked "WorkerEngineConfig" $ withObject "WorkerEngineConfig" (\fields -> WorkerEngineConfig <$> optional fields "apiKeyEnv" <*> fields .: "baseUrl" <*> fields .: "engine" <*> fields .: "jobs")
instance ToJSON WorkerEngineConfig where toJSON value = Object (KM.fromList (concat [optionalPair "apiKeyEnv" (workerEngineConfigApiKeyEnv value), [("baseUrl", toJSON (workerEngineConfigBaseUrl value))], [("engine", toJSON (workerEngineConfigEngine value))], [("jobs", toJSON (workerEngineConfigJobs value))]]))
