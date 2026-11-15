-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.TaggingJobParams
  ( TaggingJobParams(..)
  , TaggingJobParamsMotivation(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data TaggingJobParams = TaggingJobParams { taggingJobParamsCategories :: [Text], taggingJobParamsLanguage :: Maybe (Text), taggingJobParamsMotivation :: TaggingJobParamsMotivation, taggingJobParamsSchemaId :: Text, taggingJobParamsSourceLanguage :: Maybe (Text) } deriving (Eq, Show)
instance FromJSON TaggingJobParams where
  parseJSON = checked "TaggingJobParams" $ withObject "TaggingJobParams" (\fields -> TaggingJobParams <$> fields .: "categories" <*> optional fields "language" <*> fields .: "motivation" <*> fields .: "schemaId" <*> optional fields "sourceLanguage")
instance ToJSON TaggingJobParams where toJSON value = Object (KM.fromList (concat [[("categories", toJSON (taggingJobParamsCategories value))], optionalPair "language" (taggingJobParamsLanguage value), [("motivation", toJSON (taggingJobParamsMotivation value))], [("schemaId", toJSON (taggingJobParamsSchemaId value))], optionalPair "sourceLanguage" (taggingJobParamsSourceLanguage value)]))

data TaggingJobParamsMotivation = TaggingJobParamsMotivationTagging deriving (Eq, Show)
instance FromJSON TaggingJobParamsMotivation where
  parseJSON = checked "TaggingJobParamsMotivation" $ \value -> if value == (String "tagging") then pure TaggingJobParamsMotivationTagging else fail "unknown enumeration member"
instance ToJSON TaggingJobParamsMotivation where
  toJSON TaggingJobParamsMotivationTagging = String "tagging"
