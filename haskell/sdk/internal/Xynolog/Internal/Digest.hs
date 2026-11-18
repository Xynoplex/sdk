-- | The unpadded base64url SHA-256 of a text's UTF-8.
module Xynolog.Internal.Digest (sha256Base64Url) where

import Crypto.Hash (Digest, SHA256, hash)
import Data.ByteArray qualified as Memory
import Data.ByteString.Base64.URL qualified as Base64
import Data.Text (Text)
import Data.Text.Encoding (decodeUtf8, encodeUtf8)

sha256Base64Url :: Text -> Text
sha256Base64Url text = decodeUtf8 (Base64.encodeUnpadded (Memory.convert (hash (encodeUtf8 text) :: Digest SHA256)))
