-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.TagCategory (TagCategory(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data TagCategory = TagCategory
  { tagCategoryDescription :: Text
  , tagCategoryExamples :: [Text]
  , tagCategoryName :: Text
  , tagCategoryAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON TagCategory where parseJSON = checked "TagCategory" $ withObject "TagCategory" (\fields -> TagCategory <$> (fields .: "description") <*> (fields .: "examples") <*> (fields .: "name") <*> traverse parseJSON (withoutFields ["description", "examples", "name"] fields))
instance ToJSON TagCategory where toJSON value = Object (KM.fromList (concat [[("description", toJSON (tagCategoryDescription value))], [("examples", toJSON (tagCategoryExamples value))], [("name", toJSON (tagCategoryName value))]]) <> fmap toJSON (withoutFields ["description", "examples", "name"] (tagCategoryAdditionalProperties value)))
