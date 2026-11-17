-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.MarkJobParams (MarkJobParams(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AssessingJobParams
import Xynolog.Internal.Generated.Models.CommentingJobParams
import Xynolog.Internal.Generated.Models.HighlightingJobParams
import Xynolog.Internal.Generated.Models.LinkingJobParams
import Xynolog.Internal.Generated.Models.TaggingJobParams
data MarkJobParams = MarkJobParamsBranch1 HighlightingJobParams | MarkJobParamsBranch2 CommentingJobParams | MarkJobParamsBranch3 AssessingJobParams | MarkJobParamsBranch4 LinkingJobParams | MarkJobParamsBranch5 TaggingJobParams deriving (Eq, Show)
instance FromJSON MarkJobParams where parseJSON = checked "MarkJobParams" $ \value -> (MarkJobParamsBranch1 <$> parseJSON value) <|> (MarkJobParamsBranch2 <$> parseJSON value) <|> (MarkJobParamsBranch3 <$> parseJSON value) <|> (MarkJobParamsBranch4 <$> parseJSON value) <|> (MarkJobParamsBranch5 <$> parseJSON value)
instance ToJSON MarkJobParams where
  toJSON (MarkJobParamsBranch1 value) = toJSON value
  toJSON (MarkJobParamsBranch2 value) = toJSON value
  toJSON (MarkJobParamsBranch3 value) = toJSON value
  toJSON (MarkJobParamsBranch4 value) = toJSON value
  toJSON (MarkJobParamsBranch5 value) = toJSON value
