-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.LogFormat
  ( LogFormat(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data LogFormat = LogFormatJson | LogFormatSimple deriving (Eq, Show)
instance FromJSON LogFormat where
  parseJSON = checked "LogFormat" $ \value -> if value == (String "json") then pure LogFormatJson else if value == (String "simple") then pure LogFormatSimple else fail "unknown enumeration member"
instance ToJSON LogFormat where
  toJSON LogFormatJson = String "json"
  toJSON LogFormatSimple = String "simple"
