-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BrowseProfilesRequest (BrowseProfilesRequest (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.UserId

data BrowseProfilesRequest = BrowseProfilesRequest
  { browseProfilesRequestDids :: [UserId]
  }
  deriving (Eq, Show)

instance FromJSON BrowseProfilesRequest where parseJSON = checked "BrowseProfilesRequest" $ withObject "BrowseProfilesRequest" (\fields -> BrowseProfilesRequest <$> (fields .: "dids"))

instance ToJSON BrowseProfilesRequest where toJSON value = Object (KM.fromList (concat [[("dids", toJSON (browseProfilesRequestDids value))]]))
