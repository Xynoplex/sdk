-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowsePanelOpenEvent (BrowsePanelOpenEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
import Xynolog.Internal.Generated.Models.Motivation
data BrowsePanelOpenEvent = BrowsePanelOpenEvent
  { browsePanelOpenEventMotivation :: Maybe Motivation
  , browsePanelOpenEventPanel :: Text
  , browsePanelOpenEventScrollToAnnotationId :: Maybe AnnotationId
  , browsePanelOpenEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BrowsePanelOpenEvent where parseJSON = checked "BrowsePanelOpenEvent" $ withObject "BrowsePanelOpenEvent" (\fields -> BrowsePanelOpenEvent <$> optional fields "motivation" <*> (fields .: "panel") <*> optional fields "scrollToAnnotationId" <*> traverse parseJSON (withoutFields ["motivation", "panel", "scrollToAnnotationId"] fields))
instance ToJSON BrowsePanelOpenEvent where toJSON value = Object (KM.fromList (concat [optionalPair "motivation" (browsePanelOpenEventMotivation value), [("panel", toJSON (browsePanelOpenEventPanel value))], optionalPair "scrollToAnnotationId" (browsePanelOpenEventScrollToAnnotationId value)]) <> fmap toJSON (withoutFields ["motivation", "panel", "scrollToAnnotationId"] (browsePanelOpenEventAdditionalProperties value)))
