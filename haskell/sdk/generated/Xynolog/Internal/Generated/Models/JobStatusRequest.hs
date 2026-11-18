-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobStatusRequest (JobStatusRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobId
data JobStatusRequest = JobStatusRequest
  { jobStatusRequestJobId :: JobId
  , jobStatusRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON JobStatusRequest where parseJSON = checked "JobStatusRequest" $ withObject "JobStatusRequest" (\fields -> JobStatusRequest <$> (fields .: "jobId") <*> traverse parseJSON (withoutFields ["jobId"] fields))
instance ToJSON JobStatusRequest where toJSON value = Object (KM.fromList (concat [[("jobId", toJSON (jobStatusRequestJobId value))]]) <> fmap toJSON (withoutFields ["jobId"] (jobStatusRequestAdditionalProperties value)))
