module TestProcess (python) where

import System.Info qualified as System

-- Python's Windows installation supplies python.exe; Unix supplies python3.
python :: FilePath
python = if System.os == "mingw32" then "python" else "python3"
