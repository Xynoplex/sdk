-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BrowseExternalNavigateEvent (BrowseExternalNavigateEvent (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId

data BrowseExternalNavigateEvent = BrowseExternalNavigateEvent
  { browseExternalNavigateEventResourceId :: Maybe ResourceId,
    browseExternalNavigateEventUrl :: Text,
    browseExternalNavigateEventAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BrowseExternalNavigateEvent where parseJSON = checked "BrowseExternalNavigateEvent" $ withObject "BrowseExternalNavigateEvent" (\fields -> BrowseExternalNavigateEvent <$> optional fields "resourceId" <*> (fields .: "url") <*> traverse parseJSON (withoutFields ["resourceId", "url"] fields))

instance ToJSON BrowseExternalNavigateEvent where toJSON value = Object (KM.fromList (concat [optionalPair "resourceId" (browseExternalNavigateEventResourceId value), [("url", toJSON (browseExternalNavigateEventUrl value))]]) <> fmap toJSON (withoutFields ["resourceId", "url"] (browseExternalNavigateEventAdditionalProperties value)))
