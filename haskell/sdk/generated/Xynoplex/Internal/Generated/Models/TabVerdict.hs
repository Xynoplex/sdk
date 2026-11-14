-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.TabVerdict
  ( TabVerdict(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data TabVerdict = TabVerdictGone | TabVerdictReady | TabVerdictUnknown deriving (Eq, Show)
instance FromJSON TabVerdict where
  parseJSON = checked "TabVerdict" $ \value -> if value == (String "gone") then pure TabVerdictGone else if value == (String "ready") then pure TabVerdictReady else if value == (String "unknown") then pure TabVerdictUnknown else fail "unknown enumeration member"
instance ToJSON TabVerdict where
  toJSON TabVerdictGone = String "gone"
  toJSON TabVerdictReady = String "ready"
  toJSON TabVerdictUnknown = String "unknown"
