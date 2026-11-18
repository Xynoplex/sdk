-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BrowseDirectoryFailed (BrowseDirectoryFailed (..), BrowseDirectoryFailedCode (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data BrowseDirectoryFailed = BrowseDirectoryFailed
  { browseDirectoryFailedCode :: Maybe BrowseDirectoryFailedCode,
    browseDirectoryFailedDetails :: Maybe Text,
    browseDirectoryFailedMessage :: Text,
    browseDirectoryFailedPath :: Text,
    browseDirectoryFailedAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BrowseDirectoryFailed where parseJSON = checked "BrowseDirectoryFailed" $ withObject "BrowseDirectoryFailed" (\fields -> BrowseDirectoryFailed <$> optional fields "code" <*> optional fields "details" <*> (fields .: "message") <*> (fields .: "path") <*> traverse parseJSON (withoutFields ["code", "details", "message", "path"] fields))

instance ToJSON BrowseDirectoryFailed where toJSON value = Object (KM.fromList (concat [optionalPair "code" (browseDirectoryFailedCode value), optionalPair "details" (browseDirectoryFailedDetails value), [("message", toJSON (browseDirectoryFailedMessage value))], [("path", toJSON (browseDirectoryFailedPath value))]]) <> fmap toJSON (withoutFields ["code", "details", "message", "path"] (browseDirectoryFailedAdditionalProperties value)))

data BrowseDirectoryFailedCode = BrowseDirectoryFailedCodePeerU2d_unavailable | BrowseDirectoryFailedCodeNotU2d_found | BrowseDirectoryFailedCodeUnauthorized | BrowseDirectoryFailedCodeNoneU2d_pending deriving (Eq, Show)

instance FromJSON BrowseDirectoryFailedCode where parseJSON = checked "BrowseDirectoryFailedCode" $ \value -> if value == String "peer-unavailable" then pure BrowseDirectoryFailedCodePeerU2d_unavailable else if value == String "not-found" then pure BrowseDirectoryFailedCodeNotU2d_found else if value == String "unauthorized" then pure BrowseDirectoryFailedCodeUnauthorized else if value == String "none-pending" then pure BrowseDirectoryFailedCodeNoneU2d_pending else fail "unknown enumeration member"

instance ToJSON BrowseDirectoryFailedCode where
  toJSON BrowseDirectoryFailedCodePeerU2d_unavailable = String "peer-unavailable"
  toJSON BrowseDirectoryFailedCodeNotU2d_found = String "not-found"
  toJSON BrowseDirectoryFailedCodeUnauthorized = String "unauthorized"
  toJSON BrowseDirectoryFailedCodeNoneU2d_pending = String "none-pending"
