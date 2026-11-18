-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BrowseAnnotationResult (BrowseAnnotationResult (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.GetAnnotationResponse

data BrowseAnnotationResult = BrowseAnnotationResult
  { browseAnnotationResultResponse :: GetAnnotationResponse,
    browseAnnotationResultAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BrowseAnnotationResult where parseJSON = checked "BrowseAnnotationResult" $ withObject "BrowseAnnotationResult" (\fields -> BrowseAnnotationResult <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))

instance ToJSON BrowseAnnotationResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (browseAnnotationResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (browseAnnotationResultAdditionalProperties value)))
