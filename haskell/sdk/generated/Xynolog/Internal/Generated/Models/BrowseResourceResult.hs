-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowseResourceResult (BrowseResourceResult(..), BrowseResourceResultResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceDescriptor
data BrowseResourceResult = BrowseResourceResult
  { browseResourceResultResponse :: BrowseResourceResultResponse
  , browseResourceResultAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BrowseResourceResult where parseJSON = checked "BrowseResourceResult" $ withObject "BrowseResourceResult" (\fields -> BrowseResourceResult <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON BrowseResourceResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (browseResourceResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (browseResourceResultAdditionalProperties value)))
data BrowseResourceResultResponse = BrowseResourceResultResponse
  { browseResourceResultResponseLastSequence :: Integer
  , browseResourceResultResponseResource :: ResourceDescriptor
  } deriving (Eq, Show)
instance FromJSON BrowseResourceResultResponse where parseJSON = checked "BrowseResourceResultResponse" $ withObject "BrowseResourceResultResponse" (\fields -> BrowseResourceResultResponse <$> (fields .: "lastSequence") <*> (fields .: "resource"))
instance ToJSON BrowseResourceResultResponse where toJSON value = Object (KM.fromList (concat [[("lastSequence", toJSON (browseResourceResultResponseLastSequence value))], [("resource", toJSON (browseResourceResultResponseResource value))]]))
