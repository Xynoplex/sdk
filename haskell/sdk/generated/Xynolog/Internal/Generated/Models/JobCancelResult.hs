-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobCancelResult (JobCancelResult(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
data JobCancelResult = JobCancelResult
  { jobCancelResultCancelled :: Bool
  , jobCancelResultAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON JobCancelResult where parseJSON = checked "JobCancelResult" $ withObject "JobCancelResult" (\fields -> JobCancelResult <$> (fields .: "cancelled") <*> traverse parseJSON (withoutFields ["cancelled"] fields))
instance ToJSON JobCancelResult where toJSON value = Object (KM.fromList (concat [[("cancelled", toJSON (jobCancelResultCancelled value))]]) <> fmap toJSON (withoutFields ["cancelled"] (jobCancelResultAdditionalProperties value)))
