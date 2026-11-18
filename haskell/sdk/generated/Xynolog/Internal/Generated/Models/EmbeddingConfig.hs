-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.EmbeddingConfig (EmbeddingConfig (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.OllamaEmbeddingConfig
import Xynolog.Internal.Generated.Models.VoyageEmbeddingConfig

data EmbeddingConfig = EmbeddingConfigBranch1 OllamaEmbeddingConfig | EmbeddingConfigBranch2 VoyageEmbeddingConfig deriving (Eq, Show)

instance FromJSON EmbeddingConfig where parseJSON = checked "EmbeddingConfig" $ \value -> (EmbeddingConfigBranch1 <$> parseJSON value) <|> (EmbeddingConfigBranch2 <$> parseJSON value)

instance ToJSON EmbeddingConfig where
  toJSON (EmbeddingConfigBranch1 value) = toJSON value
  toJSON (EmbeddingConfigBranch2 value) = toJSON value
