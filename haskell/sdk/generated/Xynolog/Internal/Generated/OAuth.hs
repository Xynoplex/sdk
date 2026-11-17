-- Generated from session/oauth.json; do not edit.
-- Regenerate: make generate (codegen/lib/oauth_clients/oauth_clients.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.OAuth (browserClientId, scriptClientId, signInScope) where
import Data.Text (Text)
browserClientId :: Text
browserClientId = "xynolog-browser"
scriptClientId :: Text
scriptClientId = "xynolog-cli"
signInScope :: Text
signInScope = "openid email profile offline_access"
