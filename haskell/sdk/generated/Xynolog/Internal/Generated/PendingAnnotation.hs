-- Generated from protocol/specs/src/client/types/PendingAnnotation.json; do not edit.
-- Regenerate: make generate (codegen/lib/client_types/haskell.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.PendingAnnotation (PendingAnnotation (..)) where

import Data.Aeson (ToJSON (..), object, (.=))
import Xynolog.Types (AnnotationSelector, Motivation)

data PendingAnnotation = PendingAnnotation
  { pendingAnnotationSelector :: AnnotationSelector,
    pendingAnnotationMotivation :: Motivation
  }
  deriving (Eq, Show)

instance ToJSON PendingAnnotation where toJSON record = object ["selector" .= pendingAnnotationSelector record, "motivation" .= pendingAnnotationMotivation record]
