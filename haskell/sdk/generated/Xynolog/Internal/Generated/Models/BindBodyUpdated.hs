-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BindBodyUpdated (BindBodyUpdated(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject)
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
data BindBodyUpdated = BindBodyUpdated
  { bindBodyUpdatedAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BindBodyUpdated where parseJSON = checked "BindBodyUpdated" $ withObject "BindBodyUpdated" (\fields -> BindBodyUpdated <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON BindBodyUpdated where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (bindBodyUpdatedAdditionalProperties value)))
