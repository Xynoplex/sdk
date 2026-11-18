-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.MarkUpdateBodyCommand (MarkUpdateBodyCommand (..), MarkUpdateBodyCommandOperationsItem (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
import Xynolog.Internal.Generated.Models.BodyOperationAdd
import Xynolog.Internal.Generated.Models.BodyOperationRemove
import Xynolog.Internal.Generated.Models.BodyOperationReplace
import Xynolog.Internal.Generated.Models.ResourceId
import Xynolog.Internal.Generated.Models.UserId

data MarkUpdateBodyCommand = MarkUpdateBodyCommand
  { markUpdateBodyCommandU5f_userId :: Maybe UserId,
    markUpdateBodyCommandAnnotationId :: AnnotationId,
    markUpdateBodyCommandOperations :: [MarkUpdateBodyCommandOperationsItem],
    markUpdateBodyCommandResourceId :: ResourceId,
    markUpdateBodyCommandAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON MarkUpdateBodyCommand where parseJSON = checked "MarkUpdateBodyCommand" $ withObject "MarkUpdateBodyCommand" (\fields -> MarkUpdateBodyCommand <$> optional fields "_userId" <*> (fields .: "annotationId") <*> (fields .: "operations") <*> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["_userId", "annotationId", "operations", "resourceId"] fields))

instance ToJSON MarkUpdateBodyCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (markUpdateBodyCommandU5f_userId value), [("annotationId", toJSON (markUpdateBodyCommandAnnotationId value))], [("operations", toJSON (markUpdateBodyCommandOperations value))], [("resourceId", toJSON (markUpdateBodyCommandResourceId value))]]) <> fmap toJSON (withoutFields ["_userId", "annotationId", "operations", "resourceId"] (markUpdateBodyCommandAdditionalProperties value)))

data MarkUpdateBodyCommandOperationsItem = MarkUpdateBodyCommandOperationsItemBranch1 BodyOperationAdd | MarkUpdateBodyCommandOperationsItemBranch2 BodyOperationRemove | MarkUpdateBodyCommandOperationsItemBranch3 BodyOperationReplace deriving (Eq, Show)

instance FromJSON MarkUpdateBodyCommandOperationsItem where parseJSON = checked "MarkUpdateBodyCommandOperationsItem" $ \value -> (MarkUpdateBodyCommandOperationsItemBranch1 <$> parseJSON value) <|> (MarkUpdateBodyCommandOperationsItemBranch2 <$> parseJSON value) <|> (MarkUpdateBodyCommandOperationsItemBranch3 <$> parseJSON value)

instance ToJSON MarkUpdateBodyCommandOperationsItem where
  toJSON (MarkUpdateBodyCommandOperationsItemBranch1 value) = toJSON value
  toJSON (MarkUpdateBodyCommandOperationsItemBranch2 value) = toJSON value
  toJSON (MarkUpdateBodyCommandOperationsItemBranch3 value) = toJSON value
