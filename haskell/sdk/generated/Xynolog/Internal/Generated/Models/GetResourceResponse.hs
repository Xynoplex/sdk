-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.GetResourceResponse (GetResourceResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Annotation
import Xynolog.Internal.Generated.Models.ResourceDescriptor
data GetResourceResponse = GetResourceResponse
  { getResourceResponseAnnotations :: [Annotation]
  , getResourceResponseResource :: ResourceDescriptor
  , getResourceResponseAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GetResourceResponse where parseJSON = checked "GetResourceResponse" $ withObject "GetResourceResponse" (\fields -> GetResourceResponse <$> (fields .: "annotations") <*> (fields .: "resource") <*> traverse parseJSON (withoutFields ["annotations", "resource"] fields))
instance ToJSON GetResourceResponse where toJSON value = Object (KM.fromList (concat [[("annotations", toJSON (getResourceResponseAnnotations value))], [("resource", toJSON (getResourceResponseResource value))]]) <> fmap toJSON (withoutFields ["annotations", "resource"] (getResourceResponseAdditionalProperties value)))
