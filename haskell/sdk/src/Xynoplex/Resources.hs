module Xynoplex.Resources (getPrimaryRepresentation, getPrimaryMediaType, getResourceEntityTypes, decodeRepresentation) where

import Data.Text (Text)
import Xynoplex.Internal.Text (decodeRepresentation)
import Xynoplex.Types

getPrimaryRepresentation :: ResourceDescriptor -> Maybe Representation
getPrimaryRepresentation resource = case resourceDescriptorRepresentations resource of
  ResourceDescriptorRepresentationsBranch1 representation -> Just representation
  ResourceDescriptorRepresentationsBranch2 (representation : _) -> Just representation
  ResourceDescriptorRepresentationsBranch2 [] -> Nothing
getPrimaryMediaType :: ResourceDescriptor -> Maybe Text
getPrimaryMediaType = fmap representationMediaType . getPrimaryRepresentation
getResourceEntityTypes :: ResourceDescriptor -> [Text]
getResourceEntityTypes = maybe [] id . resourceDescriptorEntityTypes
