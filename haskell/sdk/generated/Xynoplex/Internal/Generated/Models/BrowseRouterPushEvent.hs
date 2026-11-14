-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.BrowseRouterPushEvent
  ( BrowseRouterPushEvent(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data BrowseRouterPushEvent = BrowseRouterPushEvent { browseRouterPushEventPath :: Text, browseRouterPushEventReason :: Maybe (Text), browseRouterPushEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseRouterPushEvent where
  parseJSON = checked "BrowseRouterPushEvent" $ withObject "BrowseRouterPushEvent" (\fields -> BrowseRouterPushEvent <$> fields .: "path" <*> optional fields "reason" <*> traverse parseJSON (withoutFields ["path", "reason"] fields))
instance ToJSON BrowseRouterPushEvent where toJSON value = Object (KM.fromList (concat [[("path", toJSON (browseRouterPushEventPath value))], optionalPair "reason" (browseRouterPushEventReason value)]) <> fmap toJSON (withoutFields ["path", "reason"] (browseRouterPushEventAdditionalProperties value)))
