-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.AnchoredTextAnswer (AnchoredTextAnswer(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnchoredTextAbsent
import Xynolog.Internal.Generated.Models.ExtractedText
import Xynolog.Internal.Generated.Models.ExtractionDeclined
data AnchoredTextAnswer = AnchoredTextAnswerBranch1 ExtractedText | AnchoredTextAnswerBranch2 ExtractionDeclined | AnchoredTextAnswerBranch3 AnchoredTextAbsent deriving (Eq, Show)
instance FromJSON AnchoredTextAnswer where parseJSON = checked "AnchoredTextAnswer" $ \value -> (AnchoredTextAnswerBranch1 <$> parseJSON value) <|> (AnchoredTextAnswerBranch2 <$> parseJSON value) <|> (AnchoredTextAnswerBranch3 <$> parseJSON value)
instance ToJSON AnchoredTextAnswer where
  toJSON (AnchoredTextAnswerBranch1 value) = toJSON value
  toJSON (AnchoredTextAnswerBranch2 value) = toJSON value
  toJSON (AnchoredTextAnswerBranch3 value) = toJSON value
