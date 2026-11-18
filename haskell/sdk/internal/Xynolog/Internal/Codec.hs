{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Codec
  ( checked,
    optional,
    presence,
    optionalPair,
    presencePair,
    withoutFields,
  )
where

import Data.Aeson (FromJSON (..), Object, ToJSON (..), Value)
import Data.Aeson qualified as JSON
import Data.Aeson.Key (Key)
import Data.Aeson.KeyMap qualified as KM
import Data.Aeson.Types (Parser)
import Data.Text (Text)
import Xynolog.Internal.Generated.Schemas (schemas)
import Xynolog.Internal.Schema (validateNamed)
import Xynolog.Types.Presence (Presence (..))

checked :: Text -> (Value -> Parser value) -> Value -> Parser value
checked name parser value = either fail pure (validateNamed schemas name value) >> parser value

optional :: (FromJSON value) => Object -> Key -> Parser (Maybe value)
optional fields key = traverse parseJSON (KM.lookup key fields)

presence :: (FromJSON value) => Object -> Key -> Parser (Presence value)
presence fields key = case KM.lookup key fields of
  Nothing -> pure Absent
  Just JSON.Null -> pure Null
  Just value -> Present <$> parseJSON value

optionalPair :: (ToJSON value) => Key -> Maybe value -> [(Key, Value)]
optionalPair key = maybe [] (\value -> [(key, toJSON value)])

presencePair :: (ToJSON value) => Key -> Presence value -> [(Key, Value)]
presencePair _ Absent = []
presencePair key Null = [(key, JSON.Null)]
presencePair key (Present value) = [(key, toJSON value)]

withoutFields :: [Key] -> KM.KeyMap value -> KM.KeyMap value
withoutFields names = KM.filterWithKey (\key _ -> key `notElem` names)
