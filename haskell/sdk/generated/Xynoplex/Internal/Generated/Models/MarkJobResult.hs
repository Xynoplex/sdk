-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.MarkJobResult
  ( MarkJobResult(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.JobDeclined
import Xynoplex.Internal.Generated.Models.MarkJobDone
data MarkJobResult = MarkJobResultBranch1 (MarkJobDone) | MarkJobResultBranch2 (JobDeclined) deriving (Eq, Show)
instance FromJSON MarkJobResult where
  parseJSON = checked "MarkJobResult" $ \value -> (MarkJobResultBranch1 <$> parseJSON value) <|> (MarkJobResultBranch2 <$> parseJSON value)
instance ToJSON MarkJobResult where
  toJSON (MarkJobResultBranch1 value) = toJSON value
  toJSON (MarkJobResultBranch2 value) = toJSON value
