-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BodyOperationRemove (BodyOperationRemove(..), BodyOperationRemoveItem(..), BodyOperationRemoveOp(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.SpecificResource
import Xynolog.Internal.Generated.Models.TextualBody
data BodyOperationRemove = BodyOperationRemove
  { bodyOperationRemoveItem :: BodyOperationRemoveItem
  , bodyOperationRemoveOp :: BodyOperationRemoveOp
  , bodyOperationRemoveAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BodyOperationRemove where parseJSON = checked "BodyOperationRemove" $ withObject "BodyOperationRemove" (\fields -> BodyOperationRemove <$> (fields .: "item") <*> (fields .: "op") <*> traverse parseJSON (withoutFields ["item", "op"] fields))
instance ToJSON BodyOperationRemove where toJSON value = Object (KM.fromList (concat [[("item", toJSON (bodyOperationRemoveItem value))], [("op", toJSON (bodyOperationRemoveOp value))]]) <> fmap toJSON (withoutFields ["item", "op"] (bodyOperationRemoveAdditionalProperties value)))
data BodyOperationRemoveItem = BodyOperationRemoveItemBranch1 TextualBody | BodyOperationRemoveItemBranch2 SpecificResource deriving (Eq, Show)
instance FromJSON BodyOperationRemoveItem where parseJSON = checked "BodyOperationRemoveItem" $ \value -> (BodyOperationRemoveItemBranch1 <$> parseJSON value) <|> (BodyOperationRemoveItemBranch2 <$> parseJSON value)
instance ToJSON BodyOperationRemoveItem where
  toJSON (BodyOperationRemoveItemBranch1 value) = toJSON value
  toJSON (BodyOperationRemoveItemBranch2 value) = toJSON value
data BodyOperationRemoveOp = BodyOperationRemoveOpRemove deriving (Eq, Show)
instance FromJSON BodyOperationRemoveOp where parseJSON = checked "BodyOperationRemoveOp" $ \value -> if value == String "remove" then pure BodyOperationRemoveOpRemove else fail "unknown enumeration member"
instance ToJSON BodyOperationRemoveOp where toJSON BodyOperationRemoveOpRemove = String "remove"
