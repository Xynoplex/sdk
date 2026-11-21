-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.ResourceSearchFilters (ResourceSearchFilters (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject)
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data ResourceSearchFilters = ResourceSearchFilters
  { resourceSearchFiltersArchived :: Maybe Bool,
    resourceSearchFiltersEntityType :: Maybe Text,
    resourceSearchFiltersLimit :: Maybe Integer,
    resourceSearchFiltersOffset :: Maybe Integer
  }
  deriving (Eq, Show)

instance FromJSON ResourceSearchFilters where parseJSON = checked "ResourceSearchFilters" $ withObject "ResourceSearchFilters" (\fields -> ResourceSearchFilters <$> optional fields "archived" <*> optional fields "entityType" <*> optional fields "limit" <*> optional fields "offset")

instance ToJSON ResourceSearchFilters where toJSON value = Object (KM.fromList (concat [optionalPair "archived" (resourceSearchFiltersArchived value), optionalPair "entityType" (resourceSearchFiltersEntityType value), optionalPair "limit" (resourceSearchFiltersLimit value), optionalPair "offset" (resourceSearchFiltersOffset value)]))
