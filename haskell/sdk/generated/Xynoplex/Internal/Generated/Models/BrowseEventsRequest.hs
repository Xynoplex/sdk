-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.BrowseEventsRequest
  ( BrowseEventsRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.ResourceId
import Xynoplex.Internal.Generated.Models.UserId
data BrowseEventsRequest = BrowseEventsRequest { browseEventsRequestLimit :: Maybe (Integer), browseEventsRequestResourceId :: ResourceId, browseEventsRequestType :: Maybe (Text), browseEventsRequestUserId :: Maybe (UserId), browseEventsRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseEventsRequest where
  parseJSON = checked "BrowseEventsRequest" $ withObject "BrowseEventsRequest" (\fields -> BrowseEventsRequest <$> optional fields "limit" <*> fields .: "resourceId" <*> optional fields "type" <*> optional fields "userId" <*> traverse parseJSON (withoutFields ["limit", "resourceId", "type", "userId"] fields))
instance ToJSON BrowseEventsRequest where toJSON value = Object (KM.fromList (concat [optionalPair "limit" (browseEventsRequestLimit value), [("resourceId", toJSON (browseEventsRequestResourceId value))], optionalPair "type" (browseEventsRequestType value), optionalPair "userId" (browseEventsRequestUserId value)]) <> fmap toJSON (withoutFields ["limit", "resourceId", "type", "userId"] (browseEventsRequestAdditionalProperties value)))
