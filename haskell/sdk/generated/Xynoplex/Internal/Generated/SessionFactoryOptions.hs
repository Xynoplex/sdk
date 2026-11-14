-- Generated from client/surface.json; do not edit.
module Xynoplex.Internal.Generated.SessionFactoryOptions where
import Xynoplex.Types (KnowledgeBase)
import qualified Xynoplex.SessionStorage as Storage
import qualified Xynoplex.State.SessionSignals as Signals
data SessionFactoryOptions = SessionFactoryOptions
  { sessionFactoryOptionsKb :: KnowledgeBase
  , sessionFactoryOptionsStorage :: Storage.SessionStorage
  , sessionFactoryOptionsSignals :: Signals.SessionSignals
  }
