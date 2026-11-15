-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BrowseEnginesRequest
  ( BrowseEnginesRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data BrowseEnginesRequest = BrowseEnginesRequest { browseEnginesRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseEnginesRequest where
  parseJSON = checked "BrowseEnginesRequest" $ withObject "BrowseEnginesRequest" (\fields -> BrowseEnginesRequest <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON BrowseEnginesRequest where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (browseEnginesRequestAdditionalProperties value)))
