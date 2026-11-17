-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobId (JobId, jobIdValue, mkJobId) where
import Data.Aeson (FromJSON(..), ToJSON(..))
import Data.Aeson.Types (parseEither)
import Data.Text (Text)
import Xynolog.Internal.Codec
newtype JobId = JobId Text deriving (Eq, Ord, Show)
instance FromJSON JobId where parseJSON = checked "JobId" $ \value -> JobId <$> parseJSON value
instance ToJSON JobId where toJSON (JobId value) = toJSON value
jobIdValue :: JobId -> Text
jobIdValue (JobId value) = value
mkJobId :: Text -> Either String JobId
mkJobId value = parseEither parseJSON (toJSON value)
