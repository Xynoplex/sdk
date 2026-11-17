-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobProgressCreatingTagAnnotations (JobProgressCreatingTagAnnotations(..), JobProgressCreatingTagAnnotationsCode(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
data JobProgressCreatingTagAnnotations = JobProgressCreatingTagAnnotations
  { jobProgressCreatingTagAnnotationsCode :: JobProgressCreatingTagAnnotationsCode
  , jobProgressCreatingTagAnnotationsCount :: Integer
  , jobProgressCreatingTagAnnotationsAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON JobProgressCreatingTagAnnotations where parseJSON = checked "JobProgressCreatingTagAnnotations" $ withObject "JobProgressCreatingTagAnnotations" (\fields -> JobProgressCreatingTagAnnotations <$> (fields .: "code") <*> (fields .: "count") <*> traverse parseJSON (withoutFields ["code", "count"] fields))
instance ToJSON JobProgressCreatingTagAnnotations where toJSON value = Object (KM.fromList (concat [[("code", toJSON (jobProgressCreatingTagAnnotationsCode value))], [("count", toJSON (jobProgressCreatingTagAnnotationsCount value))]]) <> fmap toJSON (withoutFields ["code", "count"] (jobProgressCreatingTagAnnotationsAdditionalProperties value)))
data JobProgressCreatingTagAnnotationsCode = JobProgressCreatingTagAnnotationsCodeCreatingU2d_tagU2d_annotations deriving (Eq, Show)
instance FromJSON JobProgressCreatingTagAnnotationsCode where parseJSON = checked "JobProgressCreatingTagAnnotationsCode" $ \value -> if value == String "creating-tag-annotations" then pure JobProgressCreatingTagAnnotationsCodeCreatingU2d_tagU2d_annotations else fail "unknown enumeration member"
instance ToJSON JobProgressCreatingTagAnnotationsCode where toJSON JobProgressCreatingTagAnnotationsCodeCreatingU2d_tagU2d_annotations = String "creating-tag-annotations"
