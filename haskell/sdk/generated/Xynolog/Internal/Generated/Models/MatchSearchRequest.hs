-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.MatchSearchRequest (MatchSearchRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
import Xynolog.Internal.Generated.Models.GatheredContext
import Xynolog.Internal.Generated.Models.ResourceId
data MatchSearchRequest = MatchSearchRequest
  { matchSearchRequestContext :: GatheredContext
  , matchSearchRequestLimit :: Maybe Integer
  , matchSearchRequestReferenceId :: AnnotationId
  , matchSearchRequestResourceId :: ResourceId
  , matchSearchRequestUseSemanticScoring :: Maybe Bool
  , matchSearchRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON MatchSearchRequest where parseJSON = checked "MatchSearchRequest" $ withObject "MatchSearchRequest" (\fields -> MatchSearchRequest <$> (fields .: "context") <*> optional fields "limit" <*> (fields .: "referenceId") <*> (fields .: "resourceId") <*> optional fields "useSemanticScoring" <*> traverse parseJSON (withoutFields ["context", "limit", "referenceId", "resourceId", "useSemanticScoring"] fields))
instance ToJSON MatchSearchRequest where toJSON value = Object (KM.fromList (concat [[("context", toJSON (matchSearchRequestContext value))], optionalPair "limit" (matchSearchRequestLimit value), [("referenceId", toJSON (matchSearchRequestReferenceId value))], [("resourceId", toJSON (matchSearchRequestResourceId value))], optionalPair "useSemanticScoring" (matchSearchRequestUseSemanticScoring value)]) <> fmap toJSON (withoutFields ["context", "limit", "referenceId", "resourceId", "useSemanticScoring"] (matchSearchRequestAdditionalProperties value)))
