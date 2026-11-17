-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.AnchoredText (AnchoredText(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.PdfTextItem
data AnchoredText = AnchoredText
  { anchoredTextItems :: [PdfTextItem]
  , anchoredTextText :: Text
  , anchoredTextAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON AnchoredText where parseJSON = checked "AnchoredText" $ withObject "AnchoredText" (\fields -> AnchoredText <$> (fields .: "items") <*> (fields .: "text") <*> traverse parseJSON (withoutFields ["items", "text"] fields))
instance ToJSON AnchoredText where toJSON value = Object (KM.fromList (concat [[("items", toJSON (anchoredTextItems value))], [("text", toJSON (anchoredTextText value))]]) <> fmap toJSON (withoutFields ["items", "text"] (anchoredTextAdditionalProperties value)))
