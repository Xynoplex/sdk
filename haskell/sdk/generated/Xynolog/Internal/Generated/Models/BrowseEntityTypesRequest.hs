-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BrowseEntityTypesRequest
  ( BrowseEntityTypesRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data BrowseEntityTypesRequest = BrowseEntityTypesRequest { browseEntityTypesRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseEntityTypesRequest where
  parseJSON = checked "BrowseEntityTypesRequest" $ withObject "BrowseEntityTypesRequest" (\fields -> BrowseEntityTypesRequest <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON BrowseEntityTypesRequest where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (browseEntityTypesRequestAdditionalProperties value)))
