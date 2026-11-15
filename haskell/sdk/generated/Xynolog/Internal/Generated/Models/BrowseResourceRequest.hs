-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BrowseResourceRequest
  ( BrowseResourceRequest(..)
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
data BrowseResourceRequest = BrowseResourceRequest { browseResourceRequestResourceId :: ResourceId, browseResourceRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseResourceRequest where
  parseJSON = checked "BrowseResourceRequest" $ withObject "BrowseResourceRequest" (\fields -> BrowseResourceRequest <$> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["resourceId"] fields))
instance ToJSON BrowseResourceRequest where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (browseResourceRequestResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (browseResourceRequestAdditionalProperties value)))
