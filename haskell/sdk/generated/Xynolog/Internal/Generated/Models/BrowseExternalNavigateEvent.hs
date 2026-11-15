-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BrowseExternalNavigateEvent
  ( BrowseExternalNavigateEvent(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.ResourceId
data BrowseExternalNavigateEvent = BrowseExternalNavigateEvent { browseExternalNavigateEventResourceId :: Maybe (ResourceId), browseExternalNavigateEventUrl :: Text, browseExternalNavigateEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseExternalNavigateEvent where
  parseJSON = checked "BrowseExternalNavigateEvent" $ withObject "BrowseExternalNavigateEvent" (\fields -> BrowseExternalNavigateEvent <$> optional fields "resourceId" <*> fields .: "url" <*> traverse parseJSON (withoutFields ["resourceId", "url"] fields))
instance ToJSON BrowseExternalNavigateEvent where toJSON value = Object (KM.fromList (concat [optionalPair "resourceId" (browseExternalNavigateEventResourceId value), [("url", toJSON (browseExternalNavigateEventUrl value))]]) <> fmap toJSON (withoutFields ["resourceId", "url"] (browseExternalNavigateEventAdditionalProperties value)))
