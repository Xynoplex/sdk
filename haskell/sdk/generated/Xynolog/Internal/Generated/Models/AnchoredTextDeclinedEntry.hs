-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.AnchoredTextDeclinedEntry (AnchoredTextDeclinedEntry(..), AnchoredTextDeclinedEntryV(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ExtractionDeclinedReason
data AnchoredTextDeclinedEntry = AnchoredTextDeclinedEntry
  { anchoredTextDeclinedEntryDeclined :: ExtractionDeclinedReason
  , anchoredTextDeclinedEntryStamp :: Text
  , anchoredTextDeclinedEntryV :: AnchoredTextDeclinedEntryV
  } deriving (Eq, Show)
instance FromJSON AnchoredTextDeclinedEntry where parseJSON = checked "AnchoredTextDeclinedEntry" $ withObject "AnchoredTextDeclinedEntry" (\fields -> AnchoredTextDeclinedEntry <$> (fields .: "declined") <*> (fields .: "stamp") <*> (fields .: "v"))
instance ToJSON AnchoredTextDeclinedEntry where toJSON value = Object (KM.fromList (concat [[("declined", toJSON (anchoredTextDeclinedEntryDeclined value))], [("stamp", toJSON (anchoredTextDeclinedEntryStamp value))], [("v", toJSON (anchoredTextDeclinedEntryV value))]]))
data AnchoredTextDeclinedEntryV = AnchoredTextDeclinedEntryVV3U2e_0 deriving (Eq, Show)
instance FromJSON AnchoredTextDeclinedEntryV where parseJSON = checked "AnchoredTextDeclinedEntryV" $ \value -> if value == Number (read "3.0") then pure AnchoredTextDeclinedEntryVV3U2e_0 else fail "unknown enumeration member"
instance ToJSON AnchoredTextDeclinedEntryV where toJSON AnchoredTextDeclinedEntryVV3U2e_0 = Number (read "3.0")
