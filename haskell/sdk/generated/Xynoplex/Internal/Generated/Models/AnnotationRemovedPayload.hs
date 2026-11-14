-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.AnnotationRemovedPayload
  ( AnnotationRemovedPayload(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.AnnotationId
data AnnotationRemovedPayload = AnnotationRemovedPayload { annotationRemovedPayloadAnnotationId :: AnnotationId, annotationRemovedPayloadAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON AnnotationRemovedPayload where
  parseJSON = checked "AnnotationRemovedPayload" $ withObject "AnnotationRemovedPayload" (\fields -> AnnotationRemovedPayload <$> fields .: "annotationId" <*> traverse parseJSON (withoutFields ["annotationId"] fields))
instance ToJSON AnnotationRemovedPayload where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (annotationRemovedPayloadAnnotationId value))]]) <> fmap toJSON (withoutFields ["annotationId"] (annotationRemovedPayloadAdditionalProperties value)))
