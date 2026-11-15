-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BeckonFocusEvent
  ( BeckonFocusEvent(..)
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
data BeckonFocusEvent = BeckonFocusEvent { beckonFocusEventAnnotationId :: Maybe (AnnotationId), beckonFocusEventResourceId :: ResourceId, beckonFocusEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BeckonFocusEvent where
  parseJSON = checked "BeckonFocusEvent" $ withObject "BeckonFocusEvent" (\fields -> BeckonFocusEvent <$> optional fields "annotationId" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["annotationId", "resourceId"] fields))
instance ToJSON BeckonFocusEvent where toJSON value = Object (KM.fromList (concat [optionalPair "annotationId" (beckonFocusEventAnnotationId value), [("resourceId", toJSON (beckonFocusEventResourceId value))]]) <> fmap toJSON (withoutFields ["annotationId", "resourceId"] (beckonFocusEventAdditionalProperties value)))
