-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.YieldJobResult (YieldJobResult (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobDeclined
import Xynolog.Internal.Generated.Models.YieldJobDone

data YieldJobResult = YieldJobResultBranch1 YieldJobDone | YieldJobResultBranch2 JobDeclined deriving (Eq, Show)

instance FromJSON YieldJobResult where parseJSON = checked "YieldJobResult" $ \value -> (YieldJobResultBranch1 <$> parseJSON value) <|> (YieldJobResultBranch2 <$> parseJSON value)

instance ToJSON YieldJobResult where
  toJSON (YieldJobResultBranch1 value) = toJSON value
  toJSON (YieldJobResultBranch2 value) = toJSON value
