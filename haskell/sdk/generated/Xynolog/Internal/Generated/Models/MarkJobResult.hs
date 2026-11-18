-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.MarkJobResult (MarkJobResult (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobDeclined
import Xynolog.Internal.Generated.Models.MarkJobDone

data MarkJobResult = MarkJobResultBranch1 MarkJobDone | MarkJobResultBranch2 JobDeclined deriving (Eq, Show)

instance FromJSON MarkJobResult where parseJSON = checked "MarkJobResult" $ \value -> (MarkJobResultBranch1 <$> parseJSON value) <|> (MarkJobResultBranch2 <$> parseJSON value)

instance ToJSON MarkJobResult where
  toJSON (MarkJobResultBranch1 value) = toJSON value
  toJSON (MarkJobResultBranch2 value) = toJSON value
