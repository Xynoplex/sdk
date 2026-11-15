-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.EmptyBusPayload
  ( EmptyBusPayload(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data EmptyBusPayload = EmptyBusPayload deriving (Eq, Show)
instance FromJSON EmptyBusPayload where
  parseJSON = checked "EmptyBusPayload" $ withObject "EmptyBusPayload" (\_ -> pure EmptyBusPayload)
instance ToJSON EmptyBusPayload where toJSON _ = Object (KM.fromList (concat []))
