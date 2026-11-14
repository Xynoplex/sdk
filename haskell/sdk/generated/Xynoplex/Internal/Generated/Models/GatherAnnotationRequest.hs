-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.GatherAnnotationRequest
  ( GatherAnnotationRequest(..)
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
import Xynoplex.Internal.Generated.Models.GatherAnnotationOptions
import Xynoplex.Internal.Generated.Models.ResourceId
data GatherAnnotationRequest = GatherAnnotationRequest { gatherAnnotationRequestAnnotationId :: AnnotationId, gatherAnnotationRequestOptions :: Maybe (GatherAnnotationOptions), gatherAnnotationRequestResourceId :: ResourceId, gatherAnnotationRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON GatherAnnotationRequest where
  parseJSON = checked "GatherAnnotationRequest" $ withObject "GatherAnnotationRequest" (\fields -> GatherAnnotationRequest <$> fields .: "annotationId" <*> optional fields "options" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["annotationId", "options", "resourceId"] fields))
instance ToJSON GatherAnnotationRequest where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (gatherAnnotationRequestAnnotationId value))], optionalPair "options" (gatherAnnotationRequestOptions value), [("resourceId", toJSON (gatherAnnotationRequestResourceId value))]]) <> fmap toJSON (withoutFields ["annotationId", "options", "resourceId"] (gatherAnnotationRequestAdditionalProperties value)))
