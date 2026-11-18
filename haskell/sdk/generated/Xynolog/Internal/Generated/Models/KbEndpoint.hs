-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.KbEndpoint (KbEndpoint(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.HttpEndpoint
import Xynolog.Internal.Generated.Models.LocalEndpoint
data KbEndpoint = KbEndpointBranch1 HttpEndpoint | KbEndpointBranch2 LocalEndpoint deriving (Eq, Show)
instance FromJSON KbEndpoint where parseJSON = checked "KbEndpoint" $ \value -> (KbEndpointBranch1 <$> parseJSON value) <|> (KbEndpointBranch2 <$> parseJSON value)
instance ToJSON KbEndpoint where
  toJSON (KbEndpointBranch1 value) = toJSON value
  toJSON (KbEndpointBranch2 value) = toJSON value
