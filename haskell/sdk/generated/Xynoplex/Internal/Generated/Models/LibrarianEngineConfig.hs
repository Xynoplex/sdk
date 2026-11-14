-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.LibrarianEngineConfig
  ( LibrarianEngineConfig(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.Engine
data LibrarianEngineConfig = LibrarianEngineConfig { librarianEngineConfigApiKeyEnv :: Maybe (Text), librarianEngineConfigBaseUrl :: Text, librarianEngineConfigEngine :: Engine } deriving (Eq, Show)
instance FromJSON LibrarianEngineConfig where
  parseJSON = checked "LibrarianEngineConfig" $ withObject "LibrarianEngineConfig" (\fields -> LibrarianEngineConfig <$> optional fields "apiKeyEnv" <*> fields .: "baseUrl" <*> fields .: "engine")
instance ToJSON LibrarianEngineConfig where toJSON value = Object (KM.fromList (concat [optionalPair "apiKeyEnv" (librarianEngineConfigApiKeyEnv value), [("baseUrl", toJSON (librarianEngineConfigBaseUrl value))], [("engine", toJSON (librarianEngineConfigEngine value))]]))
