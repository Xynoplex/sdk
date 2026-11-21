-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.SmelterConfig (SmelterConfig (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.CursorsPath
import Xynolog.Internal.Generated.Models.EmbeddingConfig
import Xynolog.Internal.Generated.Models.KbIdentity
import Xynolog.Internal.Generated.Models.LogFormat
import Xynolog.Internal.Generated.Models.LogLevel
import Xynolog.Internal.Generated.Models.ServiceAddress
import Xynolog.Internal.Generated.Models.ServiceIdentity
import Xynolog.Internal.Generated.Models.SmelterChunking
import Xynolog.Internal.Generated.Models.VectorsConfig

data SmelterConfig = SmelterConfig
  { smelterConfigArchivist :: ServiceAddress,
    smelterConfigChunking :: SmelterChunking,
    smelterConfigCursorsPath :: CursorsPath,
    smelterConfigEmbedding :: EmbeddingConfig,
    smelterConfigGatewayUrl :: Text,
    smelterConfigIdentity :: ServiceIdentity,
    smelterConfigKb :: KbIdentity,
    smelterConfigLogFormat :: LogFormat,
    smelterConfigLogLevel :: LogLevel,
    smelterConfigPdfsAtOnce :: Integer,
    smelterConfigPort :: Integer,
    smelterConfigVectors :: VectorsConfig
  }
  deriving (Eq, Show)

instance FromJSON SmelterConfig where parseJSON = checked "SmelterConfig" $ withObject "SmelterConfig" (\fields -> SmelterConfig <$> (fields .: "archivist") <*> (fields .: "chunking") <*> (fields .: "cursorsPath") <*> (fields .: "embedding") <*> (fields .: "gatewayUrl") <*> (fields .: "identity") <*> (fields .: "kb") <*> (fields .: "logFormat") <*> (fields .: "logLevel") <*> (fields .: "pdfsAtOnce") <*> (fields .: "port") <*> (fields .: "vectors"))

instance ToJSON SmelterConfig where toJSON value = Object (KM.fromList (concat [[("archivist", toJSON (smelterConfigArchivist value))], [("chunking", toJSON (smelterConfigChunking value))], [("cursorsPath", toJSON (smelterConfigCursorsPath value))], [("embedding", toJSON (smelterConfigEmbedding value))], [("gatewayUrl", toJSON (smelterConfigGatewayUrl value))], [("identity", toJSON (smelterConfigIdentity value))], [("kb", toJSON (smelterConfigKb value))], [("logFormat", toJSON (smelterConfigLogFormat value))], [("logLevel", toJSON (smelterConfigLogLevel value))], [("pdfsAtOnce", toJSON (smelterConfigPdfsAtOnce value))], [("port", toJSON (smelterConfigPort value))], [("vectors", toJSON (smelterConfigVectors value))]]))
