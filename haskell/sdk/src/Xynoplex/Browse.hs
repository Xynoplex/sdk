-- | Live knowledge-base queries, resource content, and viewer signals.
module Xynoplex.Browse
  ( BrowseNamespace, resource, resources, annotations, annotation, entityTypes, tagSchemas, engines, events
  , resourceContent, resourceGraph, resourceAnchoredText, resourceRepresentation, resourceRepresentationStream
  , resourceEvents, annotationHistory, files, kb, click, openResource, resourceViewed
  ) where
import Xynoplex.Internal.Browse
