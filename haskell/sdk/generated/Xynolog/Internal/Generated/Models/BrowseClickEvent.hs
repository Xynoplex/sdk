-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BrowseClickEvent (BrowseClickEvent (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnchorRect
import Xynolog.Internal.Generated.Models.AnnotationId

data BrowseClickEvent = BrowseClickEvent
  { browseClickEventAnchorRect :: Maybe AnchorRect,
    browseClickEventAnnotationId :: AnnotationId,
    browseClickEventAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BrowseClickEvent where parseJSON = checked "BrowseClickEvent" $ withObject "BrowseClickEvent" (\fields -> BrowseClickEvent <$> optional fields "anchorRect" <*> (fields .: "annotationId") <*> traverse parseJSON (withoutFields ["anchorRect", "annotationId"] fields))

instance ToJSON BrowseClickEvent where toJSON value = Object (KM.fromList (concat [optionalPair "anchorRect" (browseClickEventAnchorRect value), [("annotationId", toJSON (browseClickEventAnnotationId value))]]) <> fmap toJSON (withoutFields ["anchorRect", "annotationId"] (browseClickEventAdditionalProperties value)))
