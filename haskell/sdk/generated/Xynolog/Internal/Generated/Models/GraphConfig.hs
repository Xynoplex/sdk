-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.GraphConfig (GraphConfig(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JanusGraphConfig
import Xynolog.Internal.Generated.Models.MemoryGraphConfig
import Xynolog.Internal.Generated.Models.Neo4jGraphConfig
import Xynolog.Internal.Generated.Models.NeptuneGraphConfig
data GraphConfig = GraphConfigBranch1 Neo4jGraphConfig | GraphConfigBranch2 JanusGraphConfig | GraphConfigBranch3 NeptuneGraphConfig | GraphConfigBranch4 MemoryGraphConfig deriving (Eq, Show)
instance FromJSON GraphConfig where parseJSON = checked "GraphConfig" $ \value -> (GraphConfigBranch1 <$> parseJSON value) <|> (GraphConfigBranch2 <$> parseJSON value) <|> (GraphConfigBranch3 <$> parseJSON value) <|> (GraphConfigBranch4 <$> parseJSON value)
instance ToJSON GraphConfig where
  toJSON (GraphConfigBranch1 value) = toJSON value
  toJSON (GraphConfigBranch2 value) = toJSON value
  toJSON (GraphConfigBranch3 value) = toJSON value
  toJSON (GraphConfigBranch4 value) = toJSON value
