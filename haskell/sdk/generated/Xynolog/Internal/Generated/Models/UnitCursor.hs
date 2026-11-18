-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.UnitCursor (UnitCursor (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data UnitCursor = UnitCursor
  { unitCursorEmitted :: Integer,
    unitCursorErrors :: Integer,
    unitCursorFound :: Integer,
    unitCursorNext :: Integer,
    unitCursorSize :: Integer,
    unitCursorAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON UnitCursor where parseJSON = checked "UnitCursor" $ withObject "UnitCursor" (\fields -> UnitCursor <$> (fields .: "emitted") <*> (fields .: "errors") <*> (fields .: "found") <*> (fields .: "next") <*> (fields .: "size") <*> traverse parseJSON (withoutFields ["emitted", "errors", "found", "next", "size"] fields))

instance ToJSON UnitCursor where toJSON value = Object (KM.fromList (concat [[("emitted", toJSON (unitCursorEmitted value))], [("errors", toJSON (unitCursorErrors value))], [("found", toJSON (unitCursorFound value))], [("next", toJSON (unitCursorNext value))], [("size", toJSON (unitCursorSize value))]]) <> fmap toJSON (withoutFields ["emitted", "errors", "found", "next", "size"] (unitCursorAdditionalProperties value)))
