-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowseResourceCloseEvent (BrowseResourceCloseEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId
data BrowseResourceCloseEvent = BrowseResourceCloseEvent
  { browseResourceCloseEventResourceId :: ResourceId
  , browseResourceCloseEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BrowseResourceCloseEvent where parseJSON = checked "BrowseResourceCloseEvent" $ withObject "BrowseResourceCloseEvent" (\fields -> BrowseResourceCloseEvent <$> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["resourceId"] fields))
instance ToJSON BrowseResourceCloseEvent where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (browseResourceCloseEventResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (browseResourceCloseEventAdditionalProperties value)))
