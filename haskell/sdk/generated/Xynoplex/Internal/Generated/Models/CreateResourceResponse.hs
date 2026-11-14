-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.CreateResourceResponse
  ( CreateResourceResponse(..)
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
data CreateResourceResponse = CreateResourceResponse { createResourceResponseResourceId :: ResourceId, createResourceResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON CreateResourceResponse where
  parseJSON = checked "CreateResourceResponse" $ withObject "CreateResourceResponse" (\fields -> CreateResourceResponse <$> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["resourceId"] fields))
instance ToJSON CreateResourceResponse where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (createResourceResponseResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (createResourceResponseAdditionalProperties value)))
