-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.AnchoredTextAnswer
  ( AnchoredTextAnswer(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.AnchoredTextAbsent
import Xynoplex.Internal.Generated.Models.ExtractedText
import Xynoplex.Internal.Generated.Models.ExtractionDeclined
data AnchoredTextAnswer = AnchoredTextAnswerBranch1 (ExtractedText) | AnchoredTextAnswerBranch2 (ExtractionDeclined) | AnchoredTextAnswerBranch3 (AnchoredTextAbsent) deriving (Eq, Show)
instance FromJSON AnchoredTextAnswer where
  parseJSON = checked "AnchoredTextAnswer" $ \value -> (AnchoredTextAnswerBranch1 <$> parseJSON value) <|> (AnchoredTextAnswerBranch2 <$> parseJSON value) <|> (AnchoredTextAnswerBranch3 <$> parseJSON value)
instance ToJSON AnchoredTextAnswer where
  toJSON (AnchoredTextAnswerBranch1 value) = toJSON value
  toJSON (AnchoredTextAnswerBranch2 value) = toJSON value
  toJSON (AnchoredTextAnswerBranch3 value) = toJSON value
