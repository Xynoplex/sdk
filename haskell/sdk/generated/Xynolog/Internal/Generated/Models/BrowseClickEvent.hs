-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BrowseClickEvent
  ( BrowseClickEvent(..)
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
data BrowseClickEvent = BrowseClickEvent { browseClickEventAnnotationId :: AnnotationId, browseClickEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseClickEvent where
  parseJSON = checked "BrowseClickEvent" $ withObject "BrowseClickEvent" (\fields -> BrowseClickEvent <$> fields .: "annotationId" <*> traverse parseJSON (withoutFields ["annotationId"] fields))
instance ToJSON BrowseClickEvent where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (browseClickEventAnnotationId value))]]) <> fmap toJSON (withoutFields ["annotationId"] (browseClickEventAdditionalProperties value)))
