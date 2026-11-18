-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BodyOperationReplace (BodyOperationReplace (..), BodyOperationReplaceNewItem (..), BodyOperationReplaceOldItem (..), BodyOperationReplaceOp (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.SpecificResource
import Xynolog.Internal.Generated.Models.TextualBody

data BodyOperationReplace = BodyOperationReplace
  { bodyOperationReplaceNewItem :: BodyOperationReplaceNewItem,
    bodyOperationReplaceOldItem :: BodyOperationReplaceOldItem,
    bodyOperationReplaceOp :: BodyOperationReplaceOp,
    bodyOperationReplaceAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BodyOperationReplace where parseJSON = checked "BodyOperationReplace" $ withObject "BodyOperationReplace" (\fields -> BodyOperationReplace <$> (fields .: "newItem") <*> (fields .: "oldItem") <*> (fields .: "op") <*> traverse parseJSON (withoutFields ["newItem", "oldItem", "op"] fields))

instance ToJSON BodyOperationReplace where toJSON value = Object (KM.fromList (concat [[("newItem", toJSON (bodyOperationReplaceNewItem value))], [("oldItem", toJSON (bodyOperationReplaceOldItem value))], [("op", toJSON (bodyOperationReplaceOp value))]]) <> fmap toJSON (withoutFields ["newItem", "oldItem", "op"] (bodyOperationReplaceAdditionalProperties value)))

data BodyOperationReplaceNewItem = BodyOperationReplaceNewItemBranch1 TextualBody | BodyOperationReplaceNewItemBranch2 SpecificResource deriving (Eq, Show)

instance FromJSON BodyOperationReplaceNewItem where parseJSON = checked "BodyOperationReplaceNewItem" $ \value -> (BodyOperationReplaceNewItemBranch1 <$> parseJSON value) <|> (BodyOperationReplaceNewItemBranch2 <$> parseJSON value)

instance ToJSON BodyOperationReplaceNewItem where
  toJSON (BodyOperationReplaceNewItemBranch1 value) = toJSON value
  toJSON (BodyOperationReplaceNewItemBranch2 value) = toJSON value

data BodyOperationReplaceOldItem = BodyOperationReplaceOldItemBranch1 TextualBody | BodyOperationReplaceOldItemBranch2 SpecificResource deriving (Eq, Show)

instance FromJSON BodyOperationReplaceOldItem where parseJSON = checked "BodyOperationReplaceOldItem" $ \value -> (BodyOperationReplaceOldItemBranch1 <$> parseJSON value) <|> (BodyOperationReplaceOldItemBranch2 <$> parseJSON value)

instance ToJSON BodyOperationReplaceOldItem where
  toJSON (BodyOperationReplaceOldItemBranch1 value) = toJSON value
  toJSON (BodyOperationReplaceOldItemBranch2 value) = toJSON value

data BodyOperationReplaceOp = BodyOperationReplaceOpReplace deriving (Eq, Show)

instance FromJSON BodyOperationReplaceOp where parseJSON = checked "BodyOperationReplaceOp" $ \value -> if value == String "replace" then pure BodyOperationReplaceOpReplace else fail "unknown enumeration member"

instance ToJSON BodyOperationReplaceOp where toJSON BodyOperationReplaceOpReplace = String "replace"
