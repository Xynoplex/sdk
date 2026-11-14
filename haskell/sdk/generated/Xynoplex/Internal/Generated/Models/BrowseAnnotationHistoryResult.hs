-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.BrowseAnnotationHistoryResult
  ( BrowseAnnotationHistoryResult(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.GetAnnotationHistoryResponse
data BrowseAnnotationHistoryResult = BrowseAnnotationHistoryResult { browseAnnotationHistoryResultResponse :: GetAnnotationHistoryResponse, browseAnnotationHistoryResultAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseAnnotationHistoryResult where
  parseJSON = checked "BrowseAnnotationHistoryResult" $ withObject "BrowseAnnotationHistoryResult" (\fields -> BrowseAnnotationHistoryResult <$> fields .: "response" <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON BrowseAnnotationHistoryResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (browseAnnotationHistoryResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (browseAnnotationHistoryResultAdditionalProperties value)))
