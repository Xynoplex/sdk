-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.KbIdentity (KbIdentity (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data KbIdentity = KbIdentity
  { kbIdentityDomain :: Text,
    kbIdentityName :: Text
  }
  deriving (Eq, Show)

instance FromJSON KbIdentity where parseJSON = checked "KbIdentity" $ withObject "KbIdentity" (\fields -> KbIdentity <$> (fields .: "domain") <*> (fields .: "name"))

instance ToJSON KbIdentity where toJSON value = Object (KM.fromList (concat [[("domain", toJSON (kbIdentityDomain value))], [("name", toJSON (kbIdentityName value))]]))
