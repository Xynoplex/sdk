-- Generated from session/client-assertion-cases.json; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/constants.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.ClientAssertion (grantType, assertionType, lifetimeSeconds) where

import Data.Text (Text)

grantType :: Text
grantType = "client_credentials"

assertionType :: Text
assertionType = "urn:ietf:params:oauth:client-assertion-type:jwt-bearer"

lifetimeSeconds :: Integer
lifetimeSeconds = 60
