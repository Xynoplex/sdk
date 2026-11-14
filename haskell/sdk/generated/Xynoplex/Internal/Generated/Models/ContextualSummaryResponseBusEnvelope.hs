-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.ContextualSummaryResponseBusEnvelope
  ( ContextualSummaryResponseBusEnvelope(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.ContextualSummaryResponse
data ContextualSummaryResponseBusEnvelope = ContextualSummaryResponseBusEnvelope { contextualSummaryResponseBusEnvelopeResponse :: ContextualSummaryResponse } deriving (Eq, Show)
instance FromJSON ContextualSummaryResponseBusEnvelope where
  parseJSON = checked "ContextualSummaryResponseBusEnvelope" $ withObject "ContextualSummaryResponseBusEnvelope" (\fields -> ContextualSummaryResponseBusEnvelope <$> fields .: "response")
instance ToJSON ContextualSummaryResponseBusEnvelope where toJSON value = Object (KM.fromList (concat [[("response", toJSON (contextualSummaryResponseBusEnvelopeResponse value))]]))
