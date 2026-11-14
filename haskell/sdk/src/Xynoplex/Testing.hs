-- | Consumer test tools: scripted carriers, real sessions, shared storage,
-- and the executable liveness and exactly-once delivery axioms.
module Xynoplex.Testing
  ( module Xynoplex.Testing.Client, module Xynoplex.Testing.Liveness
  , FaultAction(..), FaultyTransport, Respond, newFaultyTransport
  , ScriptedSessions, newScriptedSessions, SharedStorage, newSharedStorage
  ) where
import Xynoplex.Testing.Client
import Xynoplex.Testing.Liveness
import Xynoplex.Testing.Transport (FaultAction(..), FaultyTransport, Respond, newFaultyTransport)
import Xynoplex.Testing.Sessions (ScriptedSessions, newScriptedSessions)
import Xynoplex.Testing.Storage (SharedStorage, newSharedStorage)
