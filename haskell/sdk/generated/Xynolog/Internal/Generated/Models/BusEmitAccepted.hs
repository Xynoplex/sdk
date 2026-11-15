-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.BusEmitAccepted
  ( BusEmitAccepted(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data BusEmitAccepted = BusEmitAccepted { busEmitAcceptedSubscribers :: Maybe (Integer), busEmitAcceptedAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BusEmitAccepted where
  parseJSON = checked "BusEmitAccepted" $ withObject "BusEmitAccepted" (\fields -> BusEmitAccepted <$> optional fields "subscribers" <*> traverse parseJSON (withoutFields ["subscribers"] fields))
instance ToJSON BusEmitAccepted where toJSON value = Object (KM.fromList (concat [optionalPair "subscribers" (busEmitAcceptedSubscribers value)]) <> fmap toJSON (withoutFields ["subscribers"] (busEmitAcceptedAdditionalProperties value)))
