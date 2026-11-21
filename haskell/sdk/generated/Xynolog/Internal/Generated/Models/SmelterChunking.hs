-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.SmelterChunking (SmelterChunking (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data SmelterChunking = SmelterChunking
  { smelterChunkingChunkSize :: Integer,
    smelterChunkingOverlap :: Integer
  }
  deriving (Eq, Show)

instance FromJSON SmelterChunking where parseJSON = checked "SmelterChunking" $ withObject "SmelterChunking" (\fields -> SmelterChunking <$> (fields .: "chunkSize") <*> (fields .: "overlap"))

instance ToJSON SmelterChunking where toJSON value = Object (KM.fromList (concat [[("chunkSize", toJSON (smelterChunkingChunkSize value))], [("overlap", toJSON (smelterChunkingOverlap value))]]))
