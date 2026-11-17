-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.MatchResourcesResponse (MatchResourcesResponse(..), MatchResourcesResponseMatchKind(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceDescriptor
data MatchResourcesResponse = MatchResourcesResponse
  { matchResourcesResponseLimit :: Integer
  , matchResourcesResponseMatchKind :: MatchResourcesResponseMatchKind
  , matchResourcesResponseOffset :: Integer
  , matchResourcesResponseResources :: [ResourceDescriptor]
  , matchResourcesResponseTotal :: Integer
  , matchResourcesResponseAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON MatchResourcesResponse where parseJSON = checked "MatchResourcesResponse" $ withObject "MatchResourcesResponse" (\fields -> MatchResourcesResponse <$> (fields .: "limit") <*> (fields .: "matchKind") <*> (fields .: "offset") <*> (fields .: "resources") <*> (fields .: "total") <*> traverse parseJSON (withoutFields ["limit", "matchKind", "offset", "resources", "total"] fields))
instance ToJSON MatchResourcesResponse where toJSON value = Object (KM.fromList (concat [[("limit", toJSON (matchResourcesResponseLimit value))], [("matchKind", toJSON (matchResourcesResponseMatchKind value))], [("offset", toJSON (matchResourcesResponseOffset value))], [("resources", toJSON (matchResourcesResponseResources value))], [("total", toJSON (matchResourcesResponseTotal value))]]) <> fmap toJSON (withoutFields ["limit", "matchKind", "offset", "resources", "total"] (matchResourcesResponseAdditionalProperties value)))
data MatchResourcesResponseMatchKind = MatchResourcesResponseMatchKindLexical | MatchResourcesResponseMatchKindSemantic deriving (Eq, Show)
instance FromJSON MatchResourcesResponseMatchKind where parseJSON = checked "MatchResourcesResponseMatchKind" $ \value -> if value == String "lexical" then pure MatchResourcesResponseMatchKindLexical else if value == String "semantic" then pure MatchResourcesResponseMatchKindSemantic else fail "unknown enumeration member"
instance ToJSON MatchResourcesResponseMatchKind where
  toJSON MatchResourcesResponseMatchKindLexical = String "lexical"
  toJSON MatchResourcesResponseMatchKindSemantic = String "semantic"
