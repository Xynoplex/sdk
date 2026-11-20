-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.PdfCoordinate (PdfCoordinate (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Scientific (Scientific)
import Xynolog.Internal.Codec

data PdfCoordinate = PdfCoordinate
  { pdfCoordinateHeight :: Scientific,
    pdfCoordinatePage :: Integer,
    pdfCoordinateWidth :: Scientific,
    pdfCoordinateX :: Scientific,
    pdfCoordinateY :: Scientific
  }
  deriving (Eq, Show)

instance FromJSON PdfCoordinate where parseJSON = checked "PdfCoordinate" $ withObject "PdfCoordinate" (\fields -> PdfCoordinate <$> (fields .: "height") <*> (fields .: "page") <*> (fields .: "width") <*> (fields .: "x") <*> (fields .: "y"))

instance ToJSON PdfCoordinate where toJSON value = Object (KM.fromList (concat [[("height", toJSON (pdfCoordinateHeight value))], [("page", toJSON (pdfCoordinatePage value))], [("width", toJSON (pdfCoordinateWidth value))], [("x", toJSON (pdfCoordinateX value))], [("y", toJSON (pdfCoordinateY value))]]))
