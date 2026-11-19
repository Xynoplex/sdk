-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.IssuedTokens (IssuedTokens (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data IssuedTokens = IssuedTokens
  { issuedTokensAccess :: Text,
    issuedTokensRefresh :: Text
  }
  deriving (Eq, Show)

instance FromJSON IssuedTokens where parseJSON = checked "IssuedTokens" $ withObject "IssuedTokens" (\fields -> IssuedTokens <$> (fields .: "access") <*> (fields .: "refresh"))

instance ToJSON IssuedTokens where toJSON value = Object (KM.fromList (concat [[("access", toJSON (issuedTokensAccess value))], [("refresh", toJSON (issuedTokensRefresh value))]]))
