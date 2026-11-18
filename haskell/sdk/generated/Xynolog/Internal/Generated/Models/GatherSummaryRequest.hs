-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.GatherSummaryRequest (GatherSummaryRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
import Xynolog.Internal.Generated.Models.ResourceId
data GatherSummaryRequest = GatherSummaryRequest
  { gatherSummaryRequestAnnotationId :: AnnotationId
  , gatherSummaryRequestResourceId :: ResourceId
  , gatherSummaryRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GatherSummaryRequest where parseJSON = checked "GatherSummaryRequest" $ withObject "GatherSummaryRequest" (\fields -> GatherSummaryRequest <$> (fields .: "annotationId") <*> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["annotationId", "resourceId"] fields))
instance ToJSON GatherSummaryRequest where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (gatherSummaryRequestAnnotationId value))], [("resourceId", toJSON (gatherSummaryRequestResourceId value))]]) <> fmap toJSON (withoutFields ["annotationId", "resourceId"] (gatherSummaryRequestAdditionalProperties value)))
