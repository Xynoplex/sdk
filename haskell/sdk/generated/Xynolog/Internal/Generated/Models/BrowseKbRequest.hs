-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BrowseKbRequest (BrowseKbRequest (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject)
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data BrowseKbRequest = BrowseKbRequest
  { browseKbRequestAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BrowseKbRequest where parseJSON = checked "BrowseKbRequest" $ withObject "BrowseKbRequest" (\fields -> BrowseKbRequest <$> traverse parseJSON (withoutFields [] fields))

instance ToJSON BrowseKbRequest where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (browseKbRequestAdditionalProperties value)))
