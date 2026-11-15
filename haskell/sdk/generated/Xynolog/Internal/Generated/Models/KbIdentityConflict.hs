-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.KbIdentityConflict
  ( KbIdentityConflict(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data KbIdentityConflict = KbIdentityConflict { kbIdentityConflictExpectedDid :: Text, kbIdentityConflictObservedDid :: Text } deriving (Eq, Show)
instance FromJSON KbIdentityConflict where
  parseJSON = checked "KbIdentityConflict" $ withObject "KbIdentityConflict" (\fields -> KbIdentityConflict <$> fields .: "expectedDid" <*> fields .: "observedDid")
instance ToJSON KbIdentityConflict where toJSON value = Object (KM.fromList (concat [[("expectedDid", toJSON (kbIdentityConflictExpectedDid value))], [("observedDid", toJSON (kbIdentityConflictObservedDid value))]]))
