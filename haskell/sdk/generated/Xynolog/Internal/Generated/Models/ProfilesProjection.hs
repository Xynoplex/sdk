-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.ProfilesProjection (ProfilesProjection (..), ProfilesProjectionProfiles (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Profile

data ProfilesProjection = ProfilesProjection
  { profilesProjectionProfiles :: ProfilesProjectionProfiles
  }
  deriving (Eq, Show)

instance FromJSON ProfilesProjection where parseJSON = checked "ProfilesProjection" $ withObject "ProfilesProjection" (\fields -> ProfilesProjection <$> (fields .: "profiles"))

instance ToJSON ProfilesProjection where toJSON value = Object (KM.fromList (concat [[("profiles", toJSON (profilesProjectionProfiles value))]]))

data ProfilesProjectionProfiles = ProfilesProjectionProfiles
  { profilesProjectionProfilesAdditionalProperties :: KM.KeyMap Profile
  }
  deriving (Eq, Show)

instance FromJSON ProfilesProjectionProfiles where parseJSON = checked "ProfilesProjectionProfiles" $ withObject "ProfilesProjectionProfiles" (\fields -> ProfilesProjectionProfiles <$> traverse parseJSON (withoutFields [] fields))

instance ToJSON ProfilesProjectionProfiles where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (profilesProjectionProfilesAdditionalProperties value)))
