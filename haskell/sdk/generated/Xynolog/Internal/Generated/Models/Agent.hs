-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.Agent
  ( Agent(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.AgentOrganization
import Xynolog.Internal.Generated.Models.AgentPerson
import Xynolog.Internal.Generated.Models.AgentSoftware
data Agent = AgentBranch1 (AgentPerson) | AgentBranch2 (AgentOrganization) | AgentBranch3 (AgentSoftware) deriving (Eq, Show)
instance FromJSON Agent where
  parseJSON = checked "Agent" $ \value -> (AgentBranch1 <$> parseJSON value) <|> (AgentBranch2 <$> parseJSON value) <|> (AgentBranch3 <$> parseJSON value)
instance ToJSON Agent where
  toJSON (AgentBranch1 value) = toJSON value
  toJSON (AgentBranch2 value) = toJSON value
  toJSON (AgentBranch3 value) = toJSON value
