-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.Agent (Agent(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AgentOrganization
import Xynolog.Internal.Generated.Models.AgentPerson
import Xynolog.Internal.Generated.Models.AgentSoftware
data Agent = AgentBranch1 AgentPerson | AgentBranch2 AgentOrganization | AgentBranch3 AgentSoftware deriving (Eq, Show)
instance FromJSON Agent where parseJSON = checked "Agent" $ \value -> (AgentBranch1 <$> parseJSON value) <|> (AgentBranch2 <$> parseJSON value) <|> (AgentBranch3 <$> parseJSON value)
instance ToJSON Agent where
  toJSON (AgentBranch1 value) = toJSON value
  toJSON (AgentBranch2 value) = toJSON value
  toJSON (AgentBranch3 value) = toJSON value
