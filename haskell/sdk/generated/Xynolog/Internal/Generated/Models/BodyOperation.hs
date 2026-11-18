-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BodyOperation (BodyOperation(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.BodyOperationAdd
import Xynolog.Internal.Generated.Models.BodyOperationRemove
import Xynolog.Internal.Generated.Models.BodyOperationReplace
data BodyOperation = BodyOperationBranch1 BodyOperationAdd | BodyOperationBranch2 BodyOperationRemove | BodyOperationBranch3 BodyOperationReplace deriving (Eq, Show)
instance FromJSON BodyOperation where parseJSON = checked "BodyOperation" $ \value -> (BodyOperationBranch1 <$> parseJSON value) <|> (BodyOperationBranch2 <$> parseJSON value) <|> (BodyOperationBranch3 <$> parseJSON value)
instance ToJSON BodyOperation where
  toJSON (BodyOperationBranch1 value) = toJSON value
  toJSON (BodyOperationBranch2 value) = toJSON value
  toJSON (BodyOperationBranch3 value) = toJSON value
