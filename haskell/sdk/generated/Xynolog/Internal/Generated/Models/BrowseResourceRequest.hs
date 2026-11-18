-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowseResourceRequest (BrowseResourceRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId
data BrowseResourceRequest = BrowseResourceRequest
  { browseResourceRequestResourceId :: ResourceId
  , browseResourceRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BrowseResourceRequest where parseJSON = checked "BrowseResourceRequest" $ withObject "BrowseResourceRequest" (\fields -> BrowseResourceRequest <$> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["resourceId"] fields))
instance ToJSON BrowseResourceRequest where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (browseResourceRequestResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (browseResourceRequestAdditionalProperties value)))
