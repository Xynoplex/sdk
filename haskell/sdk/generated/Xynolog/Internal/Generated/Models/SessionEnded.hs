-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.SessionEnded (SessionEnded (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.SessionEndReason

data SessionEnded = SessionEnded
  { sessionEndedReason :: SessionEndReason
  }
  deriving (Eq, Show)

instance FromJSON SessionEnded where parseJSON = checked "SessionEnded" $ withObject "SessionEnded" (\fields -> SessionEnded <$> (fields .: "reason"))

instance ToJSON SessionEnded where toJSON value = Object (KM.fromList (concat [[("reason", toJSON (sessionEndedReason value))]]))
