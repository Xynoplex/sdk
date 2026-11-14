-- | The shared storage keys and sign-in document of a registry.
module Xynoplex.Registry.Stored
  ( StoredSession(..), knowledgeBasesKey, activeKey, openResourcesByKbKey
  , lastViewedResourceByKbKey, sessionKey, storedSession, storeSession, clearStoredSession, kbOfSessionKey, loadKnowledgeBases, saveKnowledgeBases, keptIn
  ) where
import Xynoplex.Internal.Stored
import Xynoplex.Internal.SignIn (keptIn)
