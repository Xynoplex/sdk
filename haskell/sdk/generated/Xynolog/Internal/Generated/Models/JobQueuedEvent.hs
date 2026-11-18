-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.JobQueuedEvent (JobQueuedEvent (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.MarkJobQueuedEvent
import Xynolog.Internal.Generated.Models.YieldJobQueuedEvent

data JobQueuedEvent = JobQueuedEventBranch1 MarkJobQueuedEvent | JobQueuedEventBranch2 YieldJobQueuedEvent deriving (Eq, Show)

instance FromJSON JobQueuedEvent where parseJSON = checked "JobQueuedEvent" $ \value -> (JobQueuedEventBranch1 <$> parseJSON value) <|> (JobQueuedEventBranch2 <$> parseJSON value)

instance ToJSON JobQueuedEvent where
  toJSON (JobQueuedEventBranch1 value) = toJSON value
  toJSON (JobQueuedEventBranch2 value) = toJSON value
