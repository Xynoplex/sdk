-- Generated from session/stored.json; do not edit.
-- Regenerate: make generate (codegen/lib/stored/stored.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Stored (knowledgeBasesKey, activeKey, openResourcesByKbKey, lastViewedResourceByKbKey, pendingAuthorizationKey, sessionKeyPrefix, lastEventIdKeyPrefix, cacheKeyPrefix) where

import Data.Text (Text)

knowledgeBasesKey :: Text
knowledgeBasesKey = "xynolog.knowledgeBases"

activeKey :: Text
activeKey = "xynolog.activeKnowledgeBaseId"

openResourcesByKbKey :: Text
openResourcesByKbKey = "xynolog.openResourcesByKb"

lastViewedResourceByKbKey :: Text
lastViewedResourceByKbKey = "xynolog.lastViewedResourceByKb"

pendingAuthorizationKey :: Text
pendingAuthorizationKey = "xynolog.pendingAuthorization"

sessionKeyPrefix :: Text
sessionKeyPrefix = "xynolog.session."

lastEventIdKeyPrefix :: Text
lastEventIdKeyPrefix = "xynolog.lastEventId."

cacheKeyPrefix :: Text
cacheKeyPrefix = "xynolog.cache."
