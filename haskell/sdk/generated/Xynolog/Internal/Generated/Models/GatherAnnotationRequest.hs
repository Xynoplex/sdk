-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.GatherAnnotationRequest
  ( GatherAnnotationRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.AnnotationId
import Xynolog.Internal.Generated.Models.GatherAnnotationOptions
import Xynolog.Internal.Generated.Models.ResourceId
data GatherAnnotationRequest = GatherAnnotationRequest { gatherAnnotationRequestAnnotationId :: AnnotationId, gatherAnnotationRequestOptions :: Maybe (GatherAnnotationOptions), gatherAnnotationRequestResourceId :: ResourceId, gatherAnnotationRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON GatherAnnotationRequest where
  parseJSON = checked "GatherAnnotationRequest" $ withObject "GatherAnnotationRequest" (\fields -> GatherAnnotationRequest <$> fields .: "annotationId" <*> optional fields "options" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["annotationId", "options", "resourceId"] fields))
instance ToJSON GatherAnnotationRequest where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (gatherAnnotationRequestAnnotationId value))], optionalPair "options" (gatherAnnotationRequestOptions value), [("resourceId", toJSON (gatherAnnotationRequestResourceId value))]]) <> fmap toJSON (withoutFields ["annotationId", "options", "resourceId"] (gatherAnnotationRequestAdditionalProperties value)))
