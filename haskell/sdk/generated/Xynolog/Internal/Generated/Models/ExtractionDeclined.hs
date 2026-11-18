-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.ExtractionDeclined (ExtractionDeclined (..), ExtractionDeclinedDeclined (..), ExtractionDeclinedKind (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data ExtractionDeclined = ExtractionDeclined
  { extractionDeclinedDeclined :: ExtractionDeclinedDeclined,
    extractionDeclinedKind :: ExtractionDeclinedKind,
    extractionDeclinedAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON ExtractionDeclined where parseJSON = checked "ExtractionDeclined" $ withObject "ExtractionDeclined" (\fields -> ExtractionDeclined <$> (fields .: "declined") <*> (fields .: "kind") <*> traverse parseJSON (withoutFields ["declined", "kind"] fields))

instance ToJSON ExtractionDeclined where toJSON value = Object (KM.fromList (concat [[("declined", toJSON (extractionDeclinedDeclined value))], [("kind", toJSON (extractionDeclinedKind value))]]) <> fmap toJSON (withoutFields ["declined", "kind"] (extractionDeclinedAdditionalProperties value)))

data ExtractionDeclinedDeclined = ExtractionDeclinedDeclinedNoU2d_textU2d_layer | ExtractionDeclinedDeclinedEncrypted | ExtractionDeclinedDeclinedCorrupt | ExtractionDeclinedDeclinedTooU2d_large deriving (Eq, Show)

instance FromJSON ExtractionDeclinedDeclined where parseJSON = checked "ExtractionDeclinedDeclined" $ \value -> if value == String "no-text-layer" then pure ExtractionDeclinedDeclinedNoU2d_textU2d_layer else if value == String "encrypted" then pure ExtractionDeclinedDeclinedEncrypted else if value == String "corrupt" then pure ExtractionDeclinedDeclinedCorrupt else if value == String "too-large" then pure ExtractionDeclinedDeclinedTooU2d_large else fail "unknown enumeration member"

instance ToJSON ExtractionDeclinedDeclined where
  toJSON ExtractionDeclinedDeclinedNoU2d_textU2d_layer = String "no-text-layer"
  toJSON ExtractionDeclinedDeclinedEncrypted = String "encrypted"
  toJSON ExtractionDeclinedDeclinedCorrupt = String "corrupt"
  toJSON ExtractionDeclinedDeclinedTooU2d_large = String "too-large"

data ExtractionDeclinedKind = ExtractionDeclinedKindDeclined deriving (Eq, Show)

instance FromJSON ExtractionDeclinedKind where parseJSON = checked "ExtractionDeclinedKind" $ \value -> if value == String "declined" then pure ExtractionDeclinedKindDeclined else fail "unknown enumeration member"

instance ToJSON ExtractionDeclinedKind where toJSON ExtractionDeclinedKindDeclined = String "declined"
