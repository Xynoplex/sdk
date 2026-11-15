-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.ReconciledSpan
  ( ReconciledSpan(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.AnchorMethod
import Xynolog.Internal.Generated.Models.MatchQuality
data ReconciledSpan = ReconciledSpan { reconciledSpanAnchorMethod :: AnchorMethod, reconciledSpanEnd :: Scientific, reconciledSpanExact :: Text, reconciledSpanMatchQuality :: Maybe (MatchQuality), reconciledSpanPrefix :: Maybe (Text), reconciledSpanStart :: Scientific, reconciledSpanSuffix :: Maybe (Text), reconciledSpanAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON ReconciledSpan where
  parseJSON = checked "ReconciledSpan" $ withObject "ReconciledSpan" (\fields -> ReconciledSpan <$> fields .: "anchorMethod" <*> fields .: "end" <*> fields .: "exact" <*> optional fields "matchQuality" <*> optional fields "prefix" <*> fields .: "start" <*> optional fields "suffix" <*> traverse parseJSON (withoutFields ["anchorMethod", "end", "exact", "matchQuality", "prefix", "start", "suffix"] fields))
instance ToJSON ReconciledSpan where toJSON value = Object (KM.fromList (concat [[("anchorMethod", toJSON (reconciledSpanAnchorMethod value))], [("end", toJSON (reconciledSpanEnd value))], [("exact", toJSON (reconciledSpanExact value))], optionalPair "matchQuality" (reconciledSpanMatchQuality value), optionalPair "prefix" (reconciledSpanPrefix value), [("start", toJSON (reconciledSpanStart value))], optionalPair "suffix" (reconciledSpanSuffix value)]) <> fmap toJSON (withoutFields ["anchorMethod", "end", "exact", "matchQuality", "prefix", "start", "suffix"] (reconciledSpanAdditionalProperties value)))
