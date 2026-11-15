-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.MarkSubmitEvent
  ( MarkSubmitEvent(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.AnnotationBodies
import Xynolog.Internal.Generated.Models.AnnotationSelector
import Xynolog.Internal.Generated.Models.Motivation
import Xynolog.Internal.Generated.Models.ResourceId
data MarkSubmitEvent = MarkSubmitEvent { markSubmitEventBody :: Maybe (AnnotationBodies), markSubmitEventMotivation :: Motivation, markSubmitEventSelector :: AnnotationSelector, markSubmitEventSource :: ResourceId, markSubmitEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON MarkSubmitEvent where
  parseJSON = checked "MarkSubmitEvent" $ withObject "MarkSubmitEvent" (\fields -> MarkSubmitEvent <$> optional fields "body" <*> fields .: "motivation" <*> fields .: "selector" <*> fields .: "source" <*> traverse parseJSON (withoutFields ["body", "motivation", "selector", "source"] fields))
instance ToJSON MarkSubmitEvent where toJSON value = Object (KM.fromList (concat [optionalPair "body" (markSubmitEventBody value), [("motivation", toJSON (markSubmitEventMotivation value))], [("selector", toJSON (markSubmitEventSelector value))], [("source", toJSON (markSubmitEventSource value))]]) <> fmap toJSON (withoutFields ["body", "motivation", "selector", "source"] (markSubmitEventAdditionalProperties value)))
