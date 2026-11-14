-- | Real sessions for consumer tests, over the real client the test supplies.
module Xynoplex.Testing.Client (TestSessionOptions(..), TestSession(..), createTestSession) where

import qualified Xynoplex.Client as Client
import Xynoplex.Retry (RetryOptions)
import qualified Xynoplex.Session as Session
import qualified Xynoplex.Timing.Settings as Timing

data TestSessionOptions = TestSessionOptions
  { testSessionOptionsClient :: Client.Client
  , testSessionOptionsSession :: Session.SessionOptions
  , testSessionOptionsClock :: RetryOptions
  , testSessionOptionsTiming :: Timing.Settings
  }
data TestSession = TestSession
  { testSessionSession :: Session.Session
  , closeTestSession :: IO ()
  }
createTestSession :: TestSessionOptions -> IO TestSession
createTestSession options = do
  session <- Session.newSession (testSessionOptionsClient options) (testSessionOptionsSession options)
    (testSessionOptionsClock options) (testSessionOptionsTiming options)
  pure (TestSession session (Session.dispose session))
