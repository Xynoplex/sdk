-- | Real sessions for consumer tests, over the real client the test supplies.
module Xynolog.Testing.Client (TestSessionOptions(..), TestSession(..), createTestSession) where

import qualified Xynolog.Client as Client
import Xynolog.Retry (RetryOptions)
import qualified Xynolog.Session as Session
import qualified Xynolog.Timing.Settings as Timing

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
