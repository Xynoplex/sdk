-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowseProfilesResult (BrowseProfilesResult(..), BrowseProfilesResultResponse(..), BrowseProfilesResultResponseProfiles(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Profile
data BrowseProfilesResult = BrowseProfilesResult
  { browseProfilesResultResponse :: BrowseProfilesResultResponse
  , browseProfilesResultAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BrowseProfilesResult where parseJSON = checked "BrowseProfilesResult" $ withObject "BrowseProfilesResult" (\fields -> BrowseProfilesResult <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON BrowseProfilesResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (browseProfilesResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (browseProfilesResultAdditionalProperties value)))
data BrowseProfilesResultResponse = BrowseProfilesResultResponse
  { browseProfilesResultResponseProfiles :: BrowseProfilesResultResponseProfiles
  } deriving (Eq, Show)
instance FromJSON BrowseProfilesResultResponse where parseJSON = checked "BrowseProfilesResultResponse" $ withObject "BrowseProfilesResultResponse" (\fields -> BrowseProfilesResultResponse <$> (fields .: "profiles"))
instance ToJSON BrowseProfilesResultResponse where toJSON value = Object (KM.fromList (concat [[("profiles", toJSON (browseProfilesResultResponseProfiles value))]]))
data BrowseProfilesResultResponseProfiles = BrowseProfilesResultResponseProfiles
  { browseProfilesResultResponseProfilesAdditionalProperties :: KM.KeyMap Profile
  } deriving (Eq, Show)
instance FromJSON BrowseProfilesResultResponseProfiles where parseJSON = checked "BrowseProfilesResultResponseProfiles" $ withObject "BrowseProfilesResultResponseProfiles" (\fields -> BrowseProfilesResultResponseProfiles <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON BrowseProfilesResultResponseProfiles where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (browseProfilesResultResponseProfilesAdditionalProperties value)))
