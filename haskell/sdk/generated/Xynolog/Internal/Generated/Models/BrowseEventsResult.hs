-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BrowseEventsResult
  ( BrowseEventsResult(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.GetEventsResponse
data BrowseEventsResult = BrowseEventsResult { browseEventsResultResponse :: GetEventsResponse, browseEventsResultAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseEventsResult where
  parseJSON = checked "BrowseEventsResult" $ withObject "BrowseEventsResult" (\fields -> BrowseEventsResult <$> fields .: "response" <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON BrowseEventsResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (browseEventsResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (browseEventsResultAdditionalProperties value)))
