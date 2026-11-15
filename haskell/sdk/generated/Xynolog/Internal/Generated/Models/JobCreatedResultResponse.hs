-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.JobCreatedResultResponse
  ( JobCreatedResultResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.JobId
data JobCreatedResultResponse = JobCreatedResultResponse { jobCreatedResultResponseJobId :: JobId, jobCreatedResultResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON JobCreatedResultResponse where
  parseJSON = checked "JobCreatedResultResponse" $ withObject "JobCreatedResultResponse" (\fields -> JobCreatedResultResponse <$> fields .: "jobId" <*> traverse parseJSON (withoutFields ["jobId"] fields))
instance ToJSON JobCreatedResultResponse where toJSON value = Object (KM.fromList (concat [[("jobId", toJSON (jobCreatedResultResponseJobId value))]]) <> fmap toJSON (withoutFields ["jobId"] (jobCreatedResultResponseAdditionalProperties value)))
