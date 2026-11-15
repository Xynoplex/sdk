-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.JobProgressMessage
  ( JobProgressMessage(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.JobProgressAnalyzing
import Xynolog.Internal.Generated.Models.JobProgressAnalyzingTags
import Xynolog.Internal.Generated.Models.JobProgressCompleteCreated
import Xynolog.Internal.Generated.Models.JobProgressCompleteGenerated
import Xynolog.Internal.Generated.Models.JobProgressCreatingAnnotations
import Xynolog.Internal.Generated.Models.JobProgressCreatingResource
import Xynolog.Internal.Generated.Models.JobProgressCreatingTagAnnotations
import Xynolog.Internal.Generated.Models.JobProgressDetectingEntities
import Xynolog.Internal.Generated.Models.JobProgressGeneratingResource
import Xynolog.Internal.Generated.Models.JobProgressLoading
data JobProgressMessage = JobProgressMessageBranch1 (JobProgressLoading) | JobProgressMessageBranch2 (JobProgressAnalyzing) | JobProgressMessageBranch3 (JobProgressAnalyzingTags) | JobProgressMessageBranch4 (JobProgressGeneratingResource) | JobProgressMessageBranch5 (JobProgressCreatingResource) | JobProgressMessageBranch6 (JobProgressCompleteGenerated) | JobProgressMessageBranch7 (JobProgressDetectingEntities) | JobProgressMessageBranch8 (JobProgressCreatingAnnotations) | JobProgressMessageBranch9 (JobProgressCreatingTagAnnotations) | JobProgressMessageBranch10 (JobProgressCompleteCreated) deriving (Eq, Show)
instance FromJSON JobProgressMessage where
  parseJSON = checked "JobProgressMessage" $ \value -> (JobProgressMessageBranch1 <$> parseJSON value) <|> (JobProgressMessageBranch2 <$> parseJSON value) <|> (JobProgressMessageBranch3 <$> parseJSON value) <|> (JobProgressMessageBranch4 <$> parseJSON value) <|> (JobProgressMessageBranch5 <$> parseJSON value) <|> (JobProgressMessageBranch6 <$> parseJSON value) <|> (JobProgressMessageBranch7 <$> parseJSON value) <|> (JobProgressMessageBranch8 <$> parseJSON value) <|> (JobProgressMessageBranch9 <$> parseJSON value) <|> (JobProgressMessageBranch10 <$> parseJSON value)
instance ToJSON JobProgressMessage where
  toJSON (JobProgressMessageBranch1 value) = toJSON value
  toJSON (JobProgressMessageBranch2 value) = toJSON value
  toJSON (JobProgressMessageBranch3 value) = toJSON value
  toJSON (JobProgressMessageBranch4 value) = toJSON value
  toJSON (JobProgressMessageBranch5 value) = toJSON value
  toJSON (JobProgressMessageBranch6 value) = toJSON value
  toJSON (JobProgressMessageBranch7 value) = toJSON value
  toJSON (JobProgressMessageBranch8 value) = toJSON value
  toJSON (JobProgressMessageBranch9 value) = toJSON value
  toJSON (JobProgressMessageBranch10 value) = toJSON value
