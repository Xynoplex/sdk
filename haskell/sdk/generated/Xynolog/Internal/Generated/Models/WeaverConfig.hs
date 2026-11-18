-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.WeaverConfig (WeaverConfig(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.CursorsPath
import Xynolog.Internal.Generated.Models.GraphConfig
import Xynolog.Internal.Generated.Models.KbIdentity
import Xynolog.Internal.Generated.Models.LogFormat
import Xynolog.Internal.Generated.Models.LogLevel
import Xynolog.Internal.Generated.Models.ServiceAddress
import Xynolog.Internal.Generated.Models.ServiceIdentity
data WeaverConfig = WeaverConfig
  { weaverConfigArchivist :: ServiceAddress
  , weaverConfigCursorsPath :: CursorsPath
  , weaverConfigGatewayUrl :: Text
  , weaverConfigGraph :: GraphConfig
  , weaverConfigIdentity :: ServiceIdentity
  , weaverConfigKb :: KbIdentity
  , weaverConfigLogFormat :: LogFormat
  , weaverConfigLogLevel :: LogLevel
  , weaverConfigPort :: Integer
  } deriving (Eq, Show)
instance FromJSON WeaverConfig where parseJSON = checked "WeaverConfig" $ withObject "WeaverConfig" (\fields -> WeaverConfig <$> (fields .: "archivist") <*> (fields .: "cursorsPath") <*> (fields .: "gatewayUrl") <*> (fields .: "graph") <*> (fields .: "identity") <*> (fields .: "kb") <*> (fields .: "logFormat") <*> (fields .: "logLevel") <*> (fields .: "port"))
instance ToJSON WeaverConfig where toJSON value = Object (KM.fromList (concat [[("archivist", toJSON (weaverConfigArchivist value))], [("cursorsPath", toJSON (weaverConfigCursorsPath value))], [("gatewayUrl", toJSON (weaverConfigGatewayUrl value))], [("graph", toJSON (weaverConfigGraph value))], [("identity", toJSON (weaverConfigIdentity value))], [("kb", toJSON (weaverConfigKb value))], [("logFormat", toJSON (weaverConfigLogFormat value))], [("logLevel", toJSON (weaverConfigLogLevel value))], [("port", toJSON (weaverConfigPort value))]]))
