-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.MarkRequestedEvent
  ( MarkRequestedEvent(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.AnnotationSelector
import Xynolog.Internal.Generated.Models.Motivation
import Xynolog.Internal.Generated.Models.ResourceId
data MarkRequestedEvent = MarkRequestedEvent { markRequestedEventMotivation :: Motivation, markRequestedEventSelector :: AnnotationSelector, markRequestedEventSource :: ResourceId, markRequestedEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON MarkRequestedEvent where
  parseJSON = checked "MarkRequestedEvent" $ withObject "MarkRequestedEvent" (\fields -> MarkRequestedEvent <$> fields .: "motivation" <*> fields .: "selector" <*> fields .: "source" <*> traverse parseJSON (withoutFields ["motivation", "selector", "source"] fields))
instance ToJSON MarkRequestedEvent where toJSON value = Object (KM.fromList (concat [[("motivation", toJSON (markRequestedEventMotivation value))], [("selector", toJSON (markRequestedEventSelector value))], [("source", toJSON (markRequestedEventSource value))]]) <> fmap toJSON (withoutFields ["motivation", "selector", "source"] (markRequestedEventAdditionalProperties value)))
