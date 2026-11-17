-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.WorkerConfig (WorkerConfig(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.LogFormat
import Xynolog.Internal.Generated.Models.LogLevel
import Xynolog.Internal.Generated.Models.WorkerKnowledgeBaseConfig
data WorkerConfig = WorkerConfig
  { workerConfigKnowledgeBases :: [WorkerKnowledgeBaseConfig]
  , workerConfigLogFormat :: LogFormat
  , workerConfigLogLevel :: LogLevel
  , workerConfigModelCatalogue :: Text
  , workerConfigPort :: Integer
  } deriving (Eq, Show)
instance FromJSON WorkerConfig where parseJSON = checked "WorkerConfig" $ withObject "WorkerConfig" (\fields -> WorkerConfig <$> (fields .: "knowledgeBases") <*> (fields .: "logFormat") <*> (fields .: "logLevel") <*> (fields .: "modelCatalogue") <*> (fields .: "port"))
instance ToJSON WorkerConfig where toJSON value = Object (KM.fromList (concat [[("knowledgeBases", toJSON (workerConfigKnowledgeBases value))], [("logFormat", toJSON (workerConfigLogFormat value))], [("logLevel", toJSON (workerConfigLogLevel value))], [("modelCatalogue", toJSON (workerConfigModelCatalogue value))], [("port", toJSON (workerConfigPort value))]]))
