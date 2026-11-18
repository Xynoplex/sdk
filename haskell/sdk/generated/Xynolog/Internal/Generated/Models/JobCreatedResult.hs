-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobCreatedResult (JobCreatedResult(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobCreatedResultResponse
data JobCreatedResult = JobCreatedResult
  { jobCreatedResultResponse :: JobCreatedResultResponse
  , jobCreatedResultAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON JobCreatedResult where parseJSON = checked "JobCreatedResult" $ withObject "JobCreatedResult" (\fields -> JobCreatedResult <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON JobCreatedResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (jobCreatedResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (jobCreatedResultAdditionalProperties value)))
