-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.MarkSubmitEvent (MarkSubmitEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationBodies
import Xynolog.Internal.Generated.Models.AnnotationSelector
import Xynolog.Internal.Generated.Models.Motivation
import Xynolog.Internal.Generated.Models.ResourceId
data MarkSubmitEvent = MarkSubmitEvent
  { markSubmitEventBody :: Maybe AnnotationBodies
  , markSubmitEventMotivation :: Motivation
  , markSubmitEventSelector :: AnnotationSelector
  , markSubmitEventSource :: ResourceId
  , markSubmitEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON MarkSubmitEvent where parseJSON = checked "MarkSubmitEvent" $ withObject "MarkSubmitEvent" (\fields -> MarkSubmitEvent <$> optional fields "body" <*> (fields .: "motivation") <*> (fields .: "selector") <*> (fields .: "source") <*> traverse parseJSON (withoutFields ["body", "motivation", "selector", "source"] fields))
instance ToJSON MarkSubmitEvent where toJSON value = Object (KM.fromList (concat [optionalPair "body" (markSubmitEventBody value), [("motivation", toJSON (markSubmitEventMotivation value))], [("selector", toJSON (markSubmitEventSelector value))], [("source", toJSON (markSubmitEventSource value))]]) <> fmap toJSON (withoutFields ["body", "motivation", "selector", "source"] (markSubmitEventAdditionalProperties value)))
