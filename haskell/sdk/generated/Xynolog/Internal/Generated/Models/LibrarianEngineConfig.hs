-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.LibrarianEngineConfig (LibrarianEngineConfig (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Engine

data LibrarianEngineConfig = LibrarianEngineConfig
  { librarianEngineConfigApiKeyEnv :: Maybe Text,
    librarianEngineConfigBaseUrl :: Text,
    librarianEngineConfigEngine :: Engine
  }
  deriving (Eq, Show)

instance FromJSON LibrarianEngineConfig where parseJSON = checked "LibrarianEngineConfig" $ withObject "LibrarianEngineConfig" (\fields -> LibrarianEngineConfig <$> optional fields "apiKeyEnv" <*> (fields .: "baseUrl") <*> (fields .: "engine"))

instance ToJSON LibrarianEngineConfig where toJSON value = Object (KM.fromList (concat [optionalPair "apiKeyEnv" (librarianEngineConfigApiKeyEnv value), [("baseUrl", toJSON (librarianEngineConfigBaseUrl value))], [("engine", toJSON (librarianEngineConfigEngine value))]]))
