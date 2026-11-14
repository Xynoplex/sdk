-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.BrowseResourceRequest
  ( BrowseResourceRequest(..)
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
data BrowseResourceRequest = BrowseResourceRequest { browseResourceRequestResourceId :: ResourceId, browseResourceRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseResourceRequest where
  parseJSON = checked "BrowseResourceRequest" $ withObject "BrowseResourceRequest" (\fields -> BrowseResourceRequest <$> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["resourceId"] fields))
instance ToJSON BrowseResourceRequest where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (browseResourceRequestResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (browseResourceRequestAdditionalProperties value)))
