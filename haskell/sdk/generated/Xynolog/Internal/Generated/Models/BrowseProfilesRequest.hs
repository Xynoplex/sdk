-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BrowseProfilesRequest
  ( BrowseProfilesRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.UserId
data BrowseProfilesRequest = BrowseProfilesRequest { browseProfilesRequestDids :: [UserId] } deriving (Eq, Show)
instance FromJSON BrowseProfilesRequest where
  parseJSON = checked "BrowseProfilesRequest" $ withObject "BrowseProfilesRequest" (\fields -> BrowseProfilesRequest <$> fields .: "dids")
instance ToJSON BrowseProfilesRequest where toJSON value = Object (KM.fromList (concat [[("dids", toJSON (browseProfilesRequestDids value))]]))
