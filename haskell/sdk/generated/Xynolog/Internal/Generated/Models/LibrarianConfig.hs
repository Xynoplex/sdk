-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.LibrarianConfig (LibrarianConfig(..), LibrarianConfigGather(..), LibrarianConfigSearch(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.EmbeddingConfig
import Xynolog.Internal.Generated.Models.GraphConfig
import Xynolog.Internal.Generated.Models.KbIdentity
import Xynolog.Internal.Generated.Models.LibrarianEngineConfig
import Xynolog.Internal.Generated.Models.LogFormat
import Xynolog.Internal.Generated.Models.LogLevel
import Xynolog.Internal.Generated.Models.ServiceAddress
import Xynolog.Internal.Generated.Models.ServiceIdentity
import Xynolog.Internal.Generated.Models.VectorsConfig
data LibrarianConfig = LibrarianConfig
  { librarianConfigArchivist :: ServiceAddress
  , librarianConfigEmbedding :: EmbeddingConfig
  , librarianConfigGatewayUrl :: Text
  , librarianConfigGather :: LibrarianConfigGather
  , librarianConfigGatherer :: LibrarianEngineConfig
  , librarianConfigGraph :: GraphConfig
  , librarianConfigIdentity :: ServiceIdentity
  , librarianConfigKb :: KbIdentity
  , librarianConfigLogFormat :: LogFormat
  , librarianConfigLogLevel :: LogLevel
  , librarianConfigMatcher :: LibrarianEngineConfig
  , librarianConfigModelCatalogue :: Text
  , librarianConfigPort :: Integer
  , librarianConfigSearch :: LibrarianConfigSearch
  , librarianConfigVectors :: VectorsConfig
  } deriving (Eq, Show)
instance FromJSON LibrarianConfig where parseJSON = checked "LibrarianConfig" $ withObject "LibrarianConfig" (\fields -> LibrarianConfig <$> (fields .: "archivist") <*> (fields .: "embedding") <*> (fields .: "gatewayUrl") <*> (fields .: "gather") <*> (fields .: "gatherer") <*> (fields .: "graph") <*> (fields .: "identity") <*> (fields .: "kb") <*> (fields .: "logFormat") <*> (fields .: "logLevel") <*> (fields .: "matcher") <*> (fields .: "modelCatalogue") <*> (fields .: "port") <*> (fields .: "search") <*> (fields .: "vectors"))
instance ToJSON LibrarianConfig where toJSON value = Object (KM.fromList (concat [[("archivist", toJSON (librarianConfigArchivist value))], [("embedding", toJSON (librarianConfigEmbedding value))], [("gatewayUrl", toJSON (librarianConfigGatewayUrl value))], [("gather", toJSON (librarianConfigGather value))], [("gatherer", toJSON (librarianConfigGatherer value))], [("graph", toJSON (librarianConfigGraph value))], [("identity", toJSON (librarianConfigIdentity value))], [("kb", toJSON (librarianConfigKb value))], [("logFormat", toJSON (librarianConfigLogFormat value))], [("logLevel", toJSON (librarianConfigLogLevel value))], [("matcher", toJSON (librarianConfigMatcher value))], [("modelCatalogue", toJSON (librarianConfigModelCatalogue value))], [("port", toJSON (librarianConfigPort value))], [("search", toJSON (librarianConfigSearch value))], [("vectors", toJSON (librarianConfigVectors value))]]))
data LibrarianConfigGather = LibrarianConfigGather
  { librarianConfigGatherSettleTimeoutMs :: Integer
  } deriving (Eq, Show)
instance FromJSON LibrarianConfigGather where parseJSON = checked "LibrarianConfigGather" $ withObject "LibrarianConfigGather" (\fields -> LibrarianConfigGather <$> (fields .: "settleTimeoutMs"))
instance ToJSON LibrarianConfigGather where toJSON value = Object (KM.fromList (concat [[("settleTimeoutMs", toJSON (librarianConfigGatherSettleTimeoutMs value))]]))
data LibrarianConfigSearch = LibrarianConfigSearch
  { librarianConfigSearchSemanticFloor :: Scientific
  } deriving (Eq, Show)
instance FromJSON LibrarianConfigSearch where parseJSON = checked "LibrarianConfigSearch" $ withObject "LibrarianConfigSearch" (\fields -> LibrarianConfigSearch <$> (fields .: "semanticFloor"))
instance ToJSON LibrarianConfigSearch where toJSON value = Object (KM.fromList (concat [[("semanticFloor", toJSON (librarianConfigSearchSemanticFloor value))]]))
