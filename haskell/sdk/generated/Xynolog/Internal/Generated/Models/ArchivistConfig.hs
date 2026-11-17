-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.ArchivistConfig (ArchivistConfig(..), ArchivistConfigIdentity(..), ArchivistConfigStaging(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ArchivistEngines
import Xynolog.Internal.Generated.Models.LogFormat
import Xynolog.Internal.Generated.Models.LogLevel
data ArchivistConfig = ArchivistConfig
  { archivistConfigAnchoredTextDir :: Text
  , archivistConfigEngines :: ArchivistEngines
  , archivistConfigGatewayUrl :: Text
  , archivistConfigIdentity :: ArchivistConfigIdentity
  , archivistConfigLogFormat :: LogFormat
  , archivistConfigLogLevel :: LogLevel
  , archivistConfigPort :: Integer
  , archivistConfigRoot :: Text
  , archivistConfigSkipRebuild :: Bool
  , archivistConfigStaging :: ArchivistConfigStaging
  , archivistConfigStateHome :: Text
  } deriving (Eq, Show)
instance FromJSON ArchivistConfig where parseJSON = checked "ArchivistConfig" $ withObject "ArchivistConfig" (\fields -> ArchivistConfig <$> (fields .: "anchoredTextDir") <*> (fields .: "engines") <*> (fields .: "gatewayUrl") <*> (fields .: "identity") <*> (fields .: "logFormat") <*> (fields .: "logLevel") <*> (fields .: "port") <*> (fields .: "root") <*> (fields .: "skipRebuild") <*> (fields .: "staging") <*> (fields .: "stateHome"))
instance ToJSON ArchivistConfig where toJSON value = Object (KM.fromList (concat [[("anchoredTextDir", toJSON (archivistConfigAnchoredTextDir value))], [("engines", toJSON (archivistConfigEngines value))], [("gatewayUrl", toJSON (archivistConfigGatewayUrl value))], [("identity", toJSON (archivistConfigIdentity value))], [("logFormat", toJSON (archivistConfigLogFormat value))], [("logLevel", toJSON (archivistConfigLogLevel value))], [("port", toJSON (archivistConfigPort value))], [("root", toJSON (archivistConfigRoot value))], [("skipRebuild", toJSON (archivistConfigSkipRebuild value))], [("staging", toJSON (archivistConfigStaging value))], [("stateHome", toJSON (archivistConfigStateHome value))]]))
data ArchivistConfigIdentity = ArchivistConfigIdentity
  { archivistConfigIdentityIssuer :: Text
  } deriving (Eq, Show)
instance FromJSON ArchivistConfigIdentity where parseJSON = checked "ArchivistConfigIdentity" $ withObject "ArchivistConfigIdentity" (\fields -> ArchivistConfigIdentity <$> (fields .: "issuer"))
instance ToJSON ArchivistConfigIdentity where toJSON value = Object (KM.fromList (concat [[("issuer", toJSON (archivistConfigIdentityIssuer value))]]))
data ArchivistConfigStaging = ArchivistConfigStaging
  { archivistConfigStagingFlushMs :: Integer
  , archivistConfigStagingMaxWaitMs :: Integer
  } deriving (Eq, Show)
instance FromJSON ArchivistConfigStaging where parseJSON = checked "ArchivistConfigStaging" $ withObject "ArchivistConfigStaging" (\fields -> ArchivistConfigStaging <$> (fields .: "flushMs") <*> (fields .: "maxWaitMs"))
instance ToJSON ArchivistConfigStaging where toJSON value = Object (KM.fromList (concat [[("flushMs", toJSON (archivistConfigStagingFlushMs value))], [("maxWaitMs", toJSON (archivistConfigStagingMaxWaitMs value))]]))
