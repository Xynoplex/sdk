-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.KbDescription (KbDescription(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data KbDescription = KbDescription
  { kbDescriptionDomain :: Text
  , kbDescriptionGitBranch :: Maybe Text
  , kbDescriptionName :: Text
  , kbDescriptionAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON KbDescription where parseJSON = checked "KbDescription" $ withObject "KbDescription" (\fields -> KbDescription <$> (fields .: "domain") <*> optional fields "gitBranch" <*> (fields .: "name") <*> traverse parseJSON (withoutFields ["domain", "gitBranch", "name"] fields))
instance ToJSON KbDescription where toJSON value = Object (KM.fromList (concat [[("domain", toJSON (kbDescriptionDomain value))], optionalPair "gitBranch" (kbDescriptionGitBranch value), [("name", toJSON (kbDescriptionName value))]]) <> fmap toJSON (withoutFields ["domain", "gitBranch", "name"] (kbDescriptionAdditionalProperties value)))
