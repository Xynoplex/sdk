-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BodyOperationAdd (BodyOperationAdd(..), BodyOperationAddItem(..), BodyOperationAddOp(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.SpecificResource
import Xynolog.Internal.Generated.Models.TextualBody
data BodyOperationAdd = BodyOperationAdd
  { bodyOperationAddItem :: BodyOperationAddItem
  , bodyOperationAddOp :: BodyOperationAddOp
  , bodyOperationAddAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BodyOperationAdd where parseJSON = checked "BodyOperationAdd" $ withObject "BodyOperationAdd" (\fields -> BodyOperationAdd <$> (fields .: "item") <*> (fields .: "op") <*> traverse parseJSON (withoutFields ["item", "op"] fields))
instance ToJSON BodyOperationAdd where toJSON value = Object (KM.fromList (concat [[("item", toJSON (bodyOperationAddItem value))], [("op", toJSON (bodyOperationAddOp value))]]) <> fmap toJSON (withoutFields ["item", "op"] (bodyOperationAddAdditionalProperties value)))
data BodyOperationAddItem = BodyOperationAddItemBranch1 TextualBody | BodyOperationAddItemBranch2 SpecificResource deriving (Eq, Show)
instance FromJSON BodyOperationAddItem where parseJSON = checked "BodyOperationAddItem" $ \value -> (BodyOperationAddItemBranch1 <$> parseJSON value) <|> (BodyOperationAddItemBranch2 <$> parseJSON value)
instance ToJSON BodyOperationAddItem where
  toJSON (BodyOperationAddItemBranch1 value) = toJSON value
  toJSON (BodyOperationAddItemBranch2 value) = toJSON value
data BodyOperationAddOp = BodyOperationAddOpAdd deriving (Eq, Show)
instance FromJSON BodyOperationAddOp where parseJSON = checked "BodyOperationAddOp" $ \value -> if value == String "add" then pure BodyOperationAddOpAdd else fail "unknown enumeration member"
instance ToJSON BodyOperationAddOp where toJSON BodyOperationAddOpAdd = String "add"
