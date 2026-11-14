-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.BusSubscribeRequest
  ( BusSubscribeRequest(..)
  , BusSubscribeRequestScopedItem(..)
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
data BusSubscribeRequest = BusSubscribeRequest { busSubscribeRequestClientId :: Text, busSubscribeRequestGlobal :: Maybe ([Text]), busSubscribeRequestPendingReplies :: Maybe ([Text]), busSubscribeRequestScoped :: Maybe ([BusSubscribeRequestScopedItem]) } deriving (Eq, Show)
instance FromJSON BusSubscribeRequest where
  parseJSON = checked "BusSubscribeRequest" $ withObject "BusSubscribeRequest" (\fields -> BusSubscribeRequest <$> fields .: "clientId" <*> optional fields "global" <*> optional fields "pendingReplies" <*> optional fields "scoped")
instance ToJSON BusSubscribeRequest where toJSON value = Object (KM.fromList (concat [[("clientId", toJSON (busSubscribeRequestClientId value))], optionalPair "global" (busSubscribeRequestGlobal value), optionalPair "pendingReplies" (busSubscribeRequestPendingReplies value), optionalPair "scoped" (busSubscribeRequestScoped value)]))

data BusSubscribeRequestScopedItem = BusSubscribeRequestScopedItem { busSubscribeRequestScopedItemChannels :: [Text], busSubscribeRequestScopedItemLastEventId :: Maybe (Text), busSubscribeRequestScopedItemScope :: ResourceId } deriving (Eq, Show)
instance FromJSON BusSubscribeRequestScopedItem where
  parseJSON = checked "BusSubscribeRequestScopedItem" $ withObject "BusSubscribeRequestScopedItem" (\fields -> BusSubscribeRequestScopedItem <$> fields .: "channels" <*> optional fields "lastEventId" <*> fields .: "scope")
instance ToJSON BusSubscribeRequestScopedItem where toJSON value = Object (KM.fromList (concat [[("channels", toJSON (busSubscribeRequestScopedItemChannels value))], optionalPair "lastEventId" (busSubscribeRequestScopedItemLastEventId value), [("scope", toJSON (busSubscribeRequestScopedItemScope value))]]))
