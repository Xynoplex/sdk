-- Generated from protocol/specs/src/session/ClientSecretForm.json; do not edit.
-- Regenerate: make generate (codegen/lib/client_types/haskell.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.ServiceProof (secretProof) where

import Data.Text (Text)
import Xynolog.Internal.Generated.ClientAssertion qualified as Policy

secretProof :: Text -> Text -> [(Text, Text)]
secretProof identity secret = [("grant_type", Policy.grantType), ("client_id", identity), ("client_secret", secret)]
