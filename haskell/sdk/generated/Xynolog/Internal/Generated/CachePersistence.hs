-- Generated from session/stored.json and client/refresh.json; do not edit.
-- Regenerate: make generate (codegen/lib/stored/stored.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.CachePersistence (KeptQuery(..), keptQueryName, wholeKey, cacheDocumentVersion) where
import Data.Text (Text)
-- | The queries a client keeps across a restart, by their names in client/refresh.json.
data KeptQuery = Resource | Annotations | Annotation | EntityTypes | TagSchemas deriving (Eq, Ord, Show, Enum, Bounded)
keptQueryName :: KeptQuery -> Text
keptQueryName Resource = "resource"
keptQueryName Annotations = "annotations"
keptQueryName Annotation = "annotation"
keptQueryName EntityTypes = "entityTypes"
keptQueryName TagSchemas = "tagSchemas"
-- | The key a kept query that is per nothing (a `queries` row of specs/src/client/refresh.json with no `per`) keeps its one entry under.
wholeKey :: Text
wholeKey = "_"
-- | The form of the document. A document of another version is read as none.
cacheDocumentVersion :: Integer
cacheDocumentVersion = 1
