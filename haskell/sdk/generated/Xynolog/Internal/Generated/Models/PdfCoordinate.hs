-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.PdfCoordinate (PdfCoordinate(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Xynolog.Internal.Codec
data PdfCoordinate = PdfCoordinate
  { pdfCoordinateHeight :: Scientific
  , pdfCoordinatePage :: Integer
  , pdfCoordinateWidth :: Scientific
  , pdfCoordinateX :: Scientific
  , pdfCoordinateY :: Scientific
  , pdfCoordinateAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON PdfCoordinate where parseJSON = checked "PdfCoordinate" $ withObject "PdfCoordinate" (\fields -> PdfCoordinate <$> (fields .: "height") <*> (fields .: "page") <*> (fields .: "width") <*> (fields .: "x") <*> (fields .: "y") <*> traverse parseJSON (withoutFields ["height", "page", "width", "x", "y"] fields))
instance ToJSON PdfCoordinate where toJSON value = Object (KM.fromList (concat [[("height", toJSON (pdfCoordinateHeight value))], [("page", toJSON (pdfCoordinatePage value))], [("width", toJSON (pdfCoordinateWidth value))], [("x", toJSON (pdfCoordinateX value))], [("y", toJSON (pdfCoordinateY value))]]) <> fmap toJSON (withoutFields ["height", "page", "width", "x", "y"] (pdfCoordinateAdditionalProperties value)))
