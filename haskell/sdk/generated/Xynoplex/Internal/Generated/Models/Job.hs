-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.Job
  ( Job(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.JobCancelled
import Xynoplex.Internal.Generated.Models.JobComplete
import Xynoplex.Internal.Generated.Models.JobFailed
import Xynoplex.Internal.Generated.Models.JobPending
import Xynoplex.Internal.Generated.Models.JobRunning
data Job = JobBranch1 (JobPending) | JobBranch2 (JobRunning) | JobBranch3 (JobComplete) | JobBranch4 (JobFailed) | JobBranch5 (JobCancelled) deriving (Eq, Show)
instance FromJSON Job where
  parseJSON = checked "Job" $ \value -> (JobBranch1 <$> parseJSON value) <|> (JobBranch2 <$> parseJSON value) <|> (JobBranch3 <$> parseJSON value) <|> (JobBranch4 <$> parseJSON value) <|> (JobBranch5 <$> parseJSON value)
instance ToJSON Job where
  toJSON (JobBranch1 value) = toJSON value
  toJSON (JobBranch2 value) = toJSON value
  toJSON (JobBranch3 value) = toJSON value
  toJSON (JobBranch4 value) = toJSON value
  toJSON (JobBranch5 value) = toJSON value
