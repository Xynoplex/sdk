-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowseEnginesRequest (BrowseEnginesRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject)
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
data BrowseEnginesRequest = BrowseEnginesRequest
  { browseEnginesRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BrowseEnginesRequest where parseJSON = checked "BrowseEnginesRequest" $ withObject "BrowseEnginesRequest" (\fields -> BrowseEnginesRequest <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON BrowseEnginesRequest where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (browseEnginesRequestAdditionalProperties value)))
