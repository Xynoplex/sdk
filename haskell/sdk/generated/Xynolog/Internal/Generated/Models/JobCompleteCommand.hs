-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobCompleteCommand (JobCompleteCommand(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.MarkJobCompleteCommand
import Xynolog.Internal.Generated.Models.YieldJobCompleteCommand
data JobCompleteCommand = JobCompleteCommandBranch1 MarkJobCompleteCommand | JobCompleteCommandBranch2 YieldJobCompleteCommand deriving (Eq, Show)
instance FromJSON JobCompleteCommand where parseJSON = checked "JobCompleteCommand" $ \value -> (JobCompleteCommandBranch1 <$> parseJSON value) <|> (JobCompleteCommandBranch2 <$> parseJSON value)
instance ToJSON JobCompleteCommand where
  toJSON (JobCompleteCommandBranch1 value) = toJSON value
  toJSON (JobCompleteCommandBranch2 value) = toJSON value
