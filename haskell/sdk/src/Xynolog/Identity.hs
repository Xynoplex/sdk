{-# LANGUAGE OverloadedStrings #-}

-- | Knowledge-base and principal identities held to the shared identity tables.
module Xynolog.Identity (encodeUriComponent, kbDid, kbResource, personDid, agentDid) where

import Data.ByteString qualified as Bytes
import Data.Char (chr)
import Data.Text (Text)
import Data.Text qualified as Text
import Data.Text.Encoding (encodeUtf8)
import Xynolog.Internal.Generated.Principals qualified as Policy
import Xynolog.Types (UserId, mkUserId)

encodeUriComponent :: Text -> Text
encodeUriComponent = Text.concat . map escaped . Bytes.unpack . encodeUtf8
  where
    escaped byte
      | (byte >= 65 && byte <= 90)
          || (byte >= 97 && byte <= 122)
          || (byte >= 48 && byte <= 57)
          || chr (fromIntegral byte) `elem` ("-_.!~*'()" :: String) =
          Text.singleton (chr (fromIntegral byte))
      | otherwise = Text.pack ['%', hex (fromIntegral byte `div` 16), hex (fromIntegral byte `mod` 16)]
    hex value = "0123456789ABCDEF" !! value

kbDid :: Text -> Either String UserId
kbDid domain = mkUserId ("did:web:" <> domain)

kbResource :: Text -> Text
kbResource domain = "https://" <> Text.replace ":" "/" domain

personDid, agentDid :: Text -> Text -> Either String UserId
personDid domain subject = mkUserId (Text.replace "{subject}" (encodeUriComponent subject) (Text.replace "{domain}" domain Policy.person))
agentDid domain subject = mkUserId (Text.replace "{subject}" (encodeUriComponent subject) (Text.replace "{domain}" domain Policy.agent))
