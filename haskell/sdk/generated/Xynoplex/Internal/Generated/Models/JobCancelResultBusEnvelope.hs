-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.JobCancelResultBusEnvelope
  ( JobCancelResultBusEnvelope(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.JobCancelResult
data JobCancelResultBusEnvelope = JobCancelResultBusEnvelope { jobCancelResultBusEnvelopeResponse :: JobCancelResult } deriving (Eq, Show)
instance FromJSON JobCancelResultBusEnvelope where
  parseJSON = checked "JobCancelResultBusEnvelope" $ withObject "JobCancelResultBusEnvelope" (\fields -> JobCancelResultBusEnvelope <$> fields .: "response")
instance ToJSON JobCancelResultBusEnvelope where toJSON value = Object (KM.fromList (concat [[("response", toJSON (jobCancelResultBusEnvelopeResponse value))]]))
