-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.OneOrMoreAgents (OneOrMoreAgents (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Agent

data OneOrMoreAgents = OneOrMoreAgentsBranch1 Agent | OneOrMoreAgentsBranch2 [Agent] deriving (Eq, Show)

instance FromJSON OneOrMoreAgents where parseJSON = checked "OneOrMoreAgents" $ \value -> (OneOrMoreAgentsBranch1 <$> parseJSON value) <|> (OneOrMoreAgentsBranch2 <$> parseJSON value)

instance ToJSON OneOrMoreAgents where
  toJSON (OneOrMoreAgentsBranch1 value) = toJSON value
  toJSON (OneOrMoreAgentsBranch2 value) = toJSON value
