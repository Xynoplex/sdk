-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.BrowseFilesResponse
  ( BrowseFilesResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.DirectoryEntry
data BrowseFilesResponse = BrowseFilesResponse { browseFilesResponseEntries :: [DirectoryEntry], browseFilesResponsePath :: Text } deriving (Eq, Show)
instance FromJSON BrowseFilesResponse where
  parseJSON = checked "BrowseFilesResponse" $ withObject "BrowseFilesResponse" (\fields -> BrowseFilesResponse <$> fields .: "entries" <*> fields .: "path")
instance ToJSON BrowseFilesResponse where toJSON value = Object (KM.fromList (concat [[("entries", toJSON (browseFilesResponseEntries value))], [("path", toJSON (browseFilesResponsePath value))]]))
