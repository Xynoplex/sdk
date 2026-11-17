-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowseLinkClickedEvent (BrowseLinkClickedEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data BrowseLinkClickedEvent = BrowseLinkClickedEvent
  { browseLinkClickedEventHref :: Text
  , browseLinkClickedEventLabel :: Maybe Text
  , browseLinkClickedEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BrowseLinkClickedEvent where parseJSON = checked "BrowseLinkClickedEvent" $ withObject "BrowseLinkClickedEvent" (\fields -> BrowseLinkClickedEvent <$> (fields .: "href") <*> optional fields "label" <*> traverse parseJSON (withoutFields ["href", "label"] fields))
instance ToJSON BrowseLinkClickedEvent where toJSON value = Object (KM.fromList (concat [[("href", toJSON (browseLinkClickedEventHref value))], optionalPair "label" (browseLinkClickedEventLabel value)]) <> fmap toJSON (withoutFields ["href", "label"] (browseLinkClickedEventAdditionalProperties value)))
