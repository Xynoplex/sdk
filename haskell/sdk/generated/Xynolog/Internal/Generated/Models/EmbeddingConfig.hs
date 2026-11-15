-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.EmbeddingConfig
  ( EmbeddingConfig(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.OllamaEmbeddingConfig
import Xynolog.Internal.Generated.Models.VoyageEmbeddingConfig
data EmbeddingConfig = EmbeddingConfigBranch1 (OllamaEmbeddingConfig) | EmbeddingConfigBranch2 (VoyageEmbeddingConfig) deriving (Eq, Show)
instance FromJSON EmbeddingConfig where
  parseJSON = checked "EmbeddingConfig" $ \value -> (EmbeddingConfigBranch1 <$> parseJSON value) <|> (EmbeddingConfigBranch2 <$> parseJSON value)
instance ToJSON EmbeddingConfig where
  toJSON (EmbeddingConfigBranch1 value) = toJSON value
  toJSON (EmbeddingConfigBranch2 value) = toJSON value
