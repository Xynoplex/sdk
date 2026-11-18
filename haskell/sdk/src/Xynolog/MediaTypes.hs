{-# LANGUAGE OverloadedStrings #-}

module Xynolog.MediaTypes
  ( TextSource (..),
    baseMediaType,
    textSourceOf,
    derivesTextOf,
    yieldsGeometry,
    cloneFormat,
    storageFileName,
    mediaTypeOfExtension,
  )
where

import Data.List (find)
import Data.Map.Strict qualified as Map
import Data.Text (Text)
import Data.Text qualified as Text
import Xynolog.Internal.Generated.Text (TextSource (..))
import Xynolog.Internal.Generated.Text qualified as Fact

baseMediaType :: Text -> Text
baseMediaType = Text.toLower . Text.strip . Text.takeWhile (/= ';')

textSourceOf :: Text -> TextSource
textSourceOf format = case Map.lookup (baseMediaType format) Fact.mediaTypes of
  Just (_, source, _) -> source
  Nothing
    | "text/" `Text.isPrefixOf` baseMediaType format -> Decode
    | otherwise -> None

derivesTextOf :: Text -> Bool
derivesTextOf format = case textSourceOf format of
  Decode -> False
  PdfTextLayer -> True
  None -> False

yieldsGeometry :: Text -> Bool
yieldsGeometry format = case textSourceOf format of
  Decode -> False
  PdfTextLayer -> True
  None -> False

cloneFormat :: Maybe Text -> Text
cloneFormat Nothing = "text/plain"
cloneFormat (Just format) =
  let base = baseMediaType format
   in case Map.lookup base Fact.mediaTypes of
        Just (_, _, True) -> base
        _ -> "text/plain"

storageFileName :: Text -> Text -> Either Text Text
storageFileName name format = case Map.lookup (baseMediaType format) Fact.mediaTypes of
  Nothing -> Left "unregistered storage media type"
  Just (extension, _, _) ->
    let wordsOf = filter (not . Text.null) (Text.split (\c -> not ((c >= 'a' && c <= 'z') || (c >= '0' && c <= '9'))) (Text.toLower name))
     in Right (Text.intercalate "-" wordsOf <> extension)

mediaTypeOfExtension :: Text -> Maybe Text
mediaTypeOfExtension extension =
  let lower = Text.toLower extension
      canonical = Map.findWithDefault lower lower Fact.aliases
   in snd <$> find ((== canonical) . fst) Fact.extensions
