-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowseTagSchemasRequest (BrowseTagSchemasRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject)
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
data BrowseTagSchemasRequest = BrowseTagSchemasRequest
  { browseTagSchemasRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BrowseTagSchemasRequest where parseJSON = checked "BrowseTagSchemasRequest" $ withObject "BrowseTagSchemasRequest" (\fields -> BrowseTagSchemasRequest <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON BrowseTagSchemasRequest where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (browseTagSchemasRequestAdditionalProperties value)))
