-- Generated from client/surface.json; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/constants.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.SessionFactoryOptions (SessionFactoryOptions(..)) where
import Xynolog.Types (KnowledgeBase)
import qualified Xynolog.SessionStorage as Storage
import qualified Xynolog.State.SessionSignals as Signals
data SessionFactoryOptions = SessionFactoryOptions
  { sessionFactoryOptionsKb :: KnowledgeBase
  , sessionFactoryOptionsStorage :: Storage.SessionStorage
  , sessionFactoryOptionsSignals :: Signals.SessionSignals
  }
