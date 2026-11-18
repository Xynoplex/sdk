-- | Consumer test tools: scripted carriers, real sessions, shared storage,
-- and the executable liveness and exactly-once delivery axioms.
module Xynolog.Testing
  ( module Xynolog.Testing.Client,
    module Xynolog.Testing.Liveness,
    FaultAction (..),
    FaultyTransport,
    Respond,
    newFaultyTransport,
    ScriptedSessions,
    newScriptedSessions,
    SharedStorage,
    newSharedStorage,
  )
where

import Xynolog.Testing.Client
import Xynolog.Testing.Liveness
import Xynolog.Testing.Sessions (ScriptedSessions, newScriptedSessions)
import Xynolog.Testing.Storage (SharedStorage, newSharedStorage)
import Xynolog.Testing.Transport (FaultAction (..), FaultyTransport, Respond, newFaultyTransport)
