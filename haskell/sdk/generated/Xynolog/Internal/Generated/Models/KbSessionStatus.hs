-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.KbSessionStatus (KbSessionStatus (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..))
import Xynolog.Internal.Codec

data KbSessionStatus = KbSessionStatusAuthenticated | KbSessionStatusExpired | KbSessionStatusSignedU2d_out deriving (Eq, Show)

instance FromJSON KbSessionStatus where parseJSON = checked "KbSessionStatus" $ \value -> if value == String "authenticated" then pure KbSessionStatusAuthenticated else if value == String "expired" then pure KbSessionStatusExpired else if value == String "signed-out" then pure KbSessionStatusSignedU2d_out else fail "unknown enumeration member"

instance ToJSON KbSessionStatus where
  toJSON KbSessionStatusAuthenticated = String "authenticated"
  toJSON KbSessionStatusExpired = String "expired"
  toJSON KbSessionStatusSignedU2d_out = String "signed-out"
