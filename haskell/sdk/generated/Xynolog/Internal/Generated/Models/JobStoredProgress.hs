-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.JobStoredProgress
  ( JobStoredProgress(..)
  , JobStoredProgressBranch2Value(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.JobProgress
data JobStoredProgress = JobStoredProgressBranch1 (JobProgress) | JobStoredProgressBranch2 (JobStoredProgressBranch2Value) deriving (Eq, Show)
instance FromJSON JobStoredProgress where
  parseJSON = checked "JobStoredProgress" $ \value -> (JobStoredProgressBranch1 <$> parseJSON value) <|> (JobStoredProgressBranch2 <$> parseJSON value)
instance ToJSON JobStoredProgress where
  toJSON (JobStoredProgressBranch1 value) = toJSON value
  toJSON (JobStoredProgressBranch2 value) = toJSON value


data JobStoredProgressBranch2Value = JobStoredProgressBranch2Value { jobStoredProgressBranch2ValueAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON JobStoredProgressBranch2Value where
  parseJSON = checked "JobStoredProgressBranch2Value" $ withObject "JobStoredProgressBranch2Value" (\fields -> JobStoredProgressBranch2Value <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON JobStoredProgressBranch2Value where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (jobStoredProgressBranch2ValueAdditionalProperties value)))
