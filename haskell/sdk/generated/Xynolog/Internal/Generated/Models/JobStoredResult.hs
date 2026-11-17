-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobStoredResult (JobStoredResult(..), JobStoredResultBranch2Value(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject)
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobResult
data JobStoredResult = JobStoredResultBranch1 JobResult | JobStoredResultBranch2 JobStoredResultBranch2Value deriving (Eq, Show)
instance FromJSON JobStoredResult where parseJSON = checked "JobStoredResult" $ \value -> (JobStoredResultBranch1 <$> parseJSON value) <|> (JobStoredResultBranch2 <$> parseJSON value)
instance ToJSON JobStoredResult where
  toJSON (JobStoredResultBranch1 value) = toJSON value
  toJSON (JobStoredResultBranch2 value) = toJSON value
data JobStoredResultBranch2Value = JobStoredResultBranch2Value
  { jobStoredResultBranch2ValueAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON JobStoredResultBranch2Value where parseJSON = checked "JobStoredResultBranch2Value" $ withObject "JobStoredResultBranch2Value" (\fields -> JobStoredResultBranch2Value <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON JobStoredResultBranch2Value where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (jobStoredResultBranch2ValueAdditionalProperties value)))
