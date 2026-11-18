-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.JobCancelResultBusEnvelope (JobCancelResultBusEnvelope (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobCancelResult

data JobCancelResultBusEnvelope = JobCancelResultBusEnvelope
  { jobCancelResultBusEnvelopeResponse :: JobCancelResult
  }
  deriving (Eq, Show)

instance FromJSON JobCancelResultBusEnvelope where parseJSON = checked "JobCancelResultBusEnvelope" $ withObject "JobCancelResultBusEnvelope" (\fields -> JobCancelResultBusEnvelope <$> (fields .: "response"))

instance ToJSON JobCancelResultBusEnvelope where toJSON value = Object (KM.fromList (concat [[("response", toJSON (jobCancelResultBusEnvelopeResponse value))]]))
