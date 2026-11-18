-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.VectorsConfig (VectorsConfig (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.MemoryVectorsConfig
import Xynolog.Internal.Generated.Models.QdrantVectorsConfig

data VectorsConfig = VectorsConfigBranch1 QdrantVectorsConfig | VectorsConfigBranch2 MemoryVectorsConfig deriving (Eq, Show)

instance FromJSON VectorsConfig where parseJSON = checked "VectorsConfig" $ \value -> (VectorsConfigBranch1 <$> parseJSON value) <|> (VectorsConfigBranch2 <$> parseJSON value)

instance ToJSON VectorsConfig where
  toJSON (VectorsConfigBranch1 value) = toJSON value
  toJSON (VectorsConfigBranch2 value) = toJSON value
