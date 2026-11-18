-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BusEmitAccepted (BusEmitAccepted (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject)
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data BusEmitAccepted = BusEmitAccepted
  { busEmitAcceptedSubscribers :: Maybe Integer,
    busEmitAcceptedAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BusEmitAccepted where parseJSON = checked "BusEmitAccepted" $ withObject "BusEmitAccepted" (\fields -> BusEmitAccepted <$> optional fields "subscribers" <*> traverse parseJSON (withoutFields ["subscribers"] fields))

instance ToJSON BusEmitAccepted where toJSON value = Object (KM.fromList (concat [optionalPair "subscribers" (busEmitAcceptedSubscribers value)]) <> fmap toJSON (withoutFields ["subscribers"] (busEmitAcceptedAdditionalProperties value)))
