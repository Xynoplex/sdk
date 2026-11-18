-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.KbIdentityConflict (KbIdentityConflict (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data KbIdentityConflict = KbIdentityConflict
  { kbIdentityConflictExpectedDid :: Text,
    kbIdentityConflictObservedDid :: Text
  }
  deriving (Eq, Show)

instance FromJSON KbIdentityConflict where parseJSON = checked "KbIdentityConflict" $ withObject "KbIdentityConflict" (\fields -> KbIdentityConflict <$> (fields .: "expectedDid") <*> (fields .: "observedDid"))

instance ToJSON KbIdentityConflict where toJSON value = Object (KM.fromList (concat [[("expectedDid", toJSON (kbIdentityConflictExpectedDid value))], [("observedDid", toJSON (kbIdentityConflictObservedDid value))]]))
