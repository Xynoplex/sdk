-- Generated from principals/cases.json; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/constants.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Principals (person, agent) where
import Data.Text (Text)
person :: Text
person = "did:web:{domain}:users:{subject}"
agent :: Text
agent = "did:web:{domain}:agents:{subject}"
