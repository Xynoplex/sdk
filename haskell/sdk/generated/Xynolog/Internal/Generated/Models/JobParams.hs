-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobParams (JobParams(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId
import Xynolog.Internal.Generated.Models.TagSchema
data JobParams = JobParams
  { jobParamsResourceId :: ResourceId
  , jobParamsSchema :: Maybe TagSchema
  , jobParamsAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON JobParams where parseJSON = checked "JobParams" $ withObject "JobParams" (\fields -> JobParams <$> (fields .: "resourceId") <*> optional fields "schema" <*> traverse parseJSON (withoutFields ["resourceId", "schema"] fields))
instance ToJSON JobParams where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (jobParamsResourceId value))], optionalPair "schema" (jobParamsSchema value)]) <> fmap toJSON (withoutFields ["resourceId", "schema"] (jobParamsAdditionalProperties value)))
