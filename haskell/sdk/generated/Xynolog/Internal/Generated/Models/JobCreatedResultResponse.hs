-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobCreatedResultResponse (JobCreatedResultResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobId
data JobCreatedResultResponse = JobCreatedResultResponse
  { jobCreatedResultResponseJobId :: JobId
  , jobCreatedResultResponseAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON JobCreatedResultResponse where parseJSON = checked "JobCreatedResultResponse" $ withObject "JobCreatedResultResponse" (\fields -> JobCreatedResultResponse <$> (fields .: "jobId") <*> traverse parseJSON (withoutFields ["jobId"] fields))
instance ToJSON JobCreatedResultResponse where toJSON value = Object (KM.fromList (concat [[("jobId", toJSON (jobCreatedResultResponseJobId value))]]) <> fmap toJSON (withoutFields ["jobId"] (jobCreatedResultResponseAdditionalProperties value)))
