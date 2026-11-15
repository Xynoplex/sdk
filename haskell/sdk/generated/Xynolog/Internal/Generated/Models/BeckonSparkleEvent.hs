-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BeckonSparkleEvent
  ( BeckonSparkleEvent(..)
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
data BeckonSparkleEvent = BeckonSparkleEvent { beckonSparkleEventAnnotationId :: AnnotationId, beckonSparkleEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BeckonSparkleEvent where
  parseJSON = checked "BeckonSparkleEvent" $ withObject "BeckonSparkleEvent" (\fields -> BeckonSparkleEvent <$> fields .: "annotationId" <*> traverse parseJSON (withoutFields ["annotationId"] fields))
instance ToJSON BeckonSparkleEvent where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (beckonSparkleEventAnnotationId value))]]) <> fmap toJSON (withoutFields ["annotationId"] (beckonSparkleEventAdditionalProperties value)))
