-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.VectorsConfig
  ( VectorsConfig(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.MemoryVectorsConfig
import Xynolog.Internal.Generated.Models.QdrantVectorsConfig
data VectorsConfig = VectorsConfigBranch1 (QdrantVectorsConfig) | VectorsConfigBranch2 (MemoryVectorsConfig) deriving (Eq, Show)
instance FromJSON VectorsConfig where
  parseJSON = checked "VectorsConfig" $ \value -> (VectorsConfigBranch1 <$> parseJSON value) <|> (VectorsConfigBranch2 <$> parseJSON value)
instance ToJSON VectorsConfig where
  toJSON (VectorsConfigBranch1 value) = toJSON value
  toJSON (VectorsConfigBranch2 value) = toJSON value
