-- Generated from protocol/specs/src/client/types/SearchState.json; do not edit.
-- Regenerate: make generate (codegen/lib/client_types/haskell.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.SearchState (SearchState (..)) where

import Data.Aeson (ToJSON (..), object, (.=))

data SearchState value = SearchState
  { searchStateResults :: [value],
    searchStateIsSearching :: Bool
  }
  deriving (Eq, Show)

instance (ToJSON value) => ToJSON (SearchState value) where toJSON record = object ["results" .= searchStateResults record, "isSearching" .= searchStateIsSearching record]
