-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BrowseEntityTypesRequest (BrowseEntityTypesRequest (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject)
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data BrowseEntityTypesRequest = BrowseEntityTypesRequest
  { browseEntityTypesRequestAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BrowseEntityTypesRequest where parseJSON = checked "BrowseEntityTypesRequest" $ withObject "BrowseEntityTypesRequest" (\fields -> BrowseEntityTypesRequest <$> traverse parseJSON (withoutFields [] fields))

instance ToJSON BrowseEntityTypesRequest where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (browseEntityTypesRequestAdditionalProperties value)))
