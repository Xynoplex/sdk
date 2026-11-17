-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.PdfTextItem
  ( PdfTextItem(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data PdfTextItem = PdfTextItem { pdfTextItemEnd :: Integer, pdfTextItemHeight :: Scientific, pdfTextItemPage :: Integer, pdfTextItemStart :: Integer, pdfTextItemWidth :: Scientific, pdfTextItemX :: Scientific, pdfTextItemY :: Scientific, pdfTextItemAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON PdfTextItem where
  parseJSON = checked "PdfTextItem" $ withObject "PdfTextItem" (\fields -> PdfTextItem <$> fields .: "end" <*> fields .: "height" <*> fields .: "page" <*> fields .: "start" <*> fields .: "width" <*> fields .: "x" <*> fields .: "y" <*> traverse parseJSON (withoutFields ["end", "height", "page", "start", "width", "x", "y"] fields))
instance ToJSON PdfTextItem where toJSON value = Object (KM.fromList (concat [[("end", toJSON (pdfTextItemEnd value))], [("height", toJSON (pdfTextItemHeight value))], [("page", toJSON (pdfTextItemPage value))], [("start", toJSON (pdfTextItemStart value))], [("width", toJSON (pdfTextItemWidth value))], [("x", toJSON (pdfTextItemX value))], [("y", toJSON (pdfTextItemY value))]]) <> fmap toJSON (withoutFields ["end", "height", "page", "start", "width", "x", "y"] (pdfTextItemAdditionalProperties value)))
