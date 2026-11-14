-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.JobQueuedEvent
  ( JobQueuedEvent(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.MarkJobQueuedEvent
import Xynoplex.Internal.Generated.Models.YieldJobQueuedEvent
data JobQueuedEvent = JobQueuedEventBranch1 (MarkJobQueuedEvent) | JobQueuedEventBranch2 (YieldJobQueuedEvent) deriving (Eq, Show)
instance FromJSON JobQueuedEvent where
  parseJSON = checked "JobQueuedEvent" $ \value -> (JobQueuedEventBranch1 <$> parseJSON value) <|> (JobQueuedEventBranch2 <$> parseJSON value)
instance ToJSON JobQueuedEvent where
  toJSON (JobQueuedEventBranch1 value) = toJSON value
  toJSON (JobQueuedEventBranch2 value) = toJSON value
