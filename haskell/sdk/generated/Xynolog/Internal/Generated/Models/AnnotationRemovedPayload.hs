-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.AnnotationRemovedPayload (AnnotationRemovedPayload(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
data AnnotationRemovedPayload = AnnotationRemovedPayload
  { annotationRemovedPayloadAnnotationId :: AnnotationId
  , annotationRemovedPayloadAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON AnnotationRemovedPayload where parseJSON = checked "AnnotationRemovedPayload" $ withObject "AnnotationRemovedPayload" (\fields -> AnnotationRemovedPayload <$> (fields .: "annotationId") <*> traverse parseJSON (withoutFields ["annotationId"] fields))
instance ToJSON AnnotationRemovedPayload where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (annotationRemovedPayloadAnnotationId value))]]) <> fmap toJSON (withoutFields ["annotationId"] (annotationRemovedPayloadAdditionalProperties value)))
