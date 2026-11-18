-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.WorkerKnowledgeBaseConfig (WorkerKnowledgeBaseConfig (..), WorkerKnowledgeBaseConfigIdentity (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.WorkerEngineConfig

data WorkerKnowledgeBaseConfig = WorkerKnowledgeBaseConfig
  { workerKnowledgeBaseConfigDomain :: Text,
    workerKnowledgeBaseConfigEngines :: [WorkerEngineConfig],
    workerKnowledgeBaseConfigGatewayUrl :: Text,
    workerKnowledgeBaseConfigIdentity :: WorkerKnowledgeBaseConfigIdentity
  }
  deriving (Eq, Show)

instance FromJSON WorkerKnowledgeBaseConfig where parseJSON = checked "WorkerKnowledgeBaseConfig" $ withObject "WorkerKnowledgeBaseConfig" (\fields -> WorkerKnowledgeBaseConfig <$> (fields .: "domain") <*> (fields .: "engines") <*> (fields .: "gatewayUrl") <*> (fields .: "identity"))

instance ToJSON WorkerKnowledgeBaseConfig where toJSON value = Object (KM.fromList (concat [[("domain", toJSON (workerKnowledgeBaseConfigDomain value))], [("engines", toJSON (workerKnowledgeBaseConfigEngines value))], [("gatewayUrl", toJSON (workerKnowledgeBaseConfigGatewayUrl value))], [("identity", toJSON (workerKnowledgeBaseConfigIdentity value))]]))

data WorkerKnowledgeBaseConfigIdentity = WorkerKnowledgeBaseConfigIdentity
  { workerKnowledgeBaseConfigIdentityClientId :: Text,
    workerKnowledgeBaseConfigIdentityIssuer :: Text
  }
  deriving (Eq, Show)

instance FromJSON WorkerKnowledgeBaseConfigIdentity where parseJSON = checked "WorkerKnowledgeBaseConfigIdentity" $ withObject "WorkerKnowledgeBaseConfigIdentity" (\fields -> WorkerKnowledgeBaseConfigIdentity <$> (fields .: "clientId") <*> (fields .: "issuer"))

instance ToJSON WorkerKnowledgeBaseConfigIdentity where toJSON value = Object (KM.fromList (concat [[("clientId", toJSON (workerKnowledgeBaseConfigIdentityClientId value))], [("issuer", toJSON (workerKnowledgeBaseConfigIdentityIssuer value))]]))
