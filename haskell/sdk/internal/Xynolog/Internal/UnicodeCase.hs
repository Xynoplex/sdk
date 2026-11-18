-- | Unicode's default lower-casing as the case-insensitive search does it
-- (annotations/reconcile-cases.json): every code point's full mapping, and a
-- capital sigma that ends a word lower-cased to the final form. Data.Text's
-- toLower takes the unconditional mappings alone, and Data.Char gives neither
-- Cased nor Case_Ignorable, so the tables are Unicode's own
-- (Xynolog.Internal.Generated.UnicodeCase).
module Xynolog.Internal.UnicodeCase (lowerChar, finalChar, isCased, caseIgnorable, whiteSpace) where

import Data.Char (ord)
import Data.IntMap.Strict qualified as Map
import Xynolog.Internal.Generated.UnicodeCase qualified as Table

-- | A character lower-cased, and lower-cased where it ends a word.
lowerChar, finalChar :: Char -> String
lowerChar char = Map.findWithDefault [char] (ord char) Table.lowercase
finalChar char = Map.findWithDefault (lowerChar char) (ord char) Table.finalLowercase

-- | Whether Unicode gives a character the Cased, the Case_Ignorable or the
-- White_Space property.
isCased, caseIgnorable, whiteSpace :: Char -> Bool
isCased char = within (ord char) Table.casedRanges
caseIgnorable char = within (ord char) Table.caseIgnorableRanges
whiteSpace char = within (ord char) Table.whiteSpaceRanges

within :: Int -> [(Int, Int)] -> Bool
within code ranges = case dropWhile ((< code) . snd) ranges of
  (start, _) : _ -> start <= code
  [] -> False
