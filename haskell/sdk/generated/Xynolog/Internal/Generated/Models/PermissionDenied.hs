-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.PermissionDenied (PermissionDenied (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data PermissionDenied = PermissionDenied
  { permissionDeniedDetail :: Maybe Text
  }
  deriving (Eq, Show)

instance FromJSON PermissionDenied where parseJSON = checked "PermissionDenied" $ withObject "PermissionDenied" (\fields -> PermissionDenied <$> (fields .: "detail"))

instance ToJSON PermissionDenied where toJSON value = Object (KM.fromList (concat [[("detail", toJSON (permissionDeniedDetail value))]]))
