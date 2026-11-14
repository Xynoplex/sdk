-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.KbEndpoint
  ( KbEndpoint(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.HttpEndpoint
import Xynoplex.Internal.Generated.Models.LocalEndpoint
data KbEndpoint = KbEndpointBranch1 (HttpEndpoint) | KbEndpointBranch2 (LocalEndpoint) deriving (Eq, Show)
instance FromJSON KbEndpoint where
  parseJSON = checked "KbEndpoint" $ \value -> (KbEndpointBranch1 <$> parseJSON value) <|> (KbEndpointBranch2 <$> parseJSON value)
instance ToJSON KbEndpoint where
  toJSON (KbEndpointBranch1 value) = toJSON value
  toJSON (KbEndpointBranch2 value) = toJSON value
