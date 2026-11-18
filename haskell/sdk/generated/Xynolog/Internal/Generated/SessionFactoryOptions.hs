-- Generated from client/surface.json; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/constants.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.SessionFactoryOptions (SessionFactoryOptions (..)) where

import Xynolog.SessionStorage qualified as Storage
import Xynolog.State.SessionSignals qualified as Signals
import Xynolog.Types (KnowledgeBase)

data SessionFactoryOptions = SessionFactoryOptions
  { sessionFactoryOptionsKb :: KnowledgeBase,
    sessionFactoryOptionsStorage :: Storage.SessionStorage,
    sessionFactoryOptionsSignals :: Signals.SessionSignals
  }
