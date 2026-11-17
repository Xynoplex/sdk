-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BeckonSparkleEvent (BeckonSparkleEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
data BeckonSparkleEvent = BeckonSparkleEvent
  { beckonSparkleEventAnnotationId :: AnnotationId
  , beckonSparkleEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BeckonSparkleEvent where parseJSON = checked "BeckonSparkleEvent" $ withObject "BeckonSparkleEvent" (\fields -> BeckonSparkleEvent <$> (fields .: "annotationId") <*> traverse parseJSON (withoutFields ["annotationId"] fields))
instance ToJSON BeckonSparkleEvent where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (beckonSparkleEventAnnotationId value))]]) <> fmap toJSON (withoutFields ["annotationId"] (beckonSparkleEventAdditionalProperties value)))
