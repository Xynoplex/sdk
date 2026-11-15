-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.SessionEndReason
  ( SessionEndReason(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data SessionEndReason = SessionEndReasonExpired | SessionEndReasonRefused deriving (Eq, Show)
instance FromJSON SessionEndReason where
  parseJSON = checked "SessionEndReason" $ \value -> if value == (String "expired") then pure SessionEndReasonExpired else if value == (String "refused") then pure SessionEndReasonRefused else fail "unknown enumeration member"
instance ToJSON SessionEndReason where
  toJSON SessionEndReasonExpired = String "expired"
  toJSON SessionEndReasonRefused = String "refused"
