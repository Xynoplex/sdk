-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.GatherAnnotationRequest (GatherAnnotationRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
import Xynolog.Internal.Generated.Models.GatherAnnotationOptions
import Xynolog.Internal.Generated.Models.ResourceId
data GatherAnnotationRequest = GatherAnnotationRequest
  { gatherAnnotationRequestAnnotationId :: AnnotationId
  , gatherAnnotationRequestOptions :: Maybe GatherAnnotationOptions
  , gatherAnnotationRequestResourceId :: ResourceId
  , gatherAnnotationRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GatherAnnotationRequest where parseJSON = checked "GatherAnnotationRequest" $ withObject "GatherAnnotationRequest" (\fields -> GatherAnnotationRequest <$> (fields .: "annotationId") <*> optional fields "options" <*> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["annotationId", "options", "resourceId"] fields))
instance ToJSON GatherAnnotationRequest where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (gatherAnnotationRequestAnnotationId value))], optionalPair "options" (gatherAnnotationRequestOptions value), [("resourceId", toJSON (gatherAnnotationRequestResourceId value))]]) <> fmap toJSON (withoutFields ["annotationId", "options", "resourceId"] (gatherAnnotationRequestAdditionalProperties value)))
