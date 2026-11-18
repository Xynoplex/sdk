-- | The shared storage keys and sign-in document of a registry.
module Xynolog.Registry.Stored
  ( StoredSession (..),
    knowledgeBasesKey,
    activeKey,
    openResourcesByKbKey,
    lastViewedResourceByKbKey,
    sessionKey,
    storedSession,
    storeSession,
    clearStoredSession,
    kbOfSessionKey,
    loadKnowledgeBases,
    saveKnowledgeBases,
    keptIn,
  )
where

import Xynolog.Internal.SignIn (keptIn)
import Xynolog.Internal.Stored
