-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.MarkJobDone (MarkJobDone(..), MarkJobDoneByCategory(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
data MarkJobDone = MarkJobDone
  { markJobDoneByCategory :: Maybe MarkJobDoneByCategory
  , markJobDoneErrors :: Maybe Integer
  , markJobDoneFound :: Integer
  , markJobDonePersisted :: Integer
  , markJobDoneUncheckedPieces :: Maybe Integer
  , markJobDoneUnderReportedPieces :: Maybe Integer
  } deriving (Eq, Show)
instance FromJSON MarkJobDone where parseJSON = checked "MarkJobDone" $ withObject "MarkJobDone" (\fields -> MarkJobDone <$> optional fields "byCategory" <*> optional fields "errors" <*> (fields .: "found") <*> (fields .: "persisted") <*> optional fields "uncheckedPieces" <*> optional fields "underReportedPieces")
instance ToJSON MarkJobDone where toJSON value = Object (KM.fromList (concat [optionalPair "byCategory" (markJobDoneByCategory value), optionalPair "errors" (markJobDoneErrors value), [("found", toJSON (markJobDoneFound value))], [("persisted", toJSON (markJobDonePersisted value))], optionalPair "uncheckedPieces" (markJobDoneUncheckedPieces value), optionalPair "underReportedPieces" (markJobDoneUnderReportedPieces value)]))
data MarkJobDoneByCategory = MarkJobDoneByCategory
  { markJobDoneByCategoryAdditionalProperties :: KM.KeyMap Integer
  } deriving (Eq, Show)
instance FromJSON MarkJobDoneByCategory where parseJSON = checked "MarkJobDoneByCategory" $ withObject "MarkJobDoneByCategory" (\fields -> MarkJobDoneByCategory <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON MarkJobDoneByCategory where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (markJobDoneByCategoryAdditionalProperties value)))
