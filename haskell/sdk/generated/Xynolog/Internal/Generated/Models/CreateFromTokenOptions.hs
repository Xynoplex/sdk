-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.CreateFromTokenOptions (CreateFromTokenOptions (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data CreateFromTokenOptions = CreateFromTokenOptions
  { createFromTokenOptionsArchiveOriginal :: Maybe Bool,
    createFromTokenOptionsContent :: Text,
    createFromTokenOptionsName :: Text,
    createFromTokenOptionsToken :: Text
  }
  deriving (Eq, Show)

instance FromJSON CreateFromTokenOptions where parseJSON = checked "CreateFromTokenOptions" $ withObject "CreateFromTokenOptions" (\fields -> CreateFromTokenOptions <$> optional fields "archiveOriginal" <*> (fields .: "content") <*> (fields .: "name") <*> (fields .: "token"))

instance ToJSON CreateFromTokenOptions where toJSON value = Object (KM.fromList (concat [optionalPair "archiveOriginal" (createFromTokenOptionsArchiveOriginal value), [("content", toJSON (createFromTokenOptionsContent value))], [("name", toJSON (createFromTokenOptionsName value))], [("token", toJSON (createFromTokenOptionsToken value))]]))
