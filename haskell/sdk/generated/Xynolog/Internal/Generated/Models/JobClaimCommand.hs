-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.JobClaimCommand (JobClaimCommand(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobFilter
import Xynolog.Internal.Generated.Models.UserId
data JobClaimCommand = JobClaimCommand
  { jobClaimCommandU5f_roles :: Maybe [Text]
  , jobClaimCommandU5f_userId :: Maybe UserId
  , jobClaimCommandAccepts :: [JobFilter]
  , jobClaimCommandAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON JobClaimCommand where parseJSON = checked "JobClaimCommand" $ withObject "JobClaimCommand" (\fields -> JobClaimCommand <$> optional fields "_roles" <*> optional fields "_userId" <*> (fields .: "accepts") <*> traverse parseJSON (withoutFields ["_roles", "_userId", "accepts"] fields))
instance ToJSON JobClaimCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_roles" (jobClaimCommandU5f_roles value), optionalPair "_userId" (jobClaimCommandU5f_userId value), [("accepts", toJSON (jobClaimCommandAccepts value))]]) <> fmap toJSON (withoutFields ["_roles", "_userId", "accepts"] (jobClaimCommandAdditionalProperties value)))
