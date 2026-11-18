-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.MatchResourcesRequest (MatchResourcesRequest (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data MatchResourcesRequest = MatchResourcesRequest
  { matchResourcesRequestArchived :: Maybe Bool,
    matchResourcesRequestEntityType :: Maybe Text,
    matchResourcesRequestLimit :: Maybe Integer,
    matchResourcesRequestOffset :: Maybe Integer,
    matchResourcesRequestSearch :: Text,
    matchResourcesRequestAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON MatchResourcesRequest where parseJSON = checked "MatchResourcesRequest" $ withObject "MatchResourcesRequest" (\fields -> MatchResourcesRequest <$> optional fields "archived" <*> optional fields "entityType" <*> optional fields "limit" <*> optional fields "offset" <*> (fields .: "search") <*> traverse parseJSON (withoutFields ["archived", "entityType", "limit", "offset", "search"] fields))

instance ToJSON MatchResourcesRequest where toJSON value = Object (KM.fromList (concat [optionalPair "archived" (matchResourcesRequestArchived value), optionalPair "entityType" (matchResourcesRequestEntityType value), optionalPair "limit" (matchResourcesRequestLimit value), optionalPair "offset" (matchResourcesRequestOffset value), [("search", toJSON (matchResourcesRequestSearch value))]]) <> fmap toJSON (withoutFields ["archived", "entityType", "limit", "offset", "search"] (matchResourcesRequestAdditionalProperties value)))
