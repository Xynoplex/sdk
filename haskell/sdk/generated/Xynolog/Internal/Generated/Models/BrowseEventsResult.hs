-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BrowseEventsResult (BrowseEventsResult (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.GetEventsResponse

data BrowseEventsResult = BrowseEventsResult
  { browseEventsResultResponse :: GetEventsResponse,
    browseEventsResultAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BrowseEventsResult where parseJSON = checked "BrowseEventsResult" $ withObject "BrowseEventsResult" (\fields -> BrowseEventsResult <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))

instance ToJSON BrowseEventsResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (browseEventsResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (browseEventsResultAdditionalProperties value)))
