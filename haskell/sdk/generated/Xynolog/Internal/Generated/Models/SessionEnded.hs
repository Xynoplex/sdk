-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.SessionEnded
  ( SessionEnded(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.SessionEndReason
data SessionEnded = SessionEnded { sessionEndedReason :: SessionEndReason } deriving (Eq, Show)
instance FromJSON SessionEnded where
  parseJSON = checked "SessionEnded" $ withObject "SessionEnded" (\fields -> SessionEnded <$> fields .: "reason")
instance ToJSON SessionEnded where toJSON value = Object (KM.fromList (concat [[("reason", toJSON (sessionEndedReason value))]]))
