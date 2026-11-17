-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.DirectoryEntry (DirectoryEntry(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.DirEntry
import Xynolog.Internal.Generated.Models.FileEntry
data DirectoryEntry = DirectoryEntryBranch1 FileEntry | DirectoryEntryBranch2 DirEntry deriving (Eq, Show)
instance FromJSON DirectoryEntry where parseJSON = checked "DirectoryEntry" $ \value -> (DirectoryEntryBranch1 <$> parseJSON value) <|> (DirectoryEntryBranch2 <$> parseJSON value)
instance ToJSON DirectoryEntry where
  toJSON (DirectoryEntryBranch1 value) = toJSON value
  toJSON (DirectoryEntryBranch2 value) = toJSON value
