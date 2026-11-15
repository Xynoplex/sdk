-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.JobFilter
  ( JobFilter(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.MarkJobFilter
import Xynolog.Internal.Generated.Models.YieldJobFilter
data JobFilter = JobFilterBranch1 (MarkJobFilter) | JobFilterBranch2 (YieldJobFilter) deriving (Eq, Show)
instance FromJSON JobFilter where
  parseJSON = checked "JobFilter" $ \value -> (JobFilterBranch1 <$> parseJSON value) <|> (JobFilterBranch2 <$> parseJSON value)
instance ToJSON JobFilter where
  toJSON (JobFilterBranch1 value) = toJSON value
  toJSON (JobFilterBranch2 value) = toJSON value
