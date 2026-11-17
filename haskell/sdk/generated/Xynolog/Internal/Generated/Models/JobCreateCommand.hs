-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobCreateCommand (JobCreateCommand(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.MarkJobCreateCommand
import Xynolog.Internal.Generated.Models.YieldJobCreateCommand
data JobCreateCommand = JobCreateCommandBranch1 MarkJobCreateCommand | JobCreateCommandBranch2 YieldJobCreateCommand deriving (Eq, Show)
instance FromJSON JobCreateCommand where parseJSON = checked "JobCreateCommand" $ \value -> (JobCreateCommandBranch1 <$> parseJSON value) <|> (JobCreateCommandBranch2 <$> parseJSON value)
instance ToJSON JobCreateCommand where
  toJSON (JobCreateCommandBranch1 value) = toJSON value
  toJSON (JobCreateCommandBranch2 value) = toJSON value
