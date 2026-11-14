-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.BrowsePanelOpenEvent
  ( BrowsePanelOpenEvent(..)
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
import Xynoplex.Internal.Generated.Models.Motivation
data BrowsePanelOpenEvent = BrowsePanelOpenEvent { browsePanelOpenEventMotivation :: Maybe (Motivation), browsePanelOpenEventPanel :: Text, browsePanelOpenEventScrollToAnnotationId :: Maybe (AnnotationId), browsePanelOpenEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowsePanelOpenEvent where
  parseJSON = checked "BrowsePanelOpenEvent" $ withObject "BrowsePanelOpenEvent" (\fields -> BrowsePanelOpenEvent <$> optional fields "motivation" <*> fields .: "panel" <*> optional fields "scrollToAnnotationId" <*> traverse parseJSON (withoutFields ["motivation", "panel", "scrollToAnnotationId"] fields))
instance ToJSON BrowsePanelOpenEvent where toJSON value = Object (KM.fromList (concat [optionalPair "motivation" (browsePanelOpenEventMotivation value), [("panel", toJSON (browsePanelOpenEventPanel value))], optionalPair "scrollToAnnotationId" (browsePanelOpenEventScrollToAnnotationId value)]) <> fmap toJSON (withoutFields ["motivation", "panel", "scrollToAnnotationId"] (browsePanelOpenEventAdditionalProperties value)))
