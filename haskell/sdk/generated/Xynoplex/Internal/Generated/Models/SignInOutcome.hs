-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.SignInOutcome
  ( SignInOutcome(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.Expected
import Xynoplex.Internal.Generated.Models.KnowledgeBase
data SignInOutcome = SignInOutcome { signInOutcomeExpected :: Maybe (Expected), signInOutcomeKb :: KnowledgeBase } deriving (Eq, Show)
instance FromJSON SignInOutcome where
  parseJSON = checked "SignInOutcome" $ withObject "SignInOutcome" (\fields -> SignInOutcome <$> optional fields "expected" <*> fields .: "kb")
instance ToJSON SignInOutcome where toJSON value = Object (KM.fromList (concat [optionalPair "expected" (signInOutcomeExpected value), [("kb", toJSON (signInOutcomeKb value))]]))
