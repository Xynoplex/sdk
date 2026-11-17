-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowseFilesResponse (BrowseFilesResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.DirectoryEntry
data BrowseFilesResponse = BrowseFilesResponse
  { browseFilesResponseEntries :: [DirectoryEntry]
  , browseFilesResponsePath :: Text
  } deriving (Eq, Show)
instance FromJSON BrowseFilesResponse where parseJSON = checked "BrowseFilesResponse" $ withObject "BrowseFilesResponse" (\fields -> BrowseFilesResponse <$> (fields .: "entries") <*> (fields .: "path"))
instance ToJSON BrowseFilesResponse where toJSON value = Object (KM.fromList (concat [[("entries", toJSON (browseFilesResponseEntries value))], [("path", toJSON (browseFilesResponsePath value))]]))
