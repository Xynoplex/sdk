-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.Motivation
  ( Motivation(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data Motivation = MotivationAssessing | MotivationCommenting | MotivationHighlighting | MotivationLinking | MotivationTagging deriving (Eq, Show)
instance FromJSON Motivation where
  parseJSON = checked "Motivation" $ \value -> if value == (String "assessing") then pure MotivationAssessing else if value == (String "commenting") then pure MotivationCommenting else if value == (String "highlighting") then pure MotivationHighlighting else if value == (String "linking") then pure MotivationLinking else if value == (String "tagging") then pure MotivationTagging else fail "unknown enumeration member"
instance ToJSON Motivation where
  toJSON MotivationAssessing = String "assessing"
  toJSON MotivationCommenting = String "commenting"
  toJSON MotivationHighlighting = String "highlighting"
  toJSON MotivationLinking = String "linking"
  toJSON MotivationTagging = String "tagging"
