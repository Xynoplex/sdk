-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.ClaimOptions (ClaimOptions (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobFilter

data ClaimOptions = ClaimOptions
  { claimOptionsAccepts :: [JobFilter],
    claimOptionsHeldJobStallCheckMs :: Maybe Integer,
    claimOptionsHeldJobStallMs :: Maybe Integer,
    claimOptionsJobClaimTimeoutMs :: Maybe Integer,
    claimOptionsMarkCommitTimeoutMs :: Maybe Integer
  }
  deriving (Eq, Show)

instance FromJSON ClaimOptions where parseJSON = checked "ClaimOptions" $ withObject "ClaimOptions" (\fields -> ClaimOptions <$> (fields .: "accepts") <*> optional fields "heldJobStallCheckMs" <*> optional fields "heldJobStallMs" <*> optional fields "jobClaimTimeoutMs" <*> optional fields "markCommitTimeoutMs")

instance ToJSON ClaimOptions where toJSON value = Object (KM.fromList (concat [[("accepts", toJSON (claimOptionsAccepts value))], optionalPair "heldJobStallCheckMs" (claimOptionsHeldJobStallCheckMs value), optionalPair "heldJobStallMs" (claimOptionsHeldJobStallMs value), optionalPair "jobClaimTimeoutMs" (claimOptionsJobClaimTimeoutMs value), optionalPair "markCommitTimeoutMs" (claimOptionsMarkCommitTimeoutMs value)]))
