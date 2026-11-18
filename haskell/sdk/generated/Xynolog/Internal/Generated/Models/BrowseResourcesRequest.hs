-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BrowseResourcesRequest (BrowseResourcesRequest (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject)
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data BrowseResourcesRequest = BrowseResourcesRequest
  { browseResourcesRequestArchived :: Maybe Bool,
    browseResourcesRequestEntityType :: Maybe Text,
    browseResourcesRequestLimit :: Maybe Integer,
    browseResourcesRequestOffset :: Maybe Integer,
    browseResourcesRequestAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BrowseResourcesRequest where parseJSON = checked "BrowseResourcesRequest" $ withObject "BrowseResourcesRequest" (\fields -> BrowseResourcesRequest <$> optional fields "archived" <*> optional fields "entityType" <*> optional fields "limit" <*> optional fields "offset" <*> traverse parseJSON (withoutFields ["archived", "entityType", "limit", "offset"] fields))

instance ToJSON BrowseResourcesRequest where toJSON value = Object (KM.fromList (concat [optionalPair "archived" (browseResourcesRequestArchived value), optionalPair "entityType" (browseResourcesRequestEntityType value), optionalPair "limit" (browseResourcesRequestLimit value), optionalPair "offset" (browseResourcesRequestOffset value)]) <> fmap toJSON (withoutFields ["archived", "entityType", "limit", "offset"] (browseResourcesRequestAdditionalProperties value)))
