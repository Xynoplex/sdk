-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.IssuedTokens (IssuedTokens(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data IssuedTokens = IssuedTokens
  { issuedTokensAccess :: Text
  , issuedTokensRefresh :: Text
  , issuedTokensAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON IssuedTokens where parseJSON = checked "IssuedTokens" $ withObject "IssuedTokens" (\fields -> IssuedTokens <$> (fields .: "access") <*> (fields .: "refresh") <*> traverse parseJSON (withoutFields ["access", "refresh"] fields))
instance ToJSON IssuedTokens where toJSON value = Object (KM.fromList (concat [[("access", toJSON (issuedTokensAccess value))], [("refresh", toJSON (issuedTokensRefresh value))]]) <> fmap toJSON (withoutFields ["access", "refresh"] (issuedTokensAdditionalProperties value)))
