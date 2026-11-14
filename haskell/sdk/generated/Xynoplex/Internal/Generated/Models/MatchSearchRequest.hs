-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.MatchSearchRequest
  ( MatchSearchRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.AnnotationId
import Xynoplex.Internal.Generated.Models.GatheredContext
import Xynoplex.Internal.Generated.Models.ResourceId
data MatchSearchRequest = MatchSearchRequest { matchSearchRequestContext :: GatheredContext, matchSearchRequestLimit :: Maybe (Integer), matchSearchRequestReferenceId :: AnnotationId, matchSearchRequestResourceId :: ResourceId, matchSearchRequestUseSemanticScoring :: Maybe (Bool), matchSearchRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON MatchSearchRequest where
  parseJSON = checked "MatchSearchRequest" $ withObject "MatchSearchRequest" (\fields -> MatchSearchRequest <$> fields .: "context" <*> optional fields "limit" <*> fields .: "referenceId" <*> fields .: "resourceId" <*> optional fields "useSemanticScoring" <*> traverse parseJSON (withoutFields ["context", "limit", "referenceId", "resourceId", "useSemanticScoring"] fields))
instance ToJSON MatchSearchRequest where toJSON value = Object (KM.fromList (concat [[("context", toJSON (matchSearchRequestContext value))], optionalPair "limit" (matchSearchRequestLimit value), [("referenceId", toJSON (matchSearchRequestReferenceId value))], [("resourceId", toJSON (matchSearchRequestResourceId value))], optionalPair "useSemanticScoring" (matchSearchRequestUseSemanticScoring value)]) <> fmap toJSON (withoutFields ["context", "limit", "referenceId", "resourceId", "useSemanticScoring"] (matchSearchRequestAdditionalProperties value)))
