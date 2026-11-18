-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.Profile (Profile (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data Profile = Profile
  { profileName :: Text,
    profileSince :: Text
  }
  deriving (Eq, Show)

instance FromJSON Profile where parseJSON = checked "Profile" $ withObject "Profile" (\fields -> Profile <$> (fields .: "name") <*> (fields .: "since"))

instance ToJSON Profile where toJSON value = Object (KM.fromList (concat [[("name", toJSON (profileName value))], [("since", toJSON (profileSince value))]]))
