-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.WorkerConfig
  ( WorkerConfig(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.LogFormat
import Xynoplex.Internal.Generated.Models.LogLevel
import Xynoplex.Internal.Generated.Models.WorkerKnowledgeBaseConfig
data WorkerConfig = WorkerConfig { workerConfigKnowledgeBases :: [WorkerKnowledgeBaseConfig], workerConfigLogFormat :: LogFormat, workerConfigLogLevel :: LogLevel, workerConfigModelCatalogue :: Text, workerConfigPort :: Integer } deriving (Eq, Show)
instance FromJSON WorkerConfig where
  parseJSON = checked "WorkerConfig" $ withObject "WorkerConfig" (\fields -> WorkerConfig <$> fields .: "knowledgeBases" <*> fields .: "logFormat" <*> fields .: "logLevel" <*> fields .: "modelCatalogue" <*> fields .: "port")
instance ToJSON WorkerConfig where toJSON value = Object (KM.fromList (concat [[("knowledgeBases", toJSON (workerConfigKnowledgeBases value))], [("logFormat", toJSON (workerConfigLogFormat value))], [("logLevel", toJSON (workerConfigLogLevel value))], [("modelCatalogue", toJSON (workerConfigModelCatalogue value))], [("port", toJSON (workerConfigPort value))]]))
