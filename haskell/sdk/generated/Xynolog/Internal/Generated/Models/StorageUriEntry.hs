-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.StorageUriEntry (StorageUriEntry (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId

data StorageUriEntry = StorageUriEntry
  { storageUriEntryResourceId :: ResourceId,
    storageUriEntryUri :: Text
  }
  deriving (Eq, Show)

instance FromJSON StorageUriEntry where parseJSON = checked "StorageUriEntry" $ withObject "StorageUriEntry" (\fields -> StorageUriEntry <$> (fields .: "resourceId") <*> (fields .: "uri"))

instance ToJSON StorageUriEntry where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (storageUriEntryResourceId value))], [("uri", toJSON (storageUriEntryUri value))]]))
