-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.AnnotationId (AnnotationId, annotationIdValue, mkAnnotationId) where
import Data.Aeson (FromJSON(..), ToJSON(..))
import Data.Aeson.Types (parseEither)
import Data.Text (Text)
import Xynolog.Internal.Codec
newtype AnnotationId = AnnotationId Text deriving (Eq, Ord, Show)
instance FromJSON AnnotationId where parseJSON = checked "AnnotationId" $ \value -> AnnotationId <$> parseJSON value
instance ToJSON AnnotationId where toJSON (AnnotationId value) = toJSON value
annotationIdValue :: AnnotationId -> Text
annotationIdValue (AnnotationId value) = value
mkAnnotationId :: Text -> Either String AnnotationId
mkAnnotationId value = parseEither parseJSON (toJSON value)
