-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.GetEntityTypesResponse (GetEntityTypesResponse (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data GetEntityTypesResponse = GetEntityTypesResponse
  { getEntityTypesResponseEntityTypes :: [Text],
    getEntityTypesResponseAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON GetEntityTypesResponse where parseJSON = checked "GetEntityTypesResponse" $ withObject "GetEntityTypesResponse" (\fields -> GetEntityTypesResponse <$> (fields .: "entityTypes") <*> traverse parseJSON (withoutFields ["entityTypes"] fields))

instance ToJSON GetEntityTypesResponse where toJSON value = Object (KM.fromList (concat [[("entityTypes", toJSON (getEntityTypesResponseEntityTypes value))]]) <> fmap toJSON (withoutFields ["entityTypes"] (getEntityTypesResponseAdditionalProperties value)))
