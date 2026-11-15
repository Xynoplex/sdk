-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.GetResourceResponse
  ( GetResourceResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.Annotation
import Xynolog.Internal.Generated.Models.ResourceDescriptor
data GetResourceResponse = GetResourceResponse { getResourceResponseAnnotations :: [Annotation], getResourceResponseResource :: ResourceDescriptor, getResourceResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON GetResourceResponse where
  parseJSON = checked "GetResourceResponse" $ withObject "GetResourceResponse" (\fields -> GetResourceResponse <$> fields .: "annotations" <*> fields .: "resource" <*> traverse parseJSON (withoutFields ["annotations", "resource"] fields))
instance ToJSON GetResourceResponse where toJSON value = Object (KM.fromList (concat [[("annotations", toJSON (getResourceResponseAnnotations value))], [("resource", toJSON (getResourceResponseResource value))]]) <> fmap toJSON (withoutFields ["annotations", "resource"] (getResourceResponseAdditionalProperties value)))
