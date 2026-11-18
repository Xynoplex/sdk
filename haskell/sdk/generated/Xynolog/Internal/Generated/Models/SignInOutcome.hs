-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.SignInOutcome (SignInOutcome (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Expected
import Xynolog.Internal.Generated.Models.KnowledgeBase

data SignInOutcome = SignInOutcome
  { signInOutcomeExpected :: Maybe Expected,
    signInOutcomeKb :: KnowledgeBase
  }
  deriving (Eq, Show)

instance FromJSON SignInOutcome where parseJSON = checked "SignInOutcome" $ withObject "SignInOutcome" (\fields -> SignInOutcome <$> optional fields "expected" <*> (fields .: "kb"))

instance ToJSON SignInOutcome where toJSON value = Object (KM.fromList (concat [optionalPair "expected" (signInOutcomeExpected value), [("kb", toJSON (signInOutcomeKb value))]]))
