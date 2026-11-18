-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.CursorsPath (CursorsPath (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..))
import Data.Text (Text)
import Xynolog.Internal.Codec

newtype CursorsPath = CursorsPath {cursorsPathValue :: Text} deriving (Eq, Show)

instance FromJSON CursorsPath where parseJSON = checked "CursorsPath" $ \value -> CursorsPath <$> parseJSON value

instance ToJSON CursorsPath where toJSON (CursorsPath value) = toJSON value
