-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BrowseAnnotationRequest
  ( BrowseAnnotationRequest(..)
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
import Xynolog.Internal.Generated.Models.ResourceId
data BrowseAnnotationRequest = BrowseAnnotationRequest { browseAnnotationRequestAnnotationId :: AnnotationId, browseAnnotationRequestResourceId :: ResourceId, browseAnnotationRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseAnnotationRequest where
  parseJSON = checked "BrowseAnnotationRequest" $ withObject "BrowseAnnotationRequest" (\fields -> BrowseAnnotationRequest <$> fields .: "annotationId" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["annotationId", "resourceId"] fields))
instance ToJSON BrowseAnnotationRequest where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (browseAnnotationRequestAnnotationId value))], [("resourceId", toJSON (browseAnnotationRequestResourceId value))]]) <> fmap toJSON (withoutFields ["annotationId", "resourceId"] (browseAnnotationRequestAdditionalProperties value)))
