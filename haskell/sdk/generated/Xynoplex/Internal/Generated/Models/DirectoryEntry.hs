-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.DirectoryEntry
  ( DirectoryEntry(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.DirEntry
import Xynoplex.Internal.Generated.Models.FileEntry
data DirectoryEntry = DirectoryEntryBranch1 (FileEntry) | DirectoryEntryBranch2 (DirEntry) deriving (Eq, Show)
instance FromJSON DirectoryEntry where
  parseJSON = checked "DirectoryEntry" $ \value -> (DirectoryEntryBranch1 <$> parseJSON value) <|> (DirectoryEntryBranch2 <$> parseJSON value)
instance ToJSON DirectoryEntry where
  toJSON (DirectoryEntryBranch1 value) = toJSON value
  toJSON (DirectoryEntryBranch2 value) = toJSON value
