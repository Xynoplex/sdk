-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.Expected (Expected(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data Expected = Expected
  { expectedDid :: Text
  , expectedName :: Maybe Text
  } deriving (Eq, Show)
instance FromJSON Expected where parseJSON = checked "Expected" $ withObject "Expected" (\fields -> Expected <$> (fields .: "did") <*> optional fields "name")
instance ToJSON Expected where toJSON value = Object (KM.fromList (concat [[("did", toJSON (expectedDid value))], optionalPair "name" (expectedName value)]))
