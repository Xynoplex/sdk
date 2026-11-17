-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobProgressLoading (JobProgressLoading(..), JobProgressLoadingCode(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
data JobProgressLoading = JobProgressLoading
  { jobProgressLoadingCode :: JobProgressLoadingCode
  , jobProgressLoadingAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON JobProgressLoading where parseJSON = checked "JobProgressLoading" $ withObject "JobProgressLoading" (\fields -> JobProgressLoading <$> (fields .: "code") <*> traverse parseJSON (withoutFields ["code"] fields))
instance ToJSON JobProgressLoading where toJSON value = Object (KM.fromList (concat [[("code", toJSON (jobProgressLoadingCode value))]]) <> fmap toJSON (withoutFields ["code"] (jobProgressLoadingAdditionalProperties value)))
data JobProgressLoadingCode = JobProgressLoadingCodeLoading deriving (Eq, Show)
instance FromJSON JobProgressLoadingCode where parseJSON = checked "JobProgressLoadingCode" $ \value -> if value == String "loading" then pure JobProgressLoadingCodeLoading else fail "unknown enumeration member"
instance ToJSON JobProgressLoadingCode where toJSON JobProgressLoadingCodeLoading = String "loading"
