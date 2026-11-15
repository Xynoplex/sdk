-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BrowseKbRequest
  ( BrowseKbRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data BrowseKbRequest = BrowseKbRequest { browseKbRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowseKbRequest where
  parseJSON = checked "BrowseKbRequest" $ withObject "BrowseKbRequest" (\fields -> BrowseKbRequest <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON BrowseKbRequest where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (browseKbRequestAdditionalProperties value)))
