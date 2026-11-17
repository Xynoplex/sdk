-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.GatherFailed (GatherFailed(..), GatherFailedCode(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
data GatherFailed = GatherFailed
  { gatherFailedAnnotationId :: AnnotationId
  , gatherFailedCode :: Maybe GatherFailedCode
  , gatherFailedDetails :: Maybe Text
  , gatherFailedMessage :: Text
  , gatherFailedAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GatherFailed where parseJSON = checked "GatherFailed" $ withObject "GatherFailed" (\fields -> GatherFailed <$> (fields .: "annotationId") <*> optional fields "code" <*> optional fields "details" <*> (fields .: "message") <*> traverse parseJSON (withoutFields ["annotationId", "code", "details", "message"] fields))
instance ToJSON GatherFailed where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (gatherFailedAnnotationId value))], optionalPair "code" (gatherFailedCode value), optionalPair "details" (gatherFailedDetails value), [("message", toJSON (gatherFailedMessage value))]]) <> fmap toJSON (withoutFields ["annotationId", "code", "details", "message"] (gatherFailedAdditionalProperties value)))
data GatherFailedCode = GatherFailedCodePeerU2d_unavailable | GatherFailedCodeNotU2d_found | GatherFailedCodeUnauthorized | GatherFailedCodeNoneU2d_pending deriving (Eq, Show)
instance FromJSON GatherFailedCode where parseJSON = checked "GatherFailedCode" $ \value -> if value == String "peer-unavailable" then pure GatherFailedCodePeerU2d_unavailable else if value == String "not-found" then pure GatherFailedCodeNotU2d_found else if value == String "unauthorized" then pure GatherFailedCodeUnauthorized else if value == String "none-pending" then pure GatherFailedCodeNoneU2d_pending else fail "unknown enumeration member"
instance ToJSON GatherFailedCode where
  toJSON GatherFailedCodePeerU2d_unavailable = String "peer-unavailable"
  toJSON GatherFailedCodeNotU2d_found = String "not-found"
  toJSON GatherFailedCodeUnauthorized = String "unauthorized"
  toJSON GatherFailedCodeNoneU2d_pending = String "none-pending"
