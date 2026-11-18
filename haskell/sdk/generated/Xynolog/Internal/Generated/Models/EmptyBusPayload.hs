-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.EmptyBusPayload (EmptyBusPayload (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject)
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data EmptyBusPayload = EmptyBusPayload deriving (Eq, Show)

instance FromJSON EmptyBusPayload where parseJSON = checked "EmptyBusPayload" $ withObject "EmptyBusPayload" (\_ -> pure EmptyBusPayload)

instance ToJSON EmptyBusPayload where toJSON _ = Object (KM.fromList (concat []))
